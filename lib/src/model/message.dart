import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    required String role,
    required String content,
    String? reasoning,
    @JsonKey(name: 'tool_calls', includeIfNull: false)
    List<Map<String, dynamic>>? toolCalls,
    @JsonKey(name: 'tool_call_id', includeIfNull: false) String? toolCallId,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
