import 'dart:convert';

import 'package:dart_pi/src/api.dart';
import 'package:dart_pi/src/model/chat_completion_request.dart';
import 'package:dart_pi/src/model/message.dart';
import 'package:dart_pi/src/tool/get_forecast.dart';
import 'package:dart_pi/src/tool/list_tool.dart';
import 'package:dart_pi/src/tool/read_tool.dart';
import 'package:dart_pi/src/tool/tool.dart';
import 'package:mason_logger/mason_logger.dart';

final class Session {
  final _messages = <Message>[];

  List<Message> get messages => List.unmodifiable(_messages);

  void add(Message message) => _messages.add(message);
}

final class Agent {
  final Api _api;
  final Logger _logger;
  final Session _session = Session();
  final List<Tool> _tools = [GetForecast(), ListTool(), ReadTool()];

  new({required this._api, required this._logger, String? system}) {
    if (system != null) {
      _session.add(Message(role: 'system', content: system));
    }
  }

  Future<String> runTurn(String input) async {
    _session.add(Message(role: 'user', content: input));

    while (true) {
      final request = ChatCompletionRequest(
        model: 'gemma4:e2b',
        messages: _session.messages,
        tools: _tools,
      );
      final response = await _api.request(request);
      final responseMessage = response.choices.first.message;
      _session.add(responseMessage);
      _logger.info(responseMessage.reasoning);

      final toolCalls = responseMessage.toolCalls;
      if (toolCalls == null) {
        return responseMessage.content;
      }
      for (final call in toolCalls) {
        await _runToolCall(call);
      }
    }
  }

  Future<void> _runToolCall(Map<String, dynamic> call) async {
    final fn = call['function'] as Map<String, dynamic>;
    final args = jsonDecode(fn['arguments'] as String) as Map<String, dynamic>;

    final tool = _tools.firstWhere(
      (t) => t.name == fn['name'],
      orElse: () => throw Exception('Unkown tool: ${fn['name']}'),
    );
    _logger.success('Running tool: ${fn['name']} with arguments: $args');
    final response = await tool.run(args);
    _session.add(
      Message(
        role: 'tool',
        toolCallId: call['id'] as String?,
        content: response,
      ),
    );
  }
}
