// lib/models/chat_message.dart
class ChatMessage {
  final int? id;
  final String text;
  final bool isSent;
  final DateTime timestamp;
  final String? attachmentUrl;
  final String? messageStatus; // 'sent', 'delivered', 'read'

  ChatMessage({
    this.id,
    required this.text,
    required this.isSent,
    required this.timestamp,
    this.attachmentUrl,
    this.messageStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isSent': isSent ? 1 : 0,
      'timestamp': timestamp.toIso8601String(),
      'attachmentUrl': attachmentUrl,
      'messageStatus': messageStatus,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      text: map['text'],
      isSent: map['isSent'] == 1,
      timestamp: DateTime.parse(map['timestamp']),
      attachmentUrl: map['attachmentUrl'],
      messageStatus: map['messageStatus'],
    );
  }
}

