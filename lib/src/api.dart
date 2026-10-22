import 'package:dart_pi/src/model/chat_completion_request.dart';
import 'package:dart_pi/src/model/chat_completion_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory(Dio dio, {String? baseUrl}) = _Api;

  @POST('/v1/chat/completions')
  Future<ChatCompletionResponse> request(@Body() ChatCompletionRequest body);
}
