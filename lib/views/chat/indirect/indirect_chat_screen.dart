import 'package:flutter/material.dart';
import 'package:hotspot_chat/controllers/indirect_chat_controller.dart';
import 'package:hotspot_chat/views/chat/widgets/chat_list.dart';
import 'package:hotspot_chat/views/chat/widgets/chat_text_field.dart';
import 'package:provider/provider.dart';

class IndirectChatScreen extends StatelessWidget {
  const IndirectChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IndirectChatController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Indirect ${provider.messenger.name ?? ''} ${provider.other.name ?? ''}'),
          ),
          body: provider.messages?.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (message) => Center(child: Text(message)),
                completed: (messages) => ChatList(
                  scrollController: provider.scrollController,
                  messages: messages ?? [],
                  other: provider.other,
                  current: provider.current,
                ),
              ) ??
              SizedBox(),
          bottomNavigationBar: ChatTextField(
              messageController: provider.messageController,
              sendMessage: () => provider.sendMessage(context)),
        );
      },
    );
  }
}
