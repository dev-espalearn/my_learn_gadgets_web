import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';

import '../../../models/cart_item.dart';

class UserOrderHistoryDetail extends StatefulWidget {
  final List<CartItem> products;

  const UserOrderHistoryDetail({Key? key, required this.products})
      : super(key: key);

  @override
  State<UserOrderHistoryDetail> createState() => _UserOrderHistoryDetailState();
}

class _UserOrderHistoryDetailState extends State<UserOrderHistoryDetail> {
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
              'Orders History',
            ),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: 8),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 16),
                      separatorBuilder: (context, index) =>
                          Container(height: 8),
                      itemCount: widget.products.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        final tile = widget.products[index];
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
                                      child: Image.network(tile.product.image)),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          'Product id: ${tile.product.id}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          'Product name: ${tile.product.name}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          'Description: ${tile.product.description}',
                                          maxLines: 4,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          'Category: ${tile.product.category}',
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          'Ordered Quantity: ${tile.quantity.toString()}',
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          'Quantity Left: ${tile.product.quantityLeft.toString()}',
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
