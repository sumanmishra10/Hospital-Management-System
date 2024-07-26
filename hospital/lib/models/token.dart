import 'dart:convert';

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  const Photo({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory Photo.fromJson(json) {
    return Photo(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
    );
  }
}
