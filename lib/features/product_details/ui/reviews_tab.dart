import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({Key? key}) : super(key: key);

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
                child: Row(children: const [
                  Text('Total Ratings'),
                  SizedBox(
                    width: 16,
                  ),
                  Text("12",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                  RatingBar(
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.amber),
                      half: const Icon(Icons.star_half, color: Colors.amber),
                      empty: const Icon(Icons.star_border, color: Colors.amber),
                    ),
                    initialRating: 4.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    onRatingUpdate: (double value) {},
                    tapOnlyMode: true,
                    ignoreGestures: true,
                  ),
                ]),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                double ratings = 4.5;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
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
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/OIP2.jpeg'),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              AutoSizeText('John Doe')
                            ],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Expanded(
                              child: AutoSizeText(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Morbi tristique senectus et netus et malesuada fames ac turpis. Scelerisque felis imperdiet proin fermentum leo vel orci porta non. Nec dui nunc mattis enim. Id diam maecenas ultricies mi eget mauris pharetra et. Vitae tortor condimentum lacinia quis vel. Quam elementum pulvinar etiam non quam lacus suspendisse faucibus. Amet porttitor eget dolor morbi non arcu risus. Dolor morbi non arcu risus quis varius. Bibendum arcu vitae elementum curabitur vitae nunc sed.",
                            maxLines: 15,
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          RatingBar(
                            ratingWidget: RatingWidget(
                              full: const Icon(Icons.star, color: Colors.amber),
                              half: const Icon(Icons.star_half,
                                  color: Colors.amber),
                              empty: const Icon(Icons.star_border,
                                  color: Colors.amber),
                            ),
                            initialRating: ratings,
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
              itemCount: 12,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(AlertDialog(
            title: const Text('Rate this product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 16,
                ),
                const TextField(
                  decoration: InputDecoration(
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
                        half: const Icon(Icons.star_half, color: Colors.amber),
                        empty:
                            const Icon(Icons.star_border, color: Colors.amber),
                      ),
                      initialRating: 4.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      onRatingUpdate: (double value) {},
                      tapOnlyMode: true,
                      ignoreGestures: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                NeumorphicButton(
                  onPressed: () {},
                  style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(4)),
                    intensity: 5,
                    color: Colors.white,
                    shape: NeumorphicShape.convex,
                  ),
                  child: const Text('Submit'),
                )
              ],
            ),
          ));
        },
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(Icons.rate_review),
      ),
    );
  }
}
