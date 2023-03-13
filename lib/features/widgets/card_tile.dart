import 'package:flutter/material.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/features/widgets/responsive_widget.dart';



class CardTile extends StatelessWidget {
  final Color? cardColor;
  final String? cardTitle;
  final String? subText;
  final IconData? icon;
 final String? typeText;

  const CardTile(
      {super.key,
        this.cardColor,
        this.cardTitle,
        this.subText,
        this.icon,
        this.typeText
      });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(4),
      shadowColor: Colors.grey,
      color: cardColor,
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            media.width >= 1280 ? const EdgeInsets.all(15) : const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: cardColor,
            ),
            height: media.height / 4,
            width: media.width / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(width: 40),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        FittedBox(
                          child: Text(
                            cardTitle!,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: ResponsiveWidget.isLargeScreen(context)
                                  ? 18
                                  : 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(subText!,
                            style:
                            const TextStyle(fontSize: 12, color: Colors.black)),
                      ],
                    )
                  ],
                ),
                const Divider(),
                Text(
                  typeText!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: Material(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(4),
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: media.height / 18,
                width: media.width / 20,
                child: Icon(
                  icon,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
