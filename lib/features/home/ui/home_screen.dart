import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/features/authentication/ui/sign_in_screen.dart';
import 'package:my_learn_gadgets_web/features/home/get_controllers/home_screen_get_controller.dart';
import 'package:my_learn_gadgets_web/features/product_details/ui/product_details_screen.dart';
import 'package:my_learn_gadgets_web/features/profile/ui/profile_dashboard.dart';
import 'package:my_learn_gadgets_web/features/shopping_cart/ui/shopping_cart_screen.dart';
import 'package:my_learn_gadgets_web/features/wish_list/ui/wish_list_screen.dart';
import 'package:my_learn_gadgets_web/models/product_model.dart';

import '../../../core/app_string.dart';
import '../../search/ui/search_screen.dart';
import '../../search_by_category/ui/search_by_category_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeScreenGetController homeScreenGetController =
      Get.put(HomeScreenGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  controller: homeScreenGetController.searchController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: AppColors.secondaryColor,
                      ),
                      onPressed: () {
                        Get.to(
                            () => SearchScreen(
                                  searchQuery: homeScreenGetController
                                      .searchController.text
                                      .toLowerCase(),
                                ),
                            transition: Transition.cupertino);
                      },
                    ),
                  ),
                ),
              )),
        ),
        actions: [
          //logout iconbutton
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Get.offAll(() => SignInScreen());
                });
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 6005458603  My Account   Wish List (0)  Shopping Cart  Checkout
              Table(
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: NeumorphicButton(
                        onPressed: () {
                          if (FirebaseAuth.instance.currentUser != null &&
                              FirebaseAuth.instance.currentUser!.email !=
                                  AppString.emailForTemporaryLogin) {
                            Get.to(() => ProfileDashboard());
                          } else {
                            Get.to(() => SignInScreen(),
                                transition: Transition.cupertino);
                          }
                        },
                        style: const NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            color: Colors.white,
                            depth: 2,
                            intensity: 1),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: AppColors.secondaryColor.shade300,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "My Account",
                              style: TextStyle(
                                  color: AppColors.secondaryColor.shade300,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: NeumorphicButton(
                        onPressed: () {
                          if (FirebaseAuth.instance.currentUser != null &&
                              FirebaseAuth.instance.currentUser!.email !=
                                  AppString.emailForTemporaryLogin) {
                            Get.to(() => const WishListScreen());
                          } else {
                            Get.to(() => SignInScreen(),
                                transition: Transition.cupertino);
                          }
                        },
                        style: const NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            color: Colors.white,
                            depth: 2,
                            intensity: 1),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: AppColors.secondaryColor.shade300,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Wish List",
                              style: TextStyle(
                                  color: AppColors.secondaryColor.shade300,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: NeumorphicButton(
                        onPressed: () {
                          /*Get.to(() => const ShoppingCartScreen());*/
                          if (FirebaseAuth.instance.currentUser != null &&
                              FirebaseAuth.instance.currentUser!.email !=
                                  AppString.emailForTemporaryLogin) {
                            Get.to(() => ShoppingCartScreen());
                          } else {
                            Get.to(() => SignInScreen(),
                                transition: Transition.cupertino);
                          }
                        },
                        style: const NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            color: Colors.white,
                            depth: 2,
                            intensity: 1),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: AppColors.secondaryColor.shade300,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Shopping Cart",
                              style: TextStyle(
                                  color: AppColors.secondaryColor.shade300,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: NeumorphicButton(
                        onPressed: () {},
                        style: const NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            color: Colors.white,
                            depth: 2,
                            intensity: 1),
                        child: Row(
                          children: [
                            Icon(
                              Icons.replay,
                              color: AppColors.secondaryColor.shade300,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Checkout",
                              style: TextStyle(
                                  color: AppColors.secondaryColor.shade300,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),

              Divider(
                color: AppColors.primaryColor.shade300,
                thickness: 1,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(AppString.products)
                      .where(AppString.banner, isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProductModel> products = snapshot.data!.docs
                          .map((e) => ProductModel.fromJson(
                              jsonDecode(jsonEncode(e.data()))))
                          .toList();
                      return CarouselSlider(
                          items: products
                              .map((product) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(product.image)))
                              .toList(),
                          options: CarouselOptions(
                              height: Get.height / 3,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              viewportFraction: 0.5,
                              enlargeFactor: 0.5));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Text(
                    "Featured",
                    style: TextStyle(
                        color: AppColors.secondaryColor.shade300,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(AppString.products)
                      .where(AppString.featured, isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProductModel> products = snapshot.data!.docs
                          .map((e) => ProductModel.fromJson(
                              jsonDecode(jsonEncode(e.data()))))
                          .toList();
                      return CarouselSlider(
                          items: products
                              .map((product) => SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Wrap(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => ProductDetailsScreen(
                                                    product: product,
                                                  ));
                                            },
                                            child: Wrap(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                          product.image)),
                                                ),
                                                Text(
                                                  "Dell Latitude Laptop E5430 Intel Core I5 - 3340 Processor, 4Gb Ram & 256 Gb Ssd, Windows 10 Pro 14 Inches Notebook Computer",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .secondaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "₹ 50,000",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .secondaryColor
                                                              .shade500,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.02,
                                                    ),
                                                    Text(
                                                      "₹ 1,00,000",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .secondaryColor
                                                              .shade300,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: NeumorphicButton(
                                              onPressed: () {},
                                              style: const NeumorphicStyle(
                                                shape: NeumorphicShape.convex,
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.shopping_cart,
                                                    color: AppColors
                                                        .secondaryColor
                                                        .shade400,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Add to Cart",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .secondaryColor
                                                            .shade400,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              height: Get.height / 3,
                              enlargeCenterPage: false,
                              scrollDirection: Axis.horizontal,
                              viewportFraction: 0.5,
                              enlargeFactor: 0.5,
                              enableInfiniteScroll: true));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: SizedBox(
                    width: Get.width * 0.6,
                    child: Image.asset("assets/images/My learn gadgets.png")),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(AppString.categories)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<String> categories =
                          snapshot.data!.docs.map((e) => e.id).toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          String category = categories[index];
                          return Wrap(
                            children: [
                              ListTile(
                                title: Text(
                                  category,
                                ),
                                onTap: () {
                                  Get.to(() => SearchByCategoryScreen(
                                      searchQuery: category));
                                },
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColors.secondaryColor.shade200,
                                indent: 16,
                                endIndent: 16,
                              ),
                            ],
                          );
                        },
                        itemCount: categories.length,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
