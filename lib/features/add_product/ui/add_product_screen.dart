import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../get_controllers/add_product_screen_get_controller.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  AddProductScreenGetController addProductScreenGetController =
      Get.put(AddProductScreenGetController());

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
        appBar: AppBar(
          elevation: 0,
          title: const Text('Add Product'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Form(
            key: addProductScreenGetController.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  children: [
                    Neumorphic(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: Colors.white,
                        depth: -1,
                        intensity: 1,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller:
                              addProductScreenGetController.nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Neumorphic(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: Colors.white,
                        depth: 1,
                        intensity: 0.6,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => DropdownButtonFormField<String>(
                            value: addProductScreenGetController
                                .chosenCategory.value,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                            ),
                            items: addProductScreenGetController.categories
                                .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                .toList(),
                            onChanged: (String? value) {
                              addProductScreenGetController.chosenCategory.value =
                                  value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a category';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Neumorphic(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                      //  color: AppColors.primaryColor.shade50.withOpacity(0.1),
                        depth: 2,
                        intensity: 0.6,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Specification',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Neumorphic(
                                    style: const NeumorphicStyle(
                                      shape: NeumorphicShape.concave,
                                      color: Colors.white,
                                      depth: -1,
                                      intensity: 1,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: TextFormField(
                                        controller: addProductScreenGetController
                                            .keyController,
                                        decoration: const InputDecoration(
                                          labelText: 'Key',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a specification';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Expanded(
                                  child: Neumorphic(
                                    style: const NeumorphicStyle(
                                      shape: NeumorphicShape.concave,
                                      color: Colors.white,
                                      depth: -1,
                                      intensity: 1,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: TextFormField(
                                        controller: addProductScreenGetController
                                            .valueController,
                                        decoration: const InputDecoration(
                                          labelText: 'Value',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a specification';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      addProductScreenGetController
                                          .addSpecification();
                                    },
                                    style: const NeumorphicStyle(
                                      shape: NeumorphicShape.convex,
                                      boxShape: NeumorphicBoxShape.stadium(),
                                      color: Colors.white,
                                      depth: 3,
                                      intensity: 0.6,
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.add),
                                        Text('Add Specification')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              height: Get.height * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(() {
                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                addProductScreenGetController
                                                    .specification.keys
                                                    .toList()[index]),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          Expanded(
                                            child: Text(
                                                addProductScreenGetController
                                                    .specification.values
                                                    .toList()[index]),
                                          )
                                        ],
                                      );
                                    },
                                    itemCount: addProductScreenGetController
                                        .specification.length,
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Neumorphic(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: Colors.white,
                        depth: -1,
                        intensity: 1,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller:
                              addProductScreenGetController.descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                          maxLines: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Neumorphic(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: Colors.white,
                        depth: -1,
                        intensity: 1,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller: addProductScreenGetController
                              .discountedPriceController,
                          decoration: const InputDecoration(
                            labelText: 'Discounted Price',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a discounted price';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Neumorphic(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: Colors.white,
                        depth: -1,
                        intensity: 1,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller: addProductScreenGetController
                              .originalPriceController,
                          decoration: const InputDecoration(
                            labelText: 'Original Price',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a original price';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(() {
                      return CheckboxListTile(
                        value: addProductScreenGetController.featured.value,
                        onChanged: (value) {
                          addProductScreenGetController.featured.value = value!;
                        },
                        title: const Text('Featured'),
                      );
                    }),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(() {
                      return CheckboxListTile(
                        value: addProductScreenGetController.banner.value,
                        onChanged: (value) {
                          addProductScreenGetController.banner.value = value!;
                        },
                        title: const Text('Banner'),
                      );
                    }),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return addProductScreenGetController
                                  .mainImagePath.value.isEmpty
                              ? Neumorphic(
                                  style: const NeumorphicStyle(
                                      color: Colors.white,
                                      depth: 1,
                                      intensity: 0.3),
                                  child: SizedBox(
                                      height: Get.height * 0.2,
                                      width: Get.width * 0.2,
                                      child: Center(
                                          child: Text(
                                        'No image selected.',
                                        style: TextStyle(
                                            color: AppColors.tertiaryColor),
                                      ))),
                                )
                              : SizedBox(
                                  height: Get.height * 0.2,
                                  width: Get.width * 0.2,
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        addProductScreenGetController
                                            .mainImagePath.value,
                                        width: Get.width * 0.2,
                                        height: Get.height * 0.2,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: NeumorphicButton(
                                          onPressed: () {
                                            addProductScreenGetController
                                                .mainImagePath.value = '';
                                          },
                                          style: const NeumorphicStyle(
                                            color: Colors.white,
                                            boxShape: NeumorphicBoxShape.circle(),
                                            depth: 3,
                                            intensity: 0.6,
                                          ),
                                          child: const Icon(Icons.close),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: NeumorphicButton(
                            style: const NeumorphicStyle(
                              color: Colors.white,
                              boxShape: NeumorphicBoxShape.stadium(),
                              depth: 3,
                              intensity: 0.6,
                            ),
                            onPressed: () async {
                              addProductScreenGetController.pickMainImage();
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.add_a_photo),
                                SizedBox(
                                  width: 8,
                                ),
                                Text('Pick Main Image'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Neumorphic(
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: Colors.white,
                        depth: -1,
                        intensity: 1,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller: addProductScreenGetController
                              .quantityLeftController,
                          decoration: const InputDecoration(
                            labelText: 'Quantity Left',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter quantity left';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(child: Obx(() {
                          return CarouselSlider(
                              items: addProductScreenGetController
                                      .secondaryImagesPath.isNotEmpty
                                  ? addProductScreenGetController
                                      .secondaryImagesPath
                                      .map((element) => Stack(
                                            children: [
                                              Image.network(element),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: NeumorphicButton(
                                                  onPressed: () {
                                                    addProductScreenGetController
                                                        .secondaryImagesPath
                                                        .remove(element);
                                                  },
                                                  style: const NeumorphicStyle(
                                                    color: Colors.white,
                                                    boxShape: NeumorphicBoxShape
                                                        .circle(),
                                                    depth: 3,
                                                    intensity: 0.6,
                                                  ),
                                                  child: const Icon(Icons.close),
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList()
                                  : [
                                      Center(
                                          child: Text(
                                        'No images selected.',
                                        style: TextStyle(
                                            color: AppColors.tertiaryColor),
                                      ))
                                    ],
                              options: CarouselOptions(
                                height: Get.height * 0.2,
                                enableInfiniteScroll: false,
                                viewportFraction: 0.3,
                              ));
                        })),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: NeumorphicButton(
                            style: const NeumorphicStyle(
                              color: Colors.white,
                              boxShape: NeumorphicBoxShape.stadium(),
                              depth: 3,
                              intensity: 0.6,
                            ),
                            onPressed: () async {
                              addProductScreenGetController.pickImages();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.add_a_photo),
                                SizedBox(
                                  width: 8,
                                ),
                                Text('Pick Images'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    NeumorphicButton(
                      style: const NeumorphicStyle(
                        color: Colors.white,
                        boxShape: NeumorphicBoxShape.stadium(),
                        depth: 3,
                        intensity: 0.6,
                      ),
                      onPressed: () async {
                        addProductScreenGetController.submit();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.tertiaryColor.shade700,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Submit',
                            style: TextStyle(
                                color: AppColors.tertiaryColor.shade700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
