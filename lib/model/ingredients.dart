class Ingredients {
  String id;
  String name;
  Ingredients({
    required this.id,
    required this.name,
  });

  Ingredients.fromjson(dynamic json)
      : id = json["_id"],
        name = json["name"];

  Map<String, dynamic> toJson() {
    return {"_id": id, "name": name};
  }
}
