import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/features/authentication/ui/sign_in_screen.dart';
import 'package:my_learn_gadgets_web/features/home/get_controllers/home_screen_get_controller.dart';
import 'package:my_learn_gadgets_web/features/profile/ui/profile_dashboard.dart';
import 'package:my_learn_gadgets_web/features/shopping_cart/ui/shopping_cart_screen.dart';
import 'package:my_learn_gadgets_web/features/wish_list/ui/wish_list_screen.dart';
import 'package:my_learn_gadgets_web/models/product_model.dart';

import '../../../core/app_string.dart';
import '../../checkout/ui/check_out_screen.dart';
import '../../product_details/ui/product_details_screen.dart';
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
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Get.offAll(() => SignInScreen());
                });
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: 8.0),
          child: Column(
            children: [
              Table(
                children: [
                  TableRow(children: [
                    GestureDetector(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null &&
                            FirebaseAuth.instance.currentUser!.email !=
                                AppString.emailForTemporaryLogin) {
                          Get.to(() => ProfileDashboard());
                        } else {
                          Get.to(() => SignInScreen(),
                              transition: Transition.cupertino);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.person,
                              color: AppColors.cardBgColor,
                              size: 30,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            AutoSizeText(
                              "My Account",
                              style: TextStyle(
                                color: AppColors.cardBgColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null &&
                            FirebaseAuth.instance.currentUser!.email !=
                                AppString.emailForTemporaryLogin) {
                          Get.to(() => const WishListScreen());
                        } else {
                          Get.to(() => SignInScreen(),
                              transition: Transition.cupertino);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: AppColors.cardBgColor,
                                  size: 30,
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection(AppString.users)
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .collection(AppString.wishList)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Visibility(
                                            visible: snapshot
                                                    .data!.docs.isNotEmpty &&
                                                FirebaseAuth.instance
                                                        .currentUser!.email !=
                                                    AppString
                                                        .emailForTemporaryLogin,
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Colors.red,
                                              child: Text(
                                                snapshot.data!.docs.length
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      }),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const AutoSizeText(
                              "Wish List",
                              style: TextStyle(
                                  color: AppColors.cardBgColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null &&
                            FirebaseAuth.instance.currentUser!.email !=
                                AppString.emailForTemporaryLogin) {
                          Get.to(() => ShoppingCartScreen());
                        } else {
                          Get.to(() => SignInScreen(),
                              transition: Transition.cupertino);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  color: AppColors.cardBgColor,
                                  size: 30,
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection(AppString.users)
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .collection(AppString.shoppingCart)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Visibility(
                                            visible: snapshot
                                                    .data!.docs.isNotEmpty &&
                                                FirebaseAuth.instance
                                                        .currentUser!.email !=
                                                    AppString
                                                        .emailForTemporaryLogin,
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Colors.red,
                                              child: Text(
                                                snapshot.data!.docs.length
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      }),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const AutoSizeText(
                              "Shopping Cart",
                              style: TextStyle(
                                  color: AppColors.cardBgColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null &&
                            FirebaseAuth.instance.currentUser!.email !=
                                AppString.emailForTemporaryLogin) {
                          Get.to(() => CheckOutScreen());
                        } else {
                          Get.to(() => SignInScreen(),
                              transition: Transition.cupertino);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.replay,
                              color: AppColors.cardBgColor,
                              size: 30,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            AutoSizeText(
                              "Checkout",
                              style: TextStyle(
                                  color: AppColors.cardBgColor, fontSize: 14),
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
              Container(
                height: Get.height * 0.5,
                color: AppColors.cardBgColorLight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
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
                          return Row(
                            children: [
                              Expanded(
                                child: CarouselSlider(
                                    items: products
                                        .map((product) => Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: NeumorphicButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      ProductDetailsScreen(
                                                          product: product));
                                                },
                                                style: const NeumorphicStyle(
                                                    shape:
                                                        NeumorphicShape.convex,
                                                    color: Colors.white,
                                                    depth: 1,
                                                    intensity: 0.5),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Expanded(
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child: Image
                                                                  .network(product
                                                                      .image))),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          AutoSizeText(
                                                            product.name,
                                                            maxLines: 3,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      AutoSizeText(
                                                        '${product.description}\n\n RAM: ${product.specification['Ram']!}|SSD: ${product.specification['SSD']!}',
                                                        maxLines: 3,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          AutoSizeText(
                                                            "\$${product.discountedPrice}",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .secondaryColor
                                                                    .shade300,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          AutoSizeText(
                                                            "\$${product.originalPrice}",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .secondaryColor,
                                                                fontSize: 12,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    options: CarouselOptions(
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                        viewportFraction: 0.4,
                                        enlargeFactor: 0.3)),
                              ),
                            ],
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Text(
                    "Featured Products",
                    style: TextStyle(
                        color: AppColors.secondaryColor.shade300,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                width: Get.width,
                height: Get.height * 0.5,
                color: AppColors.tertiaryColor[50],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
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
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...products.map((product) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: NeumorphicButton(
                                        onPressed: () {
                                          Get.to(() => ProductDetailsScreen(
                                              product: product));
                                        },
                                        style: const NeumorphicStyle(
                                            shape: NeumorphicShape.flat,
                                            color: Colors.white,
                                            depth: 1,
                                            intensity: 0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                          product.image))),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              AutoSizeText(
                                                product.name,
                                                maxLines: 3,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "\$${product.discountedPrice}",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .secondaryColor
                                                            .shade300,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    "\$${product.originalPrice}",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .secondaryColor,
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ),
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
