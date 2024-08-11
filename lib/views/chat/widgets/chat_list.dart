import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/models/message.dart';
import 'package:hotspot_chat/models/user.dart';
import 'package:hotspot_chat/utils/date_formater.dart';
import 'package:hotspot_chat/views/chat/widgets/chat_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
    required this.scrollController,
    required this.messages,
    required this.other,
    required this.current,
  });

  final ScrollController scrollController;
  final List<Message> messages;
  final User other;
  final User current;

  TextDirection messageAlignment(Message message) {
    return message.currentIsSender(current.deviceIdentifier!)
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  String senderName(Message message) {
    return message.currentIsSender(current.deviceIdentifier!)
        ? current.name!
        : other.name!;
  }

  bool currentIsSender(Message message) {
    return message.currentIsSender(current.deviceIdentifier!);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      shrinkWrap: true,
      itemCount: messages?.length ?? 0,
      controller: scrollController,
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
      ),
      itemBuilder: (context, index) {
        var message = messages![index];
        return Directionality(
          key: ValueKey(message.sendAt?.millisecondsSinceEpoch ?? -1),
          textDirection: messageAlignment(message),
          child: ChatMessageCard(
            time: DateFormater.messageDate(message.sendAt!),
            message: messages[index].content!,
            name: senderName(message),
            isSender: currentIsSender(message),
          ),
        );
      },
    );
  }
}
