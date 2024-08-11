import 'package:hotspot_chat/models/message.dart';

class MessageSorter {
  static List<Message> reverseMessages(List<Message> messages) {
    // Sort the list by `sendAt` in ascending order (oldest to newest)
    messages.sort((a, b) => a.sendAt!.compareTo(b.sendAt!));

    // Reverse the list to get descending order (newest to oldest)
    messages = messages.reversed.toList();
    return messages;
  }
}
