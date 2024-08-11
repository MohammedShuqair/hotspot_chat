import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/controllers/network_controller.dart';
import 'package:hotspot_chat/data_sources/shared_pref/shared_helper.dart';
import 'package:hotspot_chat/utils/colors.dart';
import 'package:hotspot_chat/views/shared/app_text_field.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  "Note",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 18.sp),
                ),
                Text(
                  "you cant change your name later",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 20.sp, color: AppColors.errorColor),
                ),
                SizedBox(
                  height: 30.h,
                ),
                AppTextField(
                  controller: controller,
                  hintText: "Please enter your name",
                  validator: (v) {
                    if (v?.isEmpty ?? true) {
                      return "Name cant be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      SharedHelper.instance
                          .setString(PrefKeys.userName, controller.text);
                      Provider.of<NetworkController>(context, listen: false)
                          .init();
                    }
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
