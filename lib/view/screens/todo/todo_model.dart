import 'dart:convert';

class TodoModel {
  String? title;
  String? des;
  String? id;

  TodoModel({
    this.title,
    this.des,
    this.id,
  });

  factory TodoModel.fromRawJson(String str) => TodoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    title: json["title"],
    des: json["des"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "des": des,
    "id": id,
  };
}
