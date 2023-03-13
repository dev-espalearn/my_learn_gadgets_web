import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../get_controllers/product_details_screen_get_controller.dart';

class DescriptionTab extends StatelessWidget {
  DescriptionTab({Key? key}) : super(key: key);

  ProductDetailsScreenGetController getController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Neumorphic(
          style: NeumorphicStyle(
            color: Colors.white,
            depth: 1,
            intensity: 5,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: Get.width * 0.4,
                        child: AutoSizeText(
                          '${getController.product.specification.keys.toList()[index]}: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.55,
                        child: AutoSizeText(
                          getController.product.specification.values
                              .toList()[index],
                          maxLines: 5,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: getController.product.specification.length,
            ),
          ),
        ),
      ),
    );
  }
}
