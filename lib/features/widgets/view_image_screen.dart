import 'package:flutter/material.dart';

class ViewImageScreen extends StatelessWidget {
  final String link;
  final bool isLocal;
  final String heroTag;

  const ViewImageScreen(
      {Key? key,
      required this.link,
      this.isLocal = false,
      required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: isLocal
          ? Image.asset(link)
          : Image.network(
              link,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
    );
  }
}
