import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';

import '../../../core/app_colors.dart';
import '../get_controllers/profile_get_controller.dart';

class ProfileDashboard extends StatelessWidget {
  ProfileDashboard({Key? key}) : super(key: key);

  ProfileGetController profileGetController = Get.put(ProfileGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
          appBar: AppBar(
            elevation: 0,
            title: const Text('My Profile'),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NeumorphicButton(
                    onPressed: () {
                      if (profileGetController.routing[index] != null) {
                        Get.to(() => profileGetController.routing[index]!);
                      }
                    },
                    style: const NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      color: Colors.white,
                      depth: 2,
                      intensity: 0.6,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                            profileGetController.options.keys.elementAt(index)),
                        Text(profileGetController.options.values
                            .elementAt(index)),
                      ],
                    ),
                  ),
                );
              },
              itemCount: profileGetController.options.length,
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                color: AppColors.primaryColor,
                depth: 1,
                intensity: 0.6,
              ),
              child: ListTile(
                  title: const Text(
                    "Subscribe to NewsLetter",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  trailing: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(AppString.users)
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Checkbox(
                            value: snapshot.data!.get('newsLetter'),
                            checkColor: Colors.white,
                            activeColor: AppColors.tertiaryColor,
                            onChanged: (bool? value) {
                              profileGetController.toggleNewsletter();
                            },
                          );
                        }
                        return const SizedBox();
                      })),
            ),
          ),
        ),
      ),
    );
  }
}
