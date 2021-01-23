class Inventaires {
  List<Map<String, dynamic>> products;
  String familyName;
  String id;
  String created;



  Inventaires(
      {
        this.products,
        this.familyName,
        this.id,
        this.created
      });

  Inventaires.fromMap(Map<String, dynamic> donnees)
      :products = donnees["products"],
        id = donnees["id"],
        created = donnees["created"],
        familyName = donnees["familyName"];

  Map<String, dynamic> toMap() {
    return {
      "products": products,
      "id": id,
      "created": created,
      "familyName": familyName,
    };
  }
}
