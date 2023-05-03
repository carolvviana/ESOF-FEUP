import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinetalks/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/movie_model.dart';
import '../screens/movie_show_screen.dart';

class VerticalScrollList extends StatelessWidget {
  final double boxWidth;
  final double boxHeight;
  final List<Movie> items;

  const VerticalScrollList(
      {Key? key,
      required this.boxWidth,
      required this.boxHeight,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     final aspectRatio = boxWidth / boxHeight;

    return Expanded(
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 8,
          mainAxisExtent: boxHeight + 40,
          // childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          // print(items[index].title);
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieShowScreen(id: items[index].id),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      image: CachedNetworkImageProvider(items[index].imagePath),
                      fit: BoxFit.cover,
                      width: boxWidth,
                      height: boxHeight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: boxWidth,
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textWidthBasis: TextWidthBasis.parent,
                      items[index].title,
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
