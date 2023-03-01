import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/features/authentication/ui/sign_in_screen.dart';

import '../get_controllers/sign_up_screen_get_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  SignUpScreenGetUpController getController =
      Get.put(SignUpScreenGetUpController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
          appBar: AppBar(elevation: 0,
              automaticallyImplyLeading: false,
              title: const Text('Sign Up',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Get.width / 4, vertical: 8.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: Get.height - kToolbarHeight,
                child: Form(
                  key: getController.formKey,
                  child: Column(
                    children: [
                      SizedBox(
                          width: Get.width / 1.4,
                          child: Image.asset(
                              'assets/images/My learn gadgets.png')),
                      const SizedBox(
                        height: 32,
                      ),
                      Neumorphic(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          color: Colors.white,
                          depth: -1,
                          intensity: 1,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            controller: getController.firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Neumorphic(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          color: Colors.white,
                          depth: -1,
                          intensity: 1,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            controller: getController.lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Neumorphic(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          color: Colors.white,
                          depth: -1,
                          intensity: 1,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            controller: getController.emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Neumorphic(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          color: Colors.white,
                          depth: -1,
                          intensity: 1,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Obx(() {
                            return TextFormField(
                              controller: getController.passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      getController.passwordVisible.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color:
                                          !getController.passwordVisible.value
                                              ? Colors.grey
                                              : Colors.blue),
                                  onPressed: () {
                                    getController.passwordVisible.value =
                                        !getController.passwordVisible.value;
                                  },
                                ),
                              ),
                              obscureText: !getController.passwordVisible.value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Neumorphic(
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          color: Colors.white,
                          depth: -1,
                          intensity: 1,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            controller: getController.passwordConfirmController,
                            decoration: const InputDecoration(
                              labelText: 'Password Confirm',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password confirm';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: const [
                            Text('Newsletter',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Text('Yes'),
                                Obx(() {
                                  return Radio(
                                    value: true,
                                    groupValue: getController.newsletter.value,
                                    onChanged: (value) {
                                      getController.newsletter.value = value!;
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Text('No'),
                                Obx(() {
                                  return Radio(
                                    value: false,
                                    groupValue: getController.newsletter.value,
                                    onChanged: (value) {
                                      getController.newsletter.value = value!;
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      //I have read and agree to the Privacy Policy
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            const Text(
                                'I have read and agree to the Privacy Policy',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            Obx(() {
                              return Checkbox(
                                value: getController.privacyPolicy.value,
                                onChanged: (value) {
                                  getController.privacyPolicy.value = value!;
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //submit
                      NeumorphicButton(
                        onPressed: () {
                          getController.signUpUsingEmailAndPassword();
                        },
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.tertiaryColor.shade600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                thickness: 1,
                color: AppColors.primaryColor,
              ),
              //already have an account
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Get.offAll(() => SignInScreen());
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.tertiaryColor.shade600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
