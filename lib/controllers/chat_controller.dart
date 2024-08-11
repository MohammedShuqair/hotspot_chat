import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:hotspot_chat/data_sources/database/repositories/message_repository.dart';
import 'package:hotspot_chat/models/data_response.dart';
import 'package:hotspot_chat/models/message.dart';
import 'package:hotspot_chat/models/user.dart';
import 'package:hotspot_chat/services/network/udp_endpoints/udp_endpoint.dart';
import 'package:hotspot_chat/services/network/udp_service/udp_service.dart';
import 'package:hotspot_chat/utils/message_sorter.dart';

class ChatController extends ChangeNotifier {
  DataResponse<List<Message>>? messages;
  final String chatId;
  final User other;
  final User current;
  late String ip;
  StreamSubscription? udpStreamSubscriptionGetter;
  late ScrollController scrollController;

  final UDPService udpService;
  TextEditingController messageController = TextEditingController();
  late Timer timer;

  ChatController(
      this.chatId, this.other, this.current, this.ip, this.udpService) {
    scrollController = ScrollController();
    init(chatId);

    timer = Timer.periodic(Duration(minutes: 1), (d) {
      notifyListeners();
    });
  }

  void updateIP(
    String newIP,
  ) {
    ip = newIP;
    notifyListeners();
  }

  void init(String chatId) async {
    messages = DataResponse.loading();
    notifyListeners();
    try {
      List<Message> data = await MessageRepository().getMessages(chatId);
      data = MessageSorter.reverseMessages(data);
      messages = DataResponse.completed(data);
      notifyListeners();
      listenToMessages();
    } catch (e) {
      messages = DataResponse.error(message: "error in getting messages");
    }
    notifyListeners();
  }

  void listenToMessages() {
    try {
      udpStreamSubscriptionGetter =
          udpService.messageStreamController.stream.listen((event) {
        print("add event $event");
        if (event['endpoint'] == UDPEndpoint.sendMessage) {
          Message message = Message.fromJson(event);
          if (message.chatId == chatId) {
            List<Message> newMessages = List.from(messages?.data ?? []);
            newMessages.insert(0, message);
            messages = DataResponse.more(data: newMessages);
            print("**** ${messages?.data?.first.content}");

            notifyListeners();
          }
        }
      });
    } catch (e) {
      print("error in listening to messages $e");
    }
  }

  void sendMessage() {
    try {
      String messageContent = messageController.text.trim();
      if (messageContent.isNotEmpty && (other.ip?.isNotEmpty ?? false)) {
        messageController.clear();
        Message message = Message(
            endpoint: UDPEndpoint.sendMessage,
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
        udpService.sendMessage(message.toRawJson(), InternetAddress(other.ip!));
        messages = DataResponse.more(data: messages?.data?..insert(0, message));
        notifyListeners();
        MessageRepository().addMessage(message);
      }
    } catch (e, s) {
      print("error $e");
      print("stack $s");
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    udpStreamSubscriptionGetter?.cancel();
    scrollController.dispose();
    timer.cancel();
    super.dispose();
  }
}
