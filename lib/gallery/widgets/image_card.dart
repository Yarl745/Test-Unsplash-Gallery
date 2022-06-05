import 'package:flutter/material.dart';

import '../models/models.dart';

class ImageCard extends StatelessWidget {
  final Photo photo;
  const ImageCard({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
          margin: const EdgeInsets.all(8),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(photo.smallUrl, fit: BoxFit.cover),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          photo.username.length > 11
                              ? photo.username.substring(0, 9) + '...'
                              : photo.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow( // bottomLeft
                                  offset: Offset(-1.0, -1.0),
                                  color: Colors.black
                              ),
                              Shadow( // bottomRight
                                  offset: Offset(1.0, -1.0),
                                  color: Colors.black
                              ),
                              Shadow( // topRight
                                  offset: Offset(1.0, 1.0),
                                  color: Colors.black
                              ),
                              Shadow( // topLeft
                                  offset: Offset(-1.0, 1.0),
                                  color: Colors.black
                              ),
                            ]
                          )
                        )
                      )
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: CircleAvatar(backgroundImage: NetworkImage(photo.avatarUrl),)
                    )
                  ),
                ],
              )
              // Image.network(
              //   imgUrl,
              //   fit: BoxFit.cover,
              // )
          )
      )
  );
}