import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/features/product_details/ui/product_details_screen.dart';

import '../get_controllers/search_screen_get_controller.dart';

class SearchScreen extends StatelessWidget {
  final String searchQuery;

  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchScreenGetController searchScreenGetController =
        Get.put(SearchScreenGetController(searchQuery: searchQuery));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,
          title: Text('Search'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Divider(
              thickness: 2,
              color: AppColors.primaryColor,
            ),
            Expanded(
              child: Obx(() {
                return searchScreenGetController.products.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => ProductDetailsScreen(
                                        product: searchScreenGetController
                                            .products[index],
                                      ));
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: Get.width / 4,
                                        child: Image.network(
                                            searchScreenGetController
                                                .products[index].image)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: AutoSizeText(
                                      searchScreenGetController
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
