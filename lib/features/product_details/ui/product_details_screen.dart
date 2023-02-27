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

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

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
            appBar: NeumorphicAppBar(
                leading: NeumorphicButton(
                  style: const NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.white,
                    depth: 2,
                    intensity: 0.6,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                ),
                title: TabBar(
                  tabs: [
                    Tab(
                      child: AutoSizeText('Product',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                          maxLines: 1),
                    ),
                    Tab(
                      /*text: 'Reviews',*/
                      child: AutoSizeText(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      /*text: 'Offers',*/
                      child: AutoSizeText('Reviews',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                          maxLines: 1),
                    ),
                  ],
                )),
            body: TabBarView(
              children: [
                ProductsTab(),
                const DescriptionTab(),
                const ReviewsTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
