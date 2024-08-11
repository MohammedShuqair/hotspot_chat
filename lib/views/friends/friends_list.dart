import 'package:flutter/material.dart';
import 'package:hotspot_chat/controllers/network_controller.dart';
import 'package:hotspot_chat/models/data_response.dart';
import 'package:hotspot_chat/models/user.dart';
import 'package:hotspot_chat/views/shared/user_list.dart';
import 'package:provider/provider.dart';

class FriendsList extends StatefulWidget {
  const FriendsList(
      {super.key, required this.onTapFriend, required this.getFriends});

  final Function(User user) onTapFriend;
  final Future<List<User>> Function(String currentDeviceId) getFriends;

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  DataResponse<List<User>>? users;

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  void getUsers() async {
    setState(() {
      users = DataResponse.loading();
    });
    try {
      String? deviceIdentifier =
          await context.read<NetworkController>().currentUser?.deviceIdentifier;
      if (deviceIdentifier != null) {
        final data = await widget.getFriends(deviceIdentifier);
        setState(() {
          users = DataResponse.completed(data);
        });
      } else {
        throw Exception("deviceIdentifier is null");
      }
    } catch (e, s) {
      print("error in getting users: $e _ $s");
      setState(() {
        users = DataResponse.error(message: "error in getting users");
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return users?.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(
              child: IconButton(
            onPressed: () {
              getUsers();
            },
            icon: const Icon(
              Icons.refresh,
            ),
          )),
          completed: (users) => users?.isEmpty ?? true
              ? Center(
                  child: Text("No friends found"),
                )
              : UserList(
                  users: users ?? [],
                  onTap: widget.onTapFriend,
                ),
        ) ??
        Center(
          child: Text("No friends found"),
        );
  }
}
