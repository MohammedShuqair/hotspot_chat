import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/models/user.dart';

class UserList extends StatelessWidget {
  const UserList({super.key, required this.users, this.onTap});

  final List<User> users;
  final Function(User user)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
      itemCount: users.length,
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.h),
        child: Divider(),
      ),
      itemBuilder: (context, index) {
        var user = users[index];
        return ListTile(
          onTap: () => onTap!(user),
          title: Text(user.name ?? 'name'),
        );
      },
    );
  }
}
