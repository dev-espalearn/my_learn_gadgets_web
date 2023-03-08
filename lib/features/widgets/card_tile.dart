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
      {
        // Key key,
        this.cardColor,
        this.cardTitle,
        this.subText,
        this.icon,
        this.typeText
      });
  //  : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(4),
      shadowColor: Colors.grey,
      color: cardColor,
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            _media.width >= 1280 ? EdgeInsets.all(15) : EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: cardColor,
            ),
            height: _media.height / 4,
            width: _media.width / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // Icon(icon, size: 30, color: Colors.black),
                    SizedBox(width: 40),
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
                        SizedBox(height: 5),
                        Text(subText!,
                            style:
                            TextStyle(fontSize: 12, color: Colors.black)),
                      ],
                    )
                  ],
                ),
               // Spacer(),
                Divider(),
                Text(
                  typeText!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                // SizedBox(height: 20),
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
                height: _media.height / 18,
                width: _media.width / 20,
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
