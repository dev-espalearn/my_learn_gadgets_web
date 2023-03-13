import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/features/search_by_category/get_controllers/search_by_category_get_controller.dart';

import '../../../core/app_colors.dart';
import '../../product_details/ui/product_details_screen.dart';

class SearchByCategoryScreen extends StatelessWidget {
  final String searchQuery;

  const SearchByCategoryScreen({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchByCategoryGetController searchByCategoryGetController =
        Get.put(SearchByCategoryGetController(searchQuery: searchQuery));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(searchQuery),
        ),
        body: Column(
          children: [
            Divider(
              thickness: 2,
              color: AppColors.primaryColor,
            ),
            Expanded(
              child: Obx(() {
                return searchByCategoryGetController.products.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => ProductDetailsScreen(
                                        product: searchByCategoryGetController
                                            .products[index],
                                      ));
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: Get.width / 4,
                                        child: Image.network(
                                            searchByCategoryGetController
                                                .products[index].image)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: AutoSizeText(
                                      searchByCategoryGetController
                                          .products[index].name,
                                      maxLines: 3,
                                    )),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColors.secondaryColor,
                              ),
                            ],
                          );
                        }),
                      )
                    : const Center(
                        child: Text('No Results for this search query'),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
