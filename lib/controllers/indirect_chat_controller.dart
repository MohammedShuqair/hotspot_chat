import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hotspot_chat/controllers/network_controller.dart';
import 'package:hotspot_chat/data_sources/database/repositories/message_repository.dart';
import 'package:hotspot_chat/models/data_response.dart';
import 'package:hotspot_chat/models/indirect_message.dart';
import 'package:hotspot_chat/models/message.dart';
import 'package:hotspot_chat/models/user.dart';
import 'package:hotspot_chat/services/network/udp_endpoints/udp_endpoint.dart';
import 'package:hotspot_chat/utils/chat_id.dart';
import 'package:hotspot_chat/utils/message_sorter.dart';
import 'package:provider/provider.dart';

class IndirectChatController extends ChangeNotifier {
  DataResponse<List<Message>>? messages;

  late String chatId;
  final User messenger;
  final User other;
  final User current;
  late ScrollController scrollController;

  TextEditingController messageController = TextEditingController();
  late Timer timer;

  IndirectChatController(
    this.other,
    this.current,
    this.messenger,
  ) {
    chatId = ChatId.combine(current.deviceIdentifier!, other.deviceIdentifier!);
    scrollController = ScrollController();
    init();

    timer = Timer.periodic(Duration(minutes: 1), (d) {
      notifyListeners();
    });
  }

  void init() async {
    messages = DataResponse.loading();
    notifyListeners();
    try {
      List<Message> data = await MessageRepository().getMessages(chatId);
      data = MessageSorter.reverseMessages(data);
      messages = DataResponse.completed(data);
      notifyListeners();
    } catch (e) {
      messages = DataResponse.error(message: "error in getting messages");
    }
    notifyListeners();
  }

  void sendMessage(BuildContext context) {
    String messageContent = messageController.text.trim();
    if (messageContent.isNotEmpty && messenger.ip != null) {
      messageController.clear();
      Message message = Message(
          endpoint: UDPEndpoint.indirectMessage,
          chatId: chatId,
          content: messageContent,
          senderId: current.deviceIdentifier,
          receiverId: other.deviceIdentifier,
          sendAt: DateTime.now());

      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      context.read<NetworkController>().sendMessage(
          data: IndirectMessage(
                  endpoint: UDPEndpoint.indirectMessage,
                  thirdParty: other,
                  message: message)
              .toRawJson(),
          destinationIP: messenger.ip!);

      messages = DataResponse.more(data: messages?.data?..insert(0, message));
      notifyListeners();
      MessageRepository().addMessage(message);
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    timer.cancel();
    super.dispose();
  }
}
