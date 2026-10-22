import 'package:dart_pi/src/api.dart';
import 'package:dart_pi/src/model/chat_completion_request.dart';
import 'package:dart_pi/src/model/message.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';

void main() async {
  final api = Api(Dio(), baseUrl: 'http://127.0.0.1:11434');
  final logger = Logger();

  while (true) {
    final input = logger.prompt('>>>');
    if (input.isEmpty) {
      return;
    }

    final request = ChatCompletionRequest(
      model: 'gemma4:e2b',
      messages: [Message(role: 'user', content: input)],
    );
    final response = await api.request(request);
    logger.success(response.choices.first.message.content);
  }
}
