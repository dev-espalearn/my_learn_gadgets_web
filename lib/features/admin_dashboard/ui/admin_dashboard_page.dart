import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/features/authentication/ui/sign_in_screen.dart';
import 'package:my_learn_gadgets_web/features/order_history/ui/order_history_page.dart';

import '../../../core/app_colors.dart';
import '../../add_product/ui/add_product_screen.dart';
import '../../all_product/ui/all_product_screen.dart';
import '../../featured_product/ui/featured_product_screen.dart';
import '../../pending_orders/ui/pending_orders.dart';
import '../../refill_stock/ui/refill_stock_page.dart';
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
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          transition: Transition.cupertino,
                                          () => AddProductScreen());
                                    },
                                    child: const ChartCardTile(
                                      cardColor: Color(0xFF7560ED),
                                      cardTitle: 'Add Product',
                                      subText: '',
                                      icon: Icons.add_circle,
                                      typeText: '',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          transition: Transition.cupertino,
                                          () => AllProductScreen());
                                    },
                                    child: const ChartCardTile(
                                      cardColor: Colors.green,
                                      cardTitle: 'All Product',
                                      subText: '',
                                      icon: Icons.border_all_outlined,
                                      typeText: '',
                                    ),
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
                                      Get.to(() => const RefillStockPage());
                                    },
                                    child: const ChartCardTile(
                                      cardColor: Colors.indigo,
                                      cardTitle: 'Refill Stock',
                                      subText: '',
                                      icon: Icons.format_color_fill,
                                      typeText: '',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          transition: Transition.cupertino,
                                          () => FeaturedProductScreen());
                                    },
                                    child: const ChartCardTile(
                                      cardColor: Color(0xFF25C6DA),
                                      cardTitle: 'Featured Product',
                                      subText: '',
                                      icon: Icons.featured_video,
                                      typeText: '',
                                    ),
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
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          transition: Transition.cupertino,
                                          () => const OrderHistoryPage());
                                    },
                                    child: const CardTile(
                                      cardColor: Colors.white,
                                      cardTitle: 'Orders History',
                                      icon: Icons.history,
                                      subText: '',
                                      typeText: '',
                                    ),
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
                                      subText: '',
                                      typeText: '',
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
