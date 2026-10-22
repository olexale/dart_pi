import 'dart:io';

import 'package:dart_pi/src/tool/tool.dart';

final class ListTool extends Tool {
  @override
  String get description => "Lists the content of a directory";

  @override
  String get name => "list";

  @override
  Map<String, Object?> get parameters => {
    "type": "object",
    "properties": {
      "path": {
        "type": "string",
        "description":
            "The path to the directory to list (for example, 'lib/')",
      },
    },
    "required": ["path"],
  };

  @override
  Future<String> run(Map<String, dynamic> arg) async {
    final path = arg['path'] as String;
    final directory = Directory(path);
    if (!await directory.exists()) {
      throw Exception('Directory not found: $path');
    }
    final contents = await directory.list(recursive: true).toList();
    return contents.map((e) => e.path).join('\n');
  }
}
