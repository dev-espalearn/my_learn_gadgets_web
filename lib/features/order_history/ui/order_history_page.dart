import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/helpers/date_time_helpers.dart';
import 'package:my_learn_gadgets_web/models/order_model.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_string.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Order History'),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(AppString.orders)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<OrderModel> orders = snapshot.data!.docs
                    .map((e) =>
                        OrderModel.fromJson(jsonDecode(jsonEncode(e.data()))))
                    .toList();
                return ListView.builder(
                  itemBuilder: (context, index) {
                    OrderModel order = orders[index];
                    ExpandableController expandableController =
                        ExpandableController();
                    return Neumorphic(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: Colors.white,
                        depth: 1,
                        intensity: 0.5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Text(order.customer.firstName[0],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Get.width * 0.02)),
                                  radius: Get.width * 0.02,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${order.customer.firstName} ${order.customer.lastName}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        order.customer.email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Order ID: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            order.id,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    AutoSizeText(
                                      order.address,
                                      maxLines: 5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      order.orderDate
                                          .getDateStringWithShortMonthName(),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.primaryColor,
                            ),
                            ExpandablePanel(
                              controller: expandableController,
                              collapsed: GestureDetector(
                                onTap: () {
                                  expandableController.toggle();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                              expanded: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      expandableController.toggle();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                  ...order.products.map((e) => Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(e.product.image),
                                            radius: Get.width * 0.02,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      e.product.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'x${e.quantity}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '₹${e.product.discountedPrice}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Divider(
                                      thickness: 1,
                                      color: AppColors.secondaryColor.shade100),
                                  Row(
                                    children: [
                                      Text(
                                        'Total: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Text(
                                        '₹${order.products.map((e) => e.product.discountedPrice * e.quantity).reduce((value, element) => value + element)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: orders.length,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
