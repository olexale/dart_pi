import 'dart:io';

import 'package:dart_pi/src/tool/tool.dart';

final class ReadTool extends Tool {
  @override
  String get description => "Reads the content of a file";

  @override
  String get name => "read";

  @override
  Map<String, Object?> get parameters => {
    "type": "object",
    "properties": {
      "path": {"type": "string", "description": "The path to the file to read"},
    },
    "required": ["path"],
  };

  @override
  Future<String> run(Map<String, dynamic> arg) async {
    final path = arg['path'] as String;
    final file = File(path);
    if (!await file.exists()) {
      throw Exception('File not found: $path');
    }
    final content = await file.readAsString();
    return content;
  }
}
