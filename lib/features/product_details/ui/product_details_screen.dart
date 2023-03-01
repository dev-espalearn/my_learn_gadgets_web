import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/features/product_details/get_controllers/product_details_screen_get_controller.dart';
import 'package:my_learn_gadgets_web/features/product_details/ui/description_tab.dart';
import 'package:my_learn_gadgets_web/features/product_details/ui/product_tab.dart';
import 'package:my_learn_gadgets_web/features/product_details/ui/reviews_tab.dart';

import '../../../models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductDetailsScreenGetController getController =
        Get.put(ProductDetailsScreenGetController(product));
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ColoredBox(
                color: AppColors.primaryColor,
                child: const TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      child: AutoSizeText('Product',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1),
                    ),
                    Tab(
                      child: AutoSizeText(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      child: AutoSizeText('Reviews',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
              child: TabBarView(
                children: [
                  ProductsTab(),
                  DescriptionTab(),
                  ReviewsTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
