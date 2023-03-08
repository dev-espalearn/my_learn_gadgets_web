import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/features/authentication/ui/sign_in_screen.dart';
import '../../../core/app_colors.dart';
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
          appBar:
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Row(
              children: [
                Expanded(child: Image.asset('assets/images/My learn gadgets.png')),
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
          body:
          Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth <= 800) {
                  return const Center(
                    child: Text('Mobile'),
                  );
                } else if (constraints.maxWidth <= 1280 &&
                    constraints.maxWidth >= 800) {
                  return
                    SingleChildScrollView(
                      child: Material(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //     MainAxisAlignment.start,
                            //     crossAxisAlignment:
                            //     CrossAxisAlignment.start,
                            //     children: const [
                            //       Text(
                            //         "Products",
                            //         style: TextStyle(fontSize: 24),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 8,
                            // ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Products",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                             mainAxisAlignment:
                             MainAxisAlignment.center,
                             crossAxisAlignment:
                             CrossAxisAlignment.center,
                             children: <Widget>[
                               Column(
                                 // mainAxisAlignment:
                                 // MainAxisAlignment.center,
                                 // crossAxisAlignment:
                                 // CrossAxisAlignment.center,
                                 children: <Widget>[

                                   ChartCardTile(
                                     cardColor:
                                     Color(0xFF7560ED),
                                     cardTitle: 'Add Product',
                                     subText: 'March 2017',
                                     icon: Icons.pie_chart,
                                     typeText: '',
                                   ),
                                   SizedBox(
                                     height: 20,
                                   ),
                                   ChartCardTile(
                                     cardColor:
                                     Colors.green,
                                     // Color(0xFF25C6DA),
                                     cardTitle: 'All Product',
                                     subText: 'March 2017',
                                     icon: Icons.cloud_upload,
                                     typeText: '35487',
                                   ),
                                 ],
                               ),
                               const SizedBox(
                                 width: 20,
                               ),
                               Column(
                                 mainAxisAlignment:
                                 MainAxisAlignment.center,
                                 crossAxisAlignment:
                                 CrossAxisAlignment.center,
                                 children: const <Widget>[
                                   ChartCardTile(
                                     cardColor:
                                     Colors.indigo,
                                     // Color(0xFF7560ED),
                                     cardTitle: 'Refill Stock',
                                     subText: 'March 2017',
                                     icon: Icons.pie_chart,
                                     typeText: '',
                                   ),
                                   SizedBox(
                                     height: 20,
                                   ),
                                   ChartCardTile(
                                     cardColor:
                                     Color(0xFF25C6DA),
                                     cardTitle:
                                     'Featured Product',
                                     subText: 'March 2017',
                                     icon: Icons.cloud_upload,
                                     typeText: '5487',
                                   ),
                                 ],
                               ),
                             ],
                              ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Orders",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(

                                  children: const <Widget>[

                                    CardTile(
                                      cardColor: Colors.white,
                                      cardTitle: 'Orders History',
                                      icon: Icons.show_chart,
                                      subText:
                                      '3300',
                                      typeText: 'stdt',
                                    //  mainText: '3.560',
                                    ),
                                    // ChartCardTile(
                                    //   cardColor:
                                    //   Colors.blueGrey,
                                    //   // Color(0xFF7560ED),
                                    //   cardTitle: 'Add Product',
                                    //   subText: 'March 2017',
                                    //   icon: Icons.pie_chart,
                                    //   typeText: '',
                                    // ),

                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: const <Widget>[
                                    CardTile(
                                      cardColor: Colors.white,
                                      cardTitle: 'Pending Orders',
                                      icon: Icons.flight_takeoff,
                                      subText: 'Todays',
                                      typeText: '230',
                                    ),
                                    // ChartCardTile(
                                    //   cardColor: Colors.white,
                                    //   // Color(0xFF7560ED),
                                    //   cardTitle: 'Refill Stock',
                                    //   subText: 'March 2017',
                                    //   icon: Icons.pie_chart,
                                    //   typeText: '',
                                    // ),

                                  ],
                                ),
                              ],
                            ),

                            // Row(
                            //   // mainAxisAlignment:
                            //   // MainAxisAlignment.start,
                            //   // crossAxisAlignment:
                            //   // CrossAxisAlignment.stretch,
                            //   children: <Widget>[
                            //     Padding(
                            //       padding: EdgeInsets.all(8.0),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //         MainAxisAlignment.start,
                            //         crossAxisAlignment:
                            //         CrossAxisAlignment.start,
                            //         children: const [
                            //           Text(
                            //             "Orders",
                            //             style: TextStyle(fontSize: 24),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     CardTile(
                            //       iconBgColor: Colors.orange,
                            //       cardTitle: 'Orders History',
                            //       icon: Icons.flight_takeoff,
                            //       subText: 'Todays',
                            //       mainText: '230',
                            //     ),
                            //     SizedBox(width: 20),
                            //     CardTile(
                            //       iconBgColor: Colors.pinkAccent,
                            //       cardTitle: 'Pending Orders',
                            //       icon: Icons.show_chart,
                            //       subText:
                            //       'Tracked from Google Analytics',
                            //       mainText: '3.560',
                            //     ),
                            //   ],
                            // ),

                          ],
                        ),
                      ),
                  ),
                    );
                }
                return Container(color: Colors.amber);
              },
            ),
          ),
        ),
      ),
    );
  }
}
