// To parse this JSON data, do
//
//     final photos = photosFromJson(jsonString);

import 'dart:convert';

List<Photos> photosFromJson(String str) => List<Photos>.from(json.decode(str).map((x) => Photos.fromJson(x)));

String photosToJson(List<Photos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Photos {
  Photos({
    this.catId,
    this.catName,
    this.catPhotoUrl,
    this.photos = const [],
  });

  int? catId;
  String? catName;
  String? catPhotoUrl;
  List<String> photos;

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
    catId: json["cat_id"],
    catName: json["cat_name"],
    catPhotoUrl: json["cat_photo_url"],
    photos: json["photos"] == null ? [] : List<String>.from(json["photos"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
    "cat_photo_url": catPhotoUrl,
    "photos": List<dynamic>.from(photos.map((x) => x)),
  };
}
