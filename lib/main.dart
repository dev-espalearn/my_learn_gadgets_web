import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/features/admin_dashboard/ui/admin_dashboard_page.dart';
import 'package:my_learn_gadgets_web/features/home/ui/home_screen.dart';
import 'package:my_learn_gadgets_web/features/splash/ui/splash_page.dart';

import 'features/add_product/ui/add_product_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCdsWboXsUZfeDhL306DdA0cGk1v_bPctw",
        authDomain: "mylearngadgets.firebaseapp.com",
        projectId: "mylearngadgets",
        storageBucket: "mylearngadgets.appspot.com",
        messagingSenderId: "901492137645",
        appId: "1:901492137645:web:1ef817ef48e6148ec63024",
        measurementId: "G-LG0197V7WF"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      theme: NeumorphicThemeData(
        baseColor: AppColors.tertiaryColor,
        lightSource: LightSource.topLeft,
        depth: 3,
        intensity: 0.6,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(4)),
      ),
      debugShowCheckedModeBanner: false,
      home: GetMaterialApp(
        title: 'My Learn Gadgets',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          primarySwatch: AppColors.primaryColor,
          secondaryHeaderColor: AppColors.secondaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
