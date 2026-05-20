enum MessageRole { user, assistant }

class ChatMessage {
  final MessageRole role;
  final String content;
  final DateTime timestamp;

  ChatMessage({
    required this.role,
    required this.content,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class Project {
  final String id;
  final String emoji;
  final String name;
  final String subtitle;
  final int chatCount;
  final List<int> gradientColors;

  Project({
    required this.id,
    required this.emoji,
    required this.name,
    required this.subtitle,
    required this.chatCount,
    required this.gradientColors,
  });
}

class MemoryItem {
  final String emoji;
  final String text;

  MemoryItem({required this.emoji, required this.text});
}
