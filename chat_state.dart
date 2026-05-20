import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';

class ChatState extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(
      role: MessageRole.user,
      content: 'Plan me a 3-day Tokyo itinerary focusing on food',
    ),
    ChatMessage(
      role: MessageRole.assistant,
      content:
          '**3-Day Tokyo Food Itinerary**\n\n*Day 1: Shibuya & Harajuku*\n• Breakfast: Tsukiji Outer Market\n• Lunch: Ichiran Ramen Shibuya\n• Dinner: Yakitori at Omoide Yokocho',
    ),
  ];

  String _selectedModel = 'GPT-4o';

  final List<String> availableModels = const [
    'GPT-4o',
    'Claude 3.5',
    'Gemini 2.0',
    'DeepSeek-R1',
  ];

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  String get selectedModel => _selectedModel;

  void selectModel(String model) {
    _selectedModel = model;
    notifyListeners();
  }

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;
    _messages.add(ChatMessage(role: MessageRole.user, content: content));
    notifyListeners();

    // Simulate AI response (replace with real API call)
    Future.delayed(const Duration(milliseconds: 600), () {
      _messages.add(ChatMessage(
        role: MessageRole.assistant,
        content:
            'This is a mock response from **$_selectedModel**. Connect a real API in `services/ai_service.dart` to enable live responses.',
      ));
      notifyListeners();
    });
  }
}
