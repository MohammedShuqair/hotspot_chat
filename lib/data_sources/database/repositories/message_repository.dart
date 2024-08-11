import 'package:hotspot_chat/data_sources/database/tables/data_base_helper.dart';
import 'package:hotspot_chat/data_sources/database/tables/tables.dart';
import 'package:hotspot_chat/models/message.dart';

class MessageRepository {
  String messagesTable = Tables.messages;

  MessageRepository();

  MessageRepository.indirect() : messagesTable = Tables.indirectMessages;

  Future<void> addMessage(Message message) async {
    await DatabaseHelper.instance
        .insert(messagesTable, message.toJson(withEndpoint: false));
  }

  Future<void> addMessages(List<Message> messages) async {
    for (Message message in messages) {
      await addMessage(message);
    }
  }

  Future<void> deleteMessage(int timestamp) async {
    await DatabaseHelper.instance.delete(messagesTable, timestamp);
  }

  /// delete all messages in a specific chat
  /// usually used after [getWhenReceiver] to clear space
  /// if [messagesTable] is [Tables.indirectMessages]
  Future<void> deleteWhenReceiver(String receiverId) async {
    await DatabaseHelper.instance
        .deleteWhere(messagesTable, "receiver_id", receiverId);
  }

  /// get all messages received by a specific user
  /// to see them to the receiver as Messenger
  Future<List<Message>> getWhenReceiver(String receiverId) async {
    List<Map<String, dynamic>> messages = await DatabaseHelper.instance
        .getWhen(messagesTable, "receiver_id", receiverId);
    return messages.map((e) => Message.fromJson(e)).toList();
  }

  Future<List<Message>> getMessages(String chatId) async {
    List<Map<String, dynamic>> messages =
        await DatabaseHelper.instance.getWhen(messagesTable, "chat_id", chatId);
    return messages.map((e) => Message.fromJson(e)).toList();
  }
}
