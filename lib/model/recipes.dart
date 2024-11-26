class Recipes {
  String id;
  String name;
  String description;
  String author;
  String category;
  String image;

  Recipes({
    required this.id,
    required this.name,
    required this.description,
    required this.author,
    required this.category,
    required this.image,
  });

  Recipes.fromjson(dynamic json)
      : 
        id = json["_id"],
        name = json["name"],
        description = json["description"],
        author = json["author"],
        category = json["category"],
        image = json["image"];

  Map<String, dynamic> toJson() {
    return {
      "_id": id,  
      "name": name,
      "description": description,
      "author": author,
      "category": category,
      "image": image
    };
  }
}
