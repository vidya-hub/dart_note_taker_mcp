import 'package:dart_notes_mcp/note_handler_server.dart';

void main(List<String> arguments) {
  NotesHandlerServer server = NotesHandlerServer();
  server.start().then(
    (_) {
      print('Dart Notes MCP Server started successfully.');
    },
  ).catchError(
    (error) {
      print('Failed to start Dart Notes MCP Server: $error');
    },
  );
}
