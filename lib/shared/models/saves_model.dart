import 'dart:ui';

class SavesModel {
  final int id;
  final String title;
  final String distance;
  final String time;
  final String pace;
  final String speed;
  final String createdAt;

  SavesModel({
    required this.id,
    required this.title,
    required this.distance,
    required this.time,
    required this.pace,
    required this.speed,
    required this.createdAt,
  });

  factory SavesModel.fromJson(Map<String, dynamic> json) => SavesModel(
  id: json['id'],
  title: json['title'],
  distance: json['distance'],
  time: json['time'],
  pace: json['pace'],
  speed: json['speed'],
  createdAt: json['created_at'],
);
}