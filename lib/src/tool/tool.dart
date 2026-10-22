abstract class Tool {
  String get name;
  String get description;
  Map<String, Object?> get parameters;

  Future<String> run(Map<String, dynamic> arg);
}
