import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/photo.dart';

const _initialUnsplashPage = 1;


class UnsplashRepository {
  final http.Client httpClient;

  UnsplashRepository({required this.httpClient});

  Future<List<Photo>> fetchPhotos({int startIndex = 0}) async{
    final page = _initialUnsplashPage + startIndex ~/ 10;
    final response = await httpClient.get(
        Uri.https(
            'api.unsplash.com',
            '/photos',
            {'client_id': 'ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9',
              'page': '$page',
            }
        )
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Photo(
            id: startIndex++,
            smallUrl: json['urls']['small'],
            bigUrl: json['urls']['regular'],
            username: json['user']['username'],
            avatarUrl: json['user']['profile_image']['medium']
        );
      }).toList();
    }
    throw Exception('error fetching photos');
  }
}