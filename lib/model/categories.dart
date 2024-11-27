class Category {
  String id;
  String name;
  Category({
    required this.id,
    required this.name,
  });

  Category.fromjson(dynamic json)
      : id = json["_id"],
        name = json["name"];

  Map<String, dynamic> toJson() {
    return {"_id": id, "name": name};
  }
}
