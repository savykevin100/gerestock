class Facture {
  String customerName;
  String created;
  int amountTotal;
  List<Map<String, dynamic>> products;
  String id;
  String billingType;


  Facture({
    this.customerName,
    this.created,
    this.amountTotal,
    this.products,
    this.id,
    this.billingType
  });

  Facture.fromMap(Map<String, dynamic> donnees)
      : customerName = donnees["customerName"],
        created = donnees["created"],
        id = donnees["id"],
        amountTotal = donnees["amountTotal"],
        billingType = donnees["billingType"],
        products = donnees["products"];

  Map<String, dynamic> toMap() {
    return {
      "customerName": customerName,
      "created": created,
      "id": id,
      "products": products,
      "billingType": billingType,
      "amountTotal": amountTotal,
    };
  }
}
