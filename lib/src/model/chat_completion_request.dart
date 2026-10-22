import 'package:dart_pi/src/model/message.dart';
import 'package:dart_pi/src/tool/tool.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_completion_request.freezed.dart';
part 'chat_completion_request.g.dart';

@freezed
abstract class ChatCompletionRequest with _$ChatCompletionRequest {
  const factory ChatCompletionRequest({
    required String model,
    required List<Message> messages,

    @JsonKey(
      includeIfNull: false,
      includeFromJson: false,
      includeToJson: true,
      toJson: _toolsToJson,
    )
    List<Tool>? tools,
  }) = _ChatCompletionRequest;

  factory ChatCompletionRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionRequestFromJson(json);
}

List<Map<String, dynamic>>? _toolsToJson(List<Tool>? tools) {
  if (tools == null) return null;
  return tools
      .map(
        (tool) => {
          "type": "function",
          "function": {
            "name": tool.name,
            "description": tool.description,
            "parameters": tool.parameters,
          },
        },
      )
      .toList();
}
