class EntrerModels {
  String dateReceipt;
  String provider;
  String deliveryMan;
  List<Map<String, dynamic>> products;
  String id;
  String created;
  int amount;


  EntrerModels({
    this.dateReceipt,
    this.provider,
    this.deliveryMan,
    this.products,
    this.amount,
    this.created
  });

  EntrerModels.fromMap(Map<String, dynamic> donnees)
      : dateReceipt = donnees["dateReceipt"],
        provider = donnees["provider"],
        id = donnees["id"],
        deliveryMan = donnees["deliveryMan"],
        amount = donnees["amount"],
        created = donnees["created"],
        products = donnees["products"];

  Map<String, dynamic> toMap() {
    return {
      "dateReceipt": dateReceipt,
      "provider": provider,
      "id": id,
      "products": products,
      "amount": amount,
      "created": created,
      "deliveryMan": deliveryMan,
    };
  }
}
