import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/features/pending_orders/ui/pending_order_detail.dart';
import 'package:my_learn_gadgets_web/helpers/date_time_helpers.dart';
import 'package:my_learn_gadgets_web/models/progress_model.dart';
import '../../../models/order_model.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../get_controller/user_track_order_get_controller.dart';



class UserTrackOrderScreen extends StatelessWidget {
  UserTrackOrderScreen({Key? key}) : super(key: key);


  UserTrackOrderGetController getController =
  Get.put(UserTrackOrderGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
          appBar: AppBar(
            elevation: 0,
            leading: const Icon(Icons.shopping_cart),
            title: const Text(
              'Track Orders',
            ),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: 8),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(AppString.orders)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<OrderModel> products = snapshot.data!.docs
                              .map((e) => OrderModel.fromJson(
                              jsonDecode(jsonEncode(e.data()))))
                              .toList();
                          List<OrderModel> productsUser = [];
                          for(int i=0; i<products.length; i++){
                            if(products[i].customer.email== getController.currentUser.value.email){
                              productsUser.add(products[i]);
                            }
                          }

                          return
                            ListView.builder(
                                itemBuilder: (context, index) {
                                  OrderModel order = productsUser[index];

                                 getController.setPercentage(order.progress);


                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4),
                                    child: Neumorphic(
                                      style: const NeumorphicStyle(
                                        shape: NeumorphicShape.flat,
                                        color: Colors.white,
                                        depth: 1,
                                        intensity: 1,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width / 5,
                                              child: const Image(
                                                image: AssetImage(
                                                  'assets/images/My learn gadgets.png',
                                                ),
                                                width: 60,
                                                height: 60,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    'Order Id: ${order.id}',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AutoSizeText(
                                                    'Customer name: ${order.customer.firstName}',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AutoSizeText(
                                                    'Order Date: ${order.orderDate.getDateStringWithMonthName()}',
                                                    maxLines: 4,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AutoSizeText(
                                                    'Estimated Delivery Date: ${order.estimatedDeliveryDate.getDateStringWithMonthName()}',
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AutoSizeText(
                                                    'Total no.of items: ${order.products.length}',
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),

                                                  AutoSizeText(
                                                    'Status: ${order.progress.name}',
                                                  ),

                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // GestureDetector(
                                                  //   onTap: () {
                                                  //     Get.to(
                                                  //         transition: Transition
                                                  //             .cupertino,
                                                  //             () =>
                                                  //             PendingOrderDetail(
                                                  //               products: order
                                                  //                   .products,
                                                  //             ));
                                                  //   },
                                                  //   child: Neumorphic(
                                                  //     style:
                                                  //     const NeumorphicStyle(
                                                  //       shape:
                                                  //       NeumorphicShape.flat,
                                                  //       color: Colors.white,
                                                  //       depth: -1,
                                                  //       intensity: 1,
                                                  //     ),
                                                  //     child: const Padding(
                                                  //       padding:
                                                  //       EdgeInsets.symmetric(
                                                  //           horizontal: 16,
                                                  //           vertical: 8.0),
                                                  //       child: Text(
                                                  //         'View all items',
                                                  //         style: TextStyle(
                                                  //             color:
                                                  //             Colors.black),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // const SizedBox(
                                                  //   height: 10,
                                                  // ),
                                              _AnimatedLiquidLinearProgressIndicator(progressModel: order.progress),


                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: products.length);
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedLiquidLinearProgressIndicator extends StatefulWidget {
  final ProgressModel progressModel;

  _AnimatedLiquidLinearProgressIndicator({Key? key, required this.progressModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidLinearProgressIndicatorState();
}

class _AnimatedLiquidLinearProgressIndicatorState
    extends State<_AnimatedLiquidLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;


  UserTrackOrderGetController getController =
  Get.put(UserTrackOrderGetController());


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animationController.addListener(() => setState(() {

    }));
  //  _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        width: double.infinity,
        height: 50.0,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Obx((){
          return
          LiquidLinearProgressIndicator(
            value: getController.percentage.value,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(AppColors.cardBgColor),
            borderRadius: 12.0,
            center: Text(
              widget.progressModel.name,
              style: TextStyle(
                color: AppColors.cardBgColorLight,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        ),
      ),
    );
  }
}
