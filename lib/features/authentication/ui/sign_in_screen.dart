import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/features/authentication/ui/sign_up_screen.dart';

import '../get_controllers/sign_in_get_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  SignInGetController getController = Get.put(SignInGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
            backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
            appBar: AppBar(elevation: 0,
              title: const Text('Sign In',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 4, vertical: 8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: Get.height - 2 * kToolbarHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: Get.width / 1.4,
                          child: Image.asset(
                              'assets/images/My learn gadgets.png')),
                      const SizedBox(
                        height: 32,
                      ),
                      Expanded(
                        child: Form(
                          key: getController.formKey,
                          child: Column(
                            children: [
                              Neumorphic(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.concave,
                                  color: Colors.white,
                                  depth: -1,
                                  intensity: 1,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    controller: getController.emailController,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Neumorphic(
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.concave,
                                  color: Colors.white,
                                  depth: -1,
                                  intensity: 1,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    controller:
                                        getController.passwordController,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              NeumorphicButton(
                                onPressed: () {
                                  getController.signIn();
                                },
                                style: const NeumorphicStyle(
                                  shape: NeumorphicShape.convex,
                                  color: Colors.white,
                                  depth: 4,
                                  intensity: 0.6,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: AppColors.tertiaryColor.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              TextButton(
                                  onPressed: () {
                                    getController.signInAsAdmin();
                                  },
                                  child: Text(
                                    'Sign in as admin',
                                    style: TextStyle(
                                        color: AppColors.secondaryColor),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: AppColors.primaryColor.shade600,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => SignUpScreen());
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.tertiaryColor.shade600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
