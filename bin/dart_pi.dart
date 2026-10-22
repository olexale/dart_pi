import 'package:dart_pi/src/agent.dart';
import 'package:dart_pi/src/api.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';

void main() async {
  final api = Api(Dio(), baseUrl: 'http://127.0.0.1:11434');
  final logger = Logger();
  final agent = Agent(api: api, logger: logger);

  while (true) {
    final input = logger.prompt('>>>');
    if (input.isEmpty) {
      return;
    }
    final response = await agent.runTurn(input);
    logger.success(response);
  }
}
