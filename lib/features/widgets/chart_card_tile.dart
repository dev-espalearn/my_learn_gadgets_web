import 'package:flutter/material.dart';
import 'package:my_learn_gadgets_web/features/widgets/responsive_widget.dart';

class ChartCardTile extends StatelessWidget {
  final Color? cardColor;
  final String? cardTitle;
  final String? subText;
  final IconData? icon;
  final String? typeText;

  const ChartCardTile(
      {super.key,
      this.cardColor,
      this.cardTitle,
      this.subText,
      this.icon,
      this.typeText});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(4),
      shadowColor: Colors.grey,
      color: cardColor,
      child: Stack(
        children: <Widget>[
          Container(
            padding: media.width >= 1280
                ? const EdgeInsets.all(15)
                : const EdgeInsets.all(5),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon, size: 30, color: Colors.white),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          child: Text(
                            cardTitle!,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: ResponsiveWidget.isLargeScreen(context)
                                  ? 26
                                  : 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(subText!,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white)),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  typeText!,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
