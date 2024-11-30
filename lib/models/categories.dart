// To parse this JSON data, do
//
//     final categoryData = categoryDataFromJson(jsonString);

import 'dart:convert';

CategoryData categoryDataFromJson(String str) => CategoryData.fromJson(json.decode(str));

String categoryDataToJson(CategoryData data) => json.encode(data.toJson());

class CategoryData {
  List<CategoriesPage> categoriesPage;

  CategoryData({
    required this.categoriesPage,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    categoriesPage: List<CategoriesPage>.from(json["categories_page"].map((x) => CategoriesPage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories_page": List<dynamic>.from(categoriesPage.map((x) => x.toJson())),
  };
}

class CategoriesPage {
  String largeCategoriesImage;
  String categoryTitle;
  List<Video> videos;

  CategoriesPage({
    required this.largeCategoriesImage,
    required this.categoryTitle,
    required this.videos,
  });

  factory CategoriesPage.fromJson(Map<String, dynamic> json) => CategoriesPage(
    largeCategoriesImage: json["large_categories_image"],
    categoryTitle: json["category_title"],
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "large_categories_image": largeCategoriesImage,
    "category_title": categoryTitle,
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
  };
}

class Video {
  String title;
  String subTitle;
  String time;
  String videoUrl;
  String videoImage;
  String uniqueId;

  Video({
    required this.title,
    required this.subTitle,
    required this.time,
    required this.videoUrl,
    required this.videoImage,
    required this.uniqueId,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    title: json["title"],
    subTitle: json["sub_title"],
    time: json["time"],
    videoUrl: json["video_url"],
    videoImage: json["video_image"],
    uniqueId: json["unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "sub_title": subTitle,
    "time": time,
    "video_url": videoUrl,
    "video_image": videoImage,
    "unique_id": uniqueId,
  };
}
