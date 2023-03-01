import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/features/product_details/get_controllers/product_details_screen_get_controller.dart';
import 'package:my_learn_gadgets_web/features/widgets/view_image_screen.dart';

import '../../../core/app_colors.dart';

class ProductsTab extends StatelessWidget {
  ProductsTab({Key? key}) : super(key: key);

  ProductDetailsScreenGetController getController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            child: AutoSizeText(
              getController.product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 4,
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Flexible(
            child: Row(
              children: [
                Text(
                  '₹ ${getController.product.discountedPrice}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor.shade300,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.04,
                ),
                Text(
                  '₹ ${getController.product.originalPrice}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor.shade300,
                    decoration: TextDecoration.lineThrough,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Neumorphic(
            style: const NeumorphicStyle(
                shape: NeumorphicShape.flat,
                color: Colors.white,
                depth: 1,
                intensity: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: Get.height * 0.25,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Stack(
                                  children: [
                                    Obx(() {
                                      return Hero(
                                          tag: getController
                                              .selectedImageLink.value,
                                          child: Image.network(getController
                                              .selectedImageLink.value));
                                    }),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: NeumorphicButton(
                                          onPressed: () {
                                            Get.to(() => ViewImageScreen(
                                                  link: getController
                                                      .selectedImageLink.value,
                                                  heroTag: getController
                                                      .selectedImageLink.value,
                                                  isLocal: true,
                                                ));
                                          },
                                          style: const NeumorphicStyle(
                                            shape: NeumorphicShape.convex,
                                            color: Colors.white,
                                            boxShape:
                                                NeumorphicBoxShape.circle(),
                                          ),
                                          child: Icon(
                                            Icons.image_search_sharp,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.primaryColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  CarouselSlider(
                      items: getController.product.secondaryImages
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: NeumorphicButton(
                                  onPressed: () {
                                    getController.selectedImageLink.value = e;
                                  },
                                  style: const NeumorphicStyle(
                                    shape: NeumorphicShape.concave,
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(e)),
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                          height: Get.height * 0.1,
                          viewportFraction: 0.2,
                          enableInfiniteScroll: false))
                ],
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            children: [
              NeumorphicButton(
                onPressed: () {},
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.add_shopping_cart,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              NeumorphicButton(
                onPressed: () {},
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.favorite,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              NeumorphicButton(
                onPressed: () {},
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.share,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
