import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinetalks/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/movie_model.dart';
import '../screens/movie_show_screen.dart';

class HorizontalScrollList extends StatelessWidget {
  final double boxWidth;
  final double boxHeight;
  final List<Map<String, dynamic>> items;

  const HorizontalScrollList(
      {Key? key,
      required this.boxWidth,
      required this.boxHeight,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.length == 0
        ? SizedBox(
            height: boxHeight + 16,
            child: Center(
                child: Text(
              "Looks like there's nothing here",
              style:
                  TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.5)),
            )),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // print(items[index].title);
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
                  child: GestureDetector(
                    key: Key(items[index]['id']),
                    onTap: () {
                      if (ModalRoute.of(context)!.settings.name != '/movie')
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MovieShowScreen(id: items[index]['id']),
                            settings: RouteSettings(name: '/movie'),
                          ),
                        );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image(
                            image: CachedNetworkImageProvider(
                                items[index]['imagePath']),
                            fit: BoxFit.cover,
                            width: boxWidth,
                            height: boxHeight,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: boxWidth,
                          child: Text(
                            items[index]['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.parent,
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
