import 'package:dart_pi/src/model/choice.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_completion_response.freezed.dart';
part 'chat_completion_response.g.dart';

@freezed
abstract class ChatCompletionResponse with _$ChatCompletionResponse {
  const factory ChatCompletionResponse({
    required String model,
    required List<Choice> choices,
  }) = _ChatCompletionResponse;

  factory ChatCompletionResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionResponseFromJson(json);
}
