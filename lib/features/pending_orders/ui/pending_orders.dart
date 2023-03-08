import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/features/pending_orders/ui/pending_order_detail.dart';
import 'package:my_learn_gadgets_web/helpers/date_time_helpers.dart';
import '../../../models/order_model.dart';

class PendingOrdersScreen extends StatelessWidget {
  PendingOrdersScreen({Key? key}) : super(key: key);

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
              'Pending Orders',
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
                          return ListView.builder(
                              itemBuilder: (context, index) {
                                OrderModel order = products[index];
                                return
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(transition: Transition.cupertino, () => PendingOrderDetail(products: order.products,));
                                    },
                                    child: Padding(
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
                                                child:
                                                const Image(
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
                                                  Neumorphic(
                                                    style: const NeumorphicStyle(
                                                      shape: NeumorphicShape.flat,
                                                      color: Colors.white,
                                                      depth: -1,
                                                      intensity: 1,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                              vertical: 8.0),
                                                      child: Text(
                                                        'View all items',
                                                        style: TextStyle(
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
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
