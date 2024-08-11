import 'package:flutter/material.dart';
import 'package:hotspot_chat/controllers/chat_controller.dart';
import 'package:hotspot_chat/services/navigation_service/navigation_service.dart';
import 'package:hotspot_chat/utils/colors.dart';
import 'package:hotspot_chat/views/chat/indirect/friend_select_screen.dart';
import 'package:hotspot_chat/views/chat/widgets/chat_list.dart';
import 'package:hotspot_chat/views/chat/widgets/chat_text_field.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.other.name ?? 'Chat'),
            surfaceTintColor: AppColors.primaryColor,
            actions: [
              IconButton(
                  onPressed: () {
                    NavigationService.navigateTo(FriendSelectScreen(
                      messenger: provider.other,
                      currentUser: provider.current,
                    ));
                  },
                  icon: Icon(Icons.transcribe))
            ],
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
            sendMessage: provider.sendMessage,
          ),
        );
      },
    );
  }
}
