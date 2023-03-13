import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/features/authentication/ui/sign_in_screen.dart';

import '../../../core/app_colors.dart';
import '../../pending_orders/ui/pending_orders.dart';
import '../../widgets/card_tile.dart';
import '../../widgets/chart_card_tile.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Row(
              children: [
                Expanded(
                    child: Image.asset('assets/images/My learn gadgets.png')),
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
          ),
          body: Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: Material(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Products",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: const <Widget>[
                                  ChartCardTile(
                                    cardColor: Color(0xFF7560ED),
                                    cardTitle: 'Add Product',
                                    subText: 'March 2017',
                                    icon: Icons.add_circle,
                                    typeText: '',
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ChartCardTile(
                                    cardColor: Colors.green,
                                    cardTitle: 'All Product',
                                    subText: 'March 2017',
                                    icon: Icons.border_all_outlined,
                                    typeText: '35487',
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  ChartCardTile(
                                    cardColor: Colors.indigo,
                                    cardTitle: 'Refill Stock',
                                    subText: 'March 2017',
                                    icon: Icons.format_color_fill,
                                    typeText: '',
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ChartCardTile(
                                    cardColor: Color(0xFF25C6DA),
                                    cardTitle: 'Featured Product',
                                    subText: 'March 2017',
                                    icon: Icons.featured_video,
                                    typeText: '5487',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Orders",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: const <Widget>[
                                  CardTile(
                                    cardColor: Colors.white,
                                    cardTitle: 'Orders History',
                                    icon: Icons.history,
                                    subText: '3300',
                                    typeText: 'stdt',
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          transition: Transition.cupertino,
                                          () => PendingOrdersScreen());
                                    },
                                    child: const CardTile(
                                      cardColor: Colors.white,
                                      cardTitle: 'Pending Orders',
                                      icon: Icons.pending_actions,
                                      subText: 'Today',
                                      typeText: '230',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
