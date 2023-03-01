import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/features/authentication/ui/sign_in_screen.dart';

import '../../../core/app_colors.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
      appBar: AppBar(elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/My learn gadgets.png'),
        actions: [
          NeumorphicButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Get.offAll(() => SignInScreen());
              });
            },
            style: const NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 2,
                intensity: 0.4,
                color: Colors.white),
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      "Products",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              NeumorphicButton(
                onPressed: () {},
                style: const NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    depth: 2,
                    intensity: 0.4,
                    color: Colors.white),
                child: const ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Add Product"),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              NeumorphicButton(
                onPressed: () {},
                style: const NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    depth: 2,
                    intensity: 0.4,
                    color: Colors.white),
                child: const ListTile(
                  leading: Icon(Icons.list),
                  title: Text("All Products"),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              NeumorphicButton(
                onPressed: () {},
                style: const NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    depth: 2,
                    intensity: 0.4,
                    color: Colors.white),
                child: const ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text("Refill Stock"),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              NeumorphicButton(
                onPressed: () {},
                style: const NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    depth: 2,
                    intensity: 0.4,
                    color: Colors.white),
                child: const ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Choose Featured Product"),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      "Orders",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              NeumorphicButton(
                onPressed: () {},
                style: const NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    depth: 2,
                    intensity: 0.4,
                    color: Colors.white),
                child: const ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Orders History"),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              NeumorphicButton(
                onPressed: () {},
                style: const NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    depth: 2,
                    intensity: 0.4,
                    color: Colors.white),
                child: const ListTile(
                  leading: Icon(Icons.timelapse_sharp),
                  title: Text("Pending Orders"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
