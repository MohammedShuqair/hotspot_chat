import 'package:flutter/material.dart';
import 'package:hotspot_chat/controllers/indirect_chat_controller.dart';
import 'package:hotspot_chat/data_sources/database/repositories/user_repository.dart';
import 'package:hotspot_chat/models/user.dart';
import 'package:hotspot_chat/services/navigation_service/navigation_service.dart';
import 'package:hotspot_chat/views/chat/indirect/indirect_chat_screen.dart';
import 'package:hotspot_chat/views/friends/friends_list.dart';
import 'package:provider/provider.dart';

class FriendSelectScreen extends StatelessWidget {
  const FriendSelectScreen(
      {super.key, required this.messenger, required this.currentUser});

  final User messenger;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Friend'),
      ),
      body: FriendsList(
        onTapFriend: (other) {
          NavigationService.navigateTo(ChangeNotifierProvider(
            create: (BuildContext context) =>
                IndirectChatController(other, currentUser, messenger),
            child: IndirectChatScreen(),
          ));
        },
        getFriends: (String currentDeviceId) async {
          return await UserRepository.getUsersWithout(
              currentDeviceId, messenger.deviceIdentifier!);
        },
      ),
    );
  }
}
