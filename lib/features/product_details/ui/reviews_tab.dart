import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/features/authentication/ui/sign_in_screen.dart';
import 'package:my_learn_gadgets_web/models/review_model.dart';

import '../../../core/app_colors.dart';
import '../get_controllers/product_details_screen_get_controller.dart';

class ReviewsTab extends StatelessWidget {
  ReviewsTab({Key? key}) : super(key: key);

  ProductDetailsScreenGetController getController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                child: Row(children: [
                  const Text('Total Ratings'),
                  const SizedBox(
                    width: 16,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(AppString.products)
                          .doc(getController.product.id)
                          .collection(AppString.reviews)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            return Text(
                                snapshot.data!.docs
                                    .map((e) => ReviewModel.fromJson(
                                        jsonDecode(jsonEncode(e.data()))))
                                    .toList()
                                    .map((e) => e.rating)
                                    .toList()
                                    .reduce((value, element) =>
                                        (value + element) /
                                        snapshot.data!.docs.length)
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16));
                          }
                          return const Text('0.0',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16));
                        }
                        return const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                child: Row(children: [
                  const Text('Average Ratings:'),
                  const SizedBox(
                    width: 16,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(AppString.products)
                          .doc(getController.product.id)
                          .collection(AppString.reviews)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            return RatingBar(
                              ratingWidget: RatingWidget(
                                full:
                                    const Icon(Icons.star, color: Colors.amber),
                                half: const Icon(Icons.star_half,
                                    color: Colors.amber),
                                empty: const Icon(Icons.star_border,
                                    color: Colors.amber),
                              ),
                              initialRating: snapshot.data!.docs
                                  .map((e) => ReviewModel.fromJson(
                                      jsonDecode(jsonEncode(e.data()))))
                                  .toList()
                                  .map((e) => e.rating)
                                  .toList()
                                  .reduce((value, element) =>
                                      (value + element) /
                                      snapshot.data!.docs.length),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15,
                              onRatingUpdate: (double value) {},
                              tapOnlyMode: true,
                              ignoreGestures: true,
                            );
                          }
                          return RatingBar(
                            ratingWidget: RatingWidget(
                              full: const Icon(Icons.star, color: Colors.amber),
                              half: const Icon(Icons.star_half,
                                  color: Colors.amber),
                              empty: const Icon(Icons.star_border,
                                  color: Colors.amber),
                            ),
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 15,
                            onRatingUpdate: (double value) {},
                            tapOnlyMode: true,
                            ignoreGestures: true,
                          );
                        }
                        return const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }),
                ]),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(AppString.products)
                    .doc(getController.product.id)
                    .collection(AppString.reviews)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      List<ReviewModel> reviews = snapshot.data!.docs
                          .map((e) => ReviewModel.fromJson(
                              jsonDecode(jsonEncode(e.data()))))
                          .toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          ReviewModel review = reviews[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4.0),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(4)),
                                depth: 1,
                                intensity: 5,
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'Posted By',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        AutoSizeText(
                                          '${review.postedBy.firstName} ${review.postedBy.lastName}',
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        AutoSizeText(
                                          review.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        AutoSizeText(review.description,
                                            maxLines: 15,
                                            style:
                                                const TextStyle(fontSize: 16)),
                                      ],
                                    )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    RatingBar(
                                      ratingWidget: RatingWidget(
                                        full: const Icon(Icons.star,
                                            color: Colors.amber),
                                        half: const Icon(Icons.star_half,
                                            color: Colors.amber),
                                        empty: const Icon(Icons.star_border,
                                            color: Colors.amber),
                                      ),
                                      initialRating: review.rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15,
                                      onRatingUpdate: (double value) {},
                                      tapOnlyMode: true,
                                      ignoreGestures: true,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: reviews.length,
                      );
                    }
                    return const Center(
                      child: Text('No Reviews'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.email !=
                  AppString.emailForTemporaryLogin) {
            Get.dialog(AlertDialog(
              title: const Text('Rate this product'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: getController.reviewTitleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: getController.reviewDescriptionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Review',
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ratings:'),
                        RatingBar(
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.amber),
                            half: const Icon(Icons.star_half,
                                color: Colors.amber),
                            empty: const Icon(Icons.star_border,
                                color: Colors.amber),
                          ),
                          initialRating: 4.5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15,
                          onRatingUpdate: (double value) {
                            getController.ratings = value;
                          },
                          tapOnlyMode: true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        getController.submitReview();
                      },
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(4)),
                        intensity: 5,
                        color: Colors.white,
                        shape: NeumorphicShape.convex,
                      ),
                      child: const Text('Submit'),
                    )
                  ],
                ),
              ),
            ));
          } else {
            Get.offAll(() => SignInScreen());
          }
        },
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(Icons.rate_review),
      ),
    );
  }
}
