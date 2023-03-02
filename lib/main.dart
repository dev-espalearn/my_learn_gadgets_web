import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/features/splash/ui/splash_page.dart';

import 'features/unknown/unknown_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCdsWboXsUZfeDhL306DdA0cGk1v_bPctw",
        authDomain: "mylearngadgets.firebaseapp.com",
        projectId: "mylearngadgets",
        storageBucket: "mylearngadgets.appspot.com",
        messagingSenderId: "901492137645",
        appId: "1:901492137645:web:142fd6821226ed60c63024",
        measurementId: "G-YGNX3LHPLW"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Learn Gadgets',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primarySwatch: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.secondaryColor,
        fontFamily: 'Digitalt-04no.ttf'
      ),
      debugShowCheckedModeBanner: true,
      home: NeumorphicApp(
          theme: NeumorphicThemeData(
            baseColor: AppColors.tertiaryColor,
            lightSource: LightSource.topLeft,
            depth: 3,
            intensity: 0.6,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(4)),
          ),
          home: SplashPage()),
      unknownRoute: GetPage(
        name: '/unknown_route',
        page: () => const UnknownRoute(),
      ),
    );
  }
}
