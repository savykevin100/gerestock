import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/decaissement_models.dart';
import 'package:gerestock/modeles/entrer_models.dart';
import 'package:gerestock/pages/mouvementsDeStock/ficheEntrees.dart';

import '../../spash_screen.dart';

class ConfirmEntrees extends StatefulWidget {
  String dateInput;
  String fournisseur;
  String livreur;
  String montantEntrer;

  ConfirmEntrees({this.dateInput, this.fournisseur, this.livreur, this.montantEntrer});
  @override
  _ConfirmEntreesState createState() => _ConfirmEntreesState();
}

class _ConfirmEntreesState extends State<ConfirmEntrees> {

  TextEditingController _quantiteController = TextEditingController();
  List<String> _productName=[];
  List<Map<String, dynamic>> _products = [];
  String _productSelect;
  String _emailEntreprise;

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }






  void fetchProductsFromDb(String email){
    try {
      FirebaseFirestore.instance.collection("Utilisateurs").doc(email).collection("TousLesProduits").get().then((value){
        value.docs.forEach((element) {
         if(this.mounted)
           setState(() {
             _productName.add(element.data()["productName"]);
           });
        });
      });
    } catch (e){
      print(e);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value){
      if(value!=null){
        setState(()  {
         _emailEntreprise = value.email;
        });
        fetchProductsFromDb(_emailEntreprise);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context,"Entrées"),
      body: (_productName.length!=0)?ListView(
        children: [
          Card(
            elevation: 3.0,
            child: Column(
              children: [
                SizedBox(height: longueurPerCent(20, context),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    nameOfFieldWithPadding("Nom du produit", context),
                    Container(
                        height: 50,
                        width: largeurPerCent(210, context),
                        margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                        child: DropdownSearch<String>(
                          mode: Mode.DIALOG,
                          maxHeight: 450,
                          items: _productName.toList(),
                          onChanged: (value) {
                            setState(() {
                              _productSelect = value;
                            });
                          },
                          showSearchBox: true,
                          searchBoxDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: longueurPerCent(50, context), right: longueurPerCent(50, context)),
                              hintText: "Rechercher un produit",
                              hintStyle: TextStyle(color: HexColor("#707070"), fontFamily: "ORegular", fontSize: 15)
                          ),
                          popupTitle: Container(
                            height: longueurPerCent(50, context),
                            decoration: BoxDecoration(
                              color: primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                "Produits",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          popupShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7),
                            ),
                          ),
                        )
                    ),
                    //DropdownSearchWidget(_productName, context, _productSelect, "Rechercher un produit", "Produit"),
                  ],
                ),
                SizedBox(height: longueurPerCent(20, context),),
                textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Quantité", context), context, _quantiteController, TextInputType.number),
                SizedBox(height: longueurPerCent(20, context),),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _products.length,
              itemBuilder: (ctx, i){
                return  ListTile(
                    title: TextClasse(
                      text: _products[i]["productName"],
                      family: "MonserratSemiBold",
                    ),
                    subtitle: TextClasse(
                      text: _products[i]["quantite"],
                      family: "MonserratSemiBold",
                    ),
                    trailing:IconButton(icon:  Icon(
                      Icons.delete,
                      color:Colors.red,
                      size: 20,
                    ),onPressed: (){
                      setState(() {
                        _products.removeAt(i);
                      });
                    })
                );
              }
          )
        ],
      ):Center(child: CircularProgressIndicator(),),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
            left: longueurPerCent(20, context),  top: MediaQuery
            .of(context)
            .size
            .height - 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 20,),
            submitButton(context, "Enregister", (){
             if(_products.length!=0)
               try {
                 _products.forEach((element) {
                   print(element["productName"]);
                 });
                 EasyLoading.show(status: 'Chargement', dismissOnTap: false);
                 FirestoreService().addNewEnter(EntrerModels(
                     products: _products,
                     provider: widget.fournisseur,
                     deliveryMan: widget.livreur,
                     dateReceipt: widget.dateInput,
                     amount: int.tryParse(widget.montantEntrer),
                     created: DateTime.now().toString(),
                 ), _emailEntreprise);
                 _products.forEach((element) {
                  Firestore.instance.collection("Utilisateurs").doc(_emailEntreprise).collection("TousLesProduits").where("productName", isEqualTo: element["productName"]).get().then((value){
                    if(value.docs.isNotEmpty)
                      Firestore.instance.collection("Utilisateurs").doc(_emailEntreprise).collection("TousLesProduits").doc(value.docs.first.id).update({"theoreticalStock":value.docs.first.data()["theoreticalStock"]+int.tryParse(element["quantite"])});
                  });
                });
                 FirestoreService().addDecaissement(DecaissementModels(
                     created: DateTime.now().toString(),
                     operationDate: widget.dateInput,
                     expenseTitle: "Nouvelle entrée",
                     amount: int.tryParse(widget.montantEntrer),
                     etat: "Entrée"
                 ), _emailEntreprise);
                 setState(() {
                   _products = [];
                 });
                 EasyLoading.dismiss();
                 EasyLoading.showSuccess("L'ajout a réussie");
               } catch (e){
                 EasyLoading.dismiss();
                 EasyLoading.showError("L'ajout a échoué");
                 EasyLoading.dismiss();
               }
             else
               EasyLoading.showError("Veuillez ajouter le produit et la quantité avant d'enregistrer");
            }),
            FloatingActionButton(
              backgroundColor: bleuPrincipale,
              onPressed: () {
                print(_quantiteController.text);
                print(_productSelect);
                print(_products.contains(_productSelect));
               if(_quantiteController.text!=null && _productSelect!=null && !_products.contains(_productSelect))
                 setState(() {
                   _products.add(
                       {
                         "quantite": _quantiteController.text,
                         "productName": _productSelect,
                       }
                   ) ;
                   _quantiteController.text="";
                 });
              },
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }

  Widget DropdownSearchWidget(List<String> data, BuildContext context, String itemSelect, String hintText, String textInSearchBar){
    return Container(
        height: 50,
        width: largeurPerCent(210, context),
        margin: EdgeInsets.only(right: largeurPerCent(22, context)),
        child: DropdownSearch<String>(
          mode: Mode.DIALOG,
          maxHeight: 450,
          items: data.toList(),
          onChanged: (value) {
            setState(() {
              itemSelect = value;
            });
            print(itemSelect);
          },
          showSearchBox: true,
          searchBoxDecoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: longueurPerCent(50, context), right: longueurPerCent(50, context)),
              hintText: hintText,
              hintStyle: TextStyle(color: HexColor("#707070"), fontFamily: "ORegular", fontSize: 15)
          ),
          popupTitle: Container(
            height: longueurPerCent(50, context),
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Center(
              child: Text(
                textInSearchBar,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          popupShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7),
            ),
          ),
        )
    );
  }
}
