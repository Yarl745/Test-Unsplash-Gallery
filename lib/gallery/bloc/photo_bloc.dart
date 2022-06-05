
import 'package:bloc/bloc.dart';
import 'package:unsplash_gallery_app/gallery/data/data.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';



import 'photo_event.dart';
import 'photo_state.dart';


const _throttleDuration = Duration(milliseconds: 200);


EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}


class PhotoBloc extends Bloc<PhotoEvent, PhotoState>{
  final UnsplashRepository repository;

  PhotoBloc({required this.repository}): super(const PhotoState()){
    on<PhotoFetched>(_onPhotoFetched, transformer: throttleDroppable(_throttleDuration),);
  }

  Future<void> _onPhotoFetched(PhotoFetched event, Emitter<PhotoState> emit) async {
    if (state.hasReachedMax) return;
    try{
      if (state.status == PhotoStatus.initial){
        final photos = await repository.fetchPhotos();
        return emit(state.copyWith(
          status: PhotoStatus.success,
          photos: photos,
          hasReachedMax: false
        ));
      }
      final photos = await repository.fetchPhotos(startIndex: state.photos.length);
      photos.isEmpty
          ? emit(state.copyWith(
              hasReachedMax: true
          ))
          : emit(state.copyWith(
              status: PhotoStatus.success,
              photos: List.of(state.photos)..addAll(photos),
              hasReachedMax: false
          ));
    } catch (_){
      emit(state.copyWith(status: PhotoStatus.failure));
    }
  }
}