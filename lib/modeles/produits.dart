class Produit {
  String productName;
  String buyingPrice;
  String sellPrice;
  int stockAlert;
  int physicalStock;
  String familyName;
  int theoreticalStock;
  String image;
  String id;




 Produit({
  this.productName,
  this.buyingPrice,
  this.sellPrice,
  this.id,
  this.stockAlert,
  this.physicalStock,
  this.theoreticalStock,
  this.image,
  this.familyName,
 });

  Produit.fromMap(Map<String, dynamic> donnees)
      : productName = donnees["productName"],
        buyingPrice = donnees["buyingPrice"],
        id = donnees["id"],
        stockAlert = donnees["stockAlert"],
        familyName = donnees["familyName"],
        sellPrice = donnees["sellPrice"],
        theoreticalStock = donnees["theoreticalStock"],
        physicalStock = donnees["physicalStock"],
        image = donnees["image"];

  Map<String, dynamic> toMap() {
    return {
      "productName": productName,
      "buyingPrice": buyingPrice,
      "id": id,
      "stockAlert": stockAlert,
      "sellPrice": sellPrice,
      "familyName": familyName,
      "theoreticalStock": theoreticalStock,
      "physicalStock": physicalStock,
      "image": image,
    };
  }
}
