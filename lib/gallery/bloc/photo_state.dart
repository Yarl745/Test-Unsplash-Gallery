import 'package:equatable/equatable.dart';

import '../models/models.dart';

enum PhotoStatus { initial, success, failure }

class PhotoState extends Equatable {
  final PhotoStatus status;
  final List<Photo> photos;
  final bool hasReachedMax;

  const PhotoState({
    this.status = PhotoStatus.initial,
    this.photos = const <Photo>[],
    this.hasReachedMax = false
  });

  PhotoState copyWith({PhotoStatus? status, List<Photo>? photos, bool? hasReachedMax}){
    return PhotoState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }

  @override
  String toString() {
    return 'PhotoState { status: $status, hasReachedMax: $hasReachedMax, photos: ${photos.length} }';
  }

  @override
  List<Object> get props => [status, photos, hasReachedMax];
}