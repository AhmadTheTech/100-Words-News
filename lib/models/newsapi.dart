// To parse this JSON data, do
//
//     final headline = headlineFromJson(jsonString);

import 'dart:convert';

List<Headline> headlineFromJson(String str) => List<Headline>.from(json.decode(str).map((x) => Headline.fromJson(x)));

String headlineToJson(List<Headline> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Headline {
  String title;
  AcfFields acfFields;

  Headline({
    required this.title,
    required this.acfFields,
  });

  factory Headline.fromJson(Map<String, dynamic> json) => Headline(
    title: json["title"],
    acfFields: AcfFields.fromJson(json["acf_fields"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "acf_fields": acfFields.toJson(),
  };
}

class AcfFields {
  String newsImage;
  String newsDescription;
  int uniqueId;

  AcfFields({
    required this.newsImage,
    required this.newsDescription,
    required this.uniqueId,
  });

  factory AcfFields.fromJson(Map<String, dynamic> json) => AcfFields(
    newsImage: json["news_image"],
    newsDescription: json["news_description"],
    uniqueId: json["unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "news_image": newsImage,
    "news_description": newsDescription,
    "unique_id": uniqueId,
  };
}
