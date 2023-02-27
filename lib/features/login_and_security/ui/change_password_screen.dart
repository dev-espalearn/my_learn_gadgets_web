import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
          appBar: NeumorphicAppBar(
            automaticallyImplyLeading: false,
            title: const Text('Change Password'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              children: [
                Divider(
                  thickness: 2,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email!,
                  style: TextStyle(
                    color: AppColors.tertiaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                /*TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();*/
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Neumorphic(
                          style: const NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            color: Colors.white,
                            depth: -2,
                            intensity: 1,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Old Password',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Neumorphic(
                          style: const NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            color: Colors.white,
                            depth: -2,
                            intensity: 1,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'New Password',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Neumorphic(
                          style: const NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            color: Colors.white,
                            depth: -2,
                            intensity: 1,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: NeumorphicButton(
                    style: const NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      color: Colors.white,
                      depth: 2,
                      intensity: 1,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.upload,
                          color: AppColors.tertiaryColor.shade700,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Submit',
                          style: TextStyle(
                              color: AppColors.tertiaryColor.shade700,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
