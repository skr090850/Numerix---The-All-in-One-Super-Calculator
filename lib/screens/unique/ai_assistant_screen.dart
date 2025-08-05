import 'package:flutter/material.dart';
import 'package:numerix/widgets/custom_app_bar.dart';
// TODO: AI Assistant Service ko import karna hai.

// Chat message ke liye ek simple model class.
class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initial greeting from AI
    _messages.add(ChatMessage(
      text: 'Hello! How can I help you with your calculations today?',
      isUser: false,
    ));
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    _textController.clear();

    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });

    // TODO: Yahan par AI Assistant Service ko call karna hai.
    // Abhi ke liye, ek dummy response use kar rahe hain.
    _getDummyResponse(text);
  }

  Future<void> _getDummyResponse(String query) async {
    // 2 second ka delay simulate kar rahe hain.
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _messages.insert(
          0, ChatMessage(text: 'This is a mocked response for: "$query"', isUser: false));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'AI Assistant'),
      body: Column(
        children: [
          // Chat messages area
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true, // List ko neeche se shuru karta hai.
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _buildMessageBubble(_messages[index]),
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
          const Divider(height: 1.0),
          // Text input area
          _buildTextComposer(),
        ],
      ),
    );
  }

  // Chat bubble banane wala widget.
  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Text input field banane wala widget.
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Ask a calculation question...',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
