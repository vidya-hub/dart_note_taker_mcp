from google.adk.agents import LlmAgent
from google.adk.tools.mcp_tool.mcp_toolset import MCPToolset, StdioServerParameters

root_agent = LlmAgent(
    model="gemini-2.0-flash",
    name="dart_note_agent",
    instruction="Help to file read and write operations and summarize it.",
    tools=[
        MCPToolset(
            connection_params=StdioServerParameters(
                command="D:\\Vidya_Projects\\dart_note_taker_mcp\\.fvm\\versions\\3.29.1\\bin\\dart.bat",
                args=[
                    "D:\\Vidya_Projects\\dart_note_taker_mcp\\dart_notes_mcp\\bin\\dart_notes_mcp.dart",
                ],
            )
        )
    ],
)
