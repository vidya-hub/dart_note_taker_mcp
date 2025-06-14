import 'dart:io';

class FileHandler {
  static final String _basedir =
      'D:\\Vidya_Projects\\dart_note_taker_mcp\\dart_notes_mcp\\notes';
  static Future<String> read(String fileName) async {
    final file = File('$_basedir/$fileName');
    if (!await file.exists()) {
      throw FileSystemException("File not found", file.path);
    }
    return await file.readAsString();
  }

  /// Writes the given content to the file (append if exists).
  static Future<void> write(String fileName, String content) async {
    final file = File('$_basedir/$fileName');

    if (await file.exists()) {
      await file.writeAsString(content, mode: FileMode.append);
    } else {
      await file.create(recursive: true);
      await file.writeAsString(content);
    }
  }

  /// Deletes the file.
  static Future<void> delete(String fileName) async {
    final file = File('$_basedir/$fileName');
    if (await file.exists()) {
      await file.delete();
    }
  }

  static Future<List<String>> list() async {
    final dir = Directory(_basedir);
    if (!await dir.exists()) {
      throw FileSystemException("Directory not found", dir.path);
    }
    final files = await dir.list().toList();
    return files.map((file) => file.path.split('/').last).toList();
  }
}
