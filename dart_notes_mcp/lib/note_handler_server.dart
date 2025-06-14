import 'package:dart_notes_mcp/file_handler.dart';
import 'package:mcp_dart/mcp_dart.dart';

class NotesHandlerServer {
  final McpServer server;

  NotesHandlerServer()
      : server = McpServer(
          Implementation(
            name: "Dart-Notes-Server",
            version: "1.0.0",
          ),
          options: ServerOptions(
            capabilities: ServerCapabilities(
              resources: ServerCapabilitiesResources(),
              tools: ServerCapabilitiesTools(),
            ),
          ),
        ) {
    registerCreateNoteHandler();
    registerReadNoteHandler();
    registerDeleteNoteHandler();
    registerListNotesHandler();
  }
  void registerReadNoteHandler() {
    server.tool(
      "readNote",
      description: 'Read Note with file name',
      inputSchemaProperties: {
        'fileName': {'type': 'string'},
      },
      callback: ({args, extra}) async {
        final fileName = args?['fileName'];
        try {
          final content = await FileHandler.read(fileName);
          return CallToolResult.fromContent(
            content: [
              TextContent(
                text: "Note content: $content",
              ),
            ],
          );
        } catch (e) {
          return CallToolResult.fromContent(
            content: [
              throw Exception('Failed to read note: $e'),
            ],
          );
        }
      },
    );
  }

  void registerDeleteNoteHandler() {
    server.tool(
      "deleteNote",
      description: 'Delete Note with file name',
      inputSchemaProperties: {
        'fileName': {'type': 'string'},
      },
      callback: ({args, extra}) async {
        final fileName = args?['fileName'];
        try {
          await FileHandler.delete(fileName);
          return CallToolResult.fromContent(
            content: [
              TextContent(
                text: "Note deleted successfully: $fileName",
              ),
            ],
          );
        } catch (e) {
          return CallToolResult.fromContent(
            content: [
              throw Exception('Failed to delete note: $e'),
            ],
          );
        }
      },
    );
  }

  void registerListNotesHandler() {
    server.tool(
      "listNotes",
      description: 'List all notes in the directory',
      callback: ({args, extra}) async {
        try {
          final notes = await FileHandler.list();
          return CallToolResult.fromContent(
            content: [
              TextContent(
                text: "Notes: ${notes.join(', ')}",
              ),
            ],
          );
        } catch (e) {
          return CallToolResult.fromContent(
            content: [
              throw Exception('Failed to list notes: $e'),
            ],
          );
        }
      },
    );
  }

  void registerCreateNoteHandler() {
    server.tool(
      "createNote",
      description:
          'Create Note with file name and content and append the content in new line if file already exists',
      inputSchemaProperties: {
        'fileName': {'type': 'string'},
        'content': {'type': 'string'},
      },
      callback: ({args, extra}) async {
        final fileName = args?['fileName'];
        final content = args?['content'];
        try {
          FileHandler.write(fileName, content);
          return CallToolResult.fromContent(
            content: [
              TextContent(
                text: "Note created successfully: $fileName",
              ),
            ],
          );
        } catch (e) {
          return CallToolResult.fromContent(
            content: [
              throw Exception('Failed to create note: $e'),
            ],
          );
        }
      },
    );
  }

  Future<void> start() async {
    await server.connect(StdioServerTransport());
  }
}
