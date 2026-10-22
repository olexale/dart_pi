import 'package:dart_pi/src/api.dart';
import 'package:dart_pi/src/model/chat_completion_request.dart';
import 'package:dart_pi/src/model/message.dart';
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

  new({required this._api, required this._logger, String? system}) {
    if (system != null) {
      _session.add(Message(role: 'system', content: system));
    }
  }

  Future<String> runTurn(String input) async {
    _session.add(Message(role: 'user', content: input));
    final request = ChatCompletionRequest(
      model: 'gemma4:e2b',
      messages: _session.messages,
    );
    final response = await _api.request(request);
    final responseMessage = response.choices.first.message;
    _session.add(responseMessage);
    _logger.info(responseMessage.reasoning);
    return responseMessage.content;
  }
}
