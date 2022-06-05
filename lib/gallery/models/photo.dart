import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  const Photo({required this.id, required this.smallUrl, required this.bigUrl,
    required this.username, required this.avatarUrl});

  final int id;
  final String smallUrl;
  final String bigUrl;
  final String username;
  final String avatarUrl;

  @override
  List<Object> get props =>  [id, smallUrl, username];
}