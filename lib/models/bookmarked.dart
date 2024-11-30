// To parse this JSON data, do
//
//     final checkedVideo = checkedVideoFromJson(jsonString);

import 'dart:convert';

CheckedVideo checkedVideoFromJson(String str) => CheckedVideo.fromJson(json.decode(str));

String checkedVideoToJson(CheckedVideo data) => json.encode(data.toJson());

class CheckedVideo {
  List<Record> records;

  CheckedVideo({
    required this.records,
  });

  factory CheckedVideo.fromJson(Map<String, dynamic> json) => CheckedVideo(
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
  };
}

class Record {
  int id;
  String userId;
  String videoId;
  DateTime dateAdded;
  String title;
  String description;
  String duration;
  String imageUrl;
  String uniqueId;

  Record({
    required this.id,
    required this.userId,
    required this.videoId,
    required this.dateAdded,
    required this.title,
    required this.description,
    required this.duration,
    required this.imageUrl,
    required this.uniqueId,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    userId: json["user_id"],
    videoId: json["video_id"],
    dateAdded: DateTime.parse(json["date_added"]),
    title: json["title"],
    description: json["description"],
    duration: json["duration"],
    imageUrl: json["image_url"],
    uniqueId: json["UniqueID"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "video_id": videoId,
    "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
    "title": title,
    "description": description,
    "duration": duration,
    "image_url": imageUrl,
    "UniqueID": uniqueId,
  };
}
