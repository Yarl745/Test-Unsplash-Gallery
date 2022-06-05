import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash_gallery_app/gallery/bloc/photo_event.dart';
import 'package:unsplash_gallery_app/gallery/data/data.dart';


import '../bloc/photo_bloc.dart';
import 'gallery_view.dart';


class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unsplash Gallery'),
          backgroundColor: Colors.black38, ),
      body: BlocProvider(
        create: (_) => PhotoBloc(repository: UnsplashRepository(httpClient: http.Client()))..add(PhotoFetched()),
        child: const GalleryView(),
      )
    );
  }
}
