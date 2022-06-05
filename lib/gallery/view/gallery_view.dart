import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/photo_bloc.dart';
import '../bloc/photo_event.dart';
import '../bloc/photo_state.dart';
import '../widgets/widgets.dart';
import 'photo_page.dart';


const int _columnCount = 2;


class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll(){
    if (_isBottom) BlocProvider.of<PhotoBloc>(context).add(PhotoFetched());//context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.75);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        switch (state.status){
          case PhotoStatus.failure:
            return const Center(child: Text('failed to fetch photos'));
          case PhotoStatus.success:
            if (state.photos.isEmpty){
              return const Center(child: Text('no photos :('));
            }
            return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _columnCount,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5
                ),
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.photos.length
                      ? const BottomLoader()
                      : GestureDetector(
                          child: ImageCard(photo: state.photos[index]),
                          onTap: (){Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PhotoPage(imgUrl: state.photos[index].bigUrl)));
                          },

                  );
                },
                itemCount: state.hasReachedMax
                    ? state.photos.length
                    : state.photos.length + 1,
                controller: _scrollController,
              );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
