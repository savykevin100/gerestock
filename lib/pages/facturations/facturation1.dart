import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/pages/facturations/facturation2.dart';

import '../../helper.dart';


class Facturation1 extends StatefulWidget {
  static String id = "Facturation1";
  @override
  _Facturation1State createState() => _Facturation1State();
}

class _Facturation1State extends State<Facturation1> {

  String _dateInput;
  TextEditingController _numeroFacture = TextEditingController();
  TextEditingController _quantiteController = TextEditingController();
  TextEditingController _serviceController = TextEditingController();
  TextEditingController _amountServiceController = TextEditingController();
  String _emailEntreprise;
  List<String> _clients = [];
  String _clientSelect;
  bool _serviceOrSelle=false;
  List<String> _productName = [];
  List<String> _productSellPrice = [];
  List<String> _productId=[];
  List<int> _productQuantite=[];
  List<Map<String, dynamic>> _products = [];
  String _productSelect;
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  Future<void> fetchProductsFromDb(){
    try {
      FirebaseFirestore.instance.collection("Utilisateurs").doc(_emailEntreprise).collection("TousLesProduits").get().then((value){
          value.docs.forEach((element) {
            if(this.mounted)
              setState(() {
                _productName.add(element.data()["productName"]);
                _productSellPrice.add(element.data()["sellPrice"]);
                _productQuantite.add(element.data()["theoreticalStock"]);
                _productId.add(element.data()["id"]);
              });
          });
      });
    } catch (e){
      print(e);
    }
  }

  Future<void> fetchClientFromDb(){
    FirebaseFirestore.instance.collection("Utilisateurs").doc(_emailEntreprise).collection("Clients").get().then((value) {
      if(value.docs.isNotEmpty)
        value.docs.forEach((element) {
          if(this.mounted)
            setState(() {
              _clients.add(element.data()["name"]);
            });
        });
    });
  }

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // displaySnackBarNom(context, "Veuillez vérifier si vous avez déjà enregistrer un client et des produits", Colors.white);
    getUser().then((value){
      if(value!=null){
        setState(()  {
          _emailEntreprise = value.email;
        });
        fetchClientFromDb();
        fetchProductsFromDb();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: TextClasse(text: "Facturation", color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
        backgroundColor: primaryColor,
      ),
      body: (_clients.length!=0 && _productName.length!=0 && _productSellPrice.length!=0 && _productQuantite.length!=0 )?ListView(
        children: [
          SizedBox(height: longueurPerCent(20, context),),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             nameOfFieldWithPadding("Date", context),
             InkWell(
               onTap: (){
                 DatePicker.showDatePicker(context,
                     showTitleActions: true,
                     minTime: DateTime(1900, 1, 1),
                     maxTime: DateTime(2040, 12, 31), onChanged: (date) {
                       setState(() {
                         _dateInput = date.toString();
                       });
                     }, onConfirm: (date) {
                       setState(() {
                         _dateInput = date.toString();
                       });
                     }, currentTime: DateTime.now(), locale: LocaleType.fr);
               },
               child: Container(
                 height: 41,
                 width: largeurPerCent(210, context),
                 margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(3),
                   border: Border.all(width: 1.0, color: HexColor("#707070")),
                 ),
                 child: (_dateInput!=null)?Center(child: TextClasse(text: Helper.currentFormatDate(_dateInput), color:  HexColor("#707070"), family: "MonserratBold",),):Text("")
               ),
             )
           ],
         ),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Client", context),
              (_clients.length!=0)?Container(
                  height: 40,
                  width: largeurPerCent(210, context),
                  margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                  child: DropdownSearch<String>(
                    mode: Mode.DIALOG,
                    maxHeight: 450,
                    items: _clients.toList(),
                    onChanged: (value) {
                      setState(() {
                        _clientSelect = value;
                      });
                    },
                    showSearchBox: true,
                    searchBoxDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: longueurPerCent(50, context), right: longueurPerCent(50, context)),
                        hintText: "Rechercher un client",
                        hintStyle: TextStyle(color: HexColor("#707070"), fontFamily: "ORegular", fontSize: 15)
                    ),
                    popupTitle: Container(
                      height: longueurPerCent(50, context),
                      decoration: BoxDecoration(
                        color: primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          "Clients",
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
              ):Text("")
            ],
          ),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              displayRecapTextBold2("Ventes"),
              Switch(
                value: _serviceOrSelle,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (bool value){
                  setState(() {
                    _serviceOrSelle = value;
                    _products = [];
                  });
                },
              ),
              displayRecapTextBold2("Services"),
            ],
          ),
          SizedBox(height: 20,),
          (!_serviceOrSelle)?  Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: displayRecapTextBold("Nom du produit"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 55),
                      child: displayRecapTextBold("Quantité"),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 1,
                    itemCount: 1,
                    itemBuilder: (context, i) {
                      return Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex:2,
                                  child: (_productName.length>0)?Container(
                                      height: 40,
                                      width: largeurPerCent(210, context),
                                      margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                                      child: DropdownSearch<String>(
                                        mode: Mode.DIALOG,
                                        maxHeight: 450,
                                        items: _productName,
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
                                  ):Text(""),
                                ),
                                Expanded(
                                  flex:1,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Container(
                                      height: 40,
                                      width: largeurPerCent(100, context),
                                      margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(width: 1.0, color: HexColor("#707070")),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        controller: _quantiteController,
                                        decoration: InputDecoration(
                                            enabledBorder: InputBorder.none
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 0.0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                )
              ],
            ),
          ):
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            TextClasse(text: "Service", color: HexColor("#001C36"), family: "MonserratBold", fontSize: 15,),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: TextStyle(fontSize: 15, fontFamily: "MonserratSemiBold"),
                  textAlign: TextAlign.center,
                  controller: _serviceController,
                   maxLines: null,
                   decoration: InputDecoration(
                     border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(7.0) ),
                         borderSide: BorderSide(width: 2, style: BorderStyle.none)
                     ),
                   ),
                ),
              ),
              SizedBox(height: 20,),
              TextClasse(text: "Montant service", color: HexColor("#001C36"), family: "MonserratBold", fontSize: 15,),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: TextField(
                  style: TextStyle(fontSize: 15, fontFamily: "MonserratSemiBold"),
                  textAlign: TextAlign.center,
                  controller: _amountServiceController,
                   keyboardType: TextInputType.number,
                   maxLines: 1,
                   decoration: InputDecoration(
                     border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(7.0) ),
                         borderSide: BorderSide(width: 2, style: BorderStyle.none)
                     ),
                   ),
                ),
              ),
          ],),
          SizedBox(height: 10,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _products.length,
              itemBuilder: (ctx, i){
                return  ListTile(
                    title: RichText(
                      text: TextSpan(
                        text: (!_serviceOrSelle)?"${_products[i]["productName"]}        ": "${_products[i]["service"]}             ",
                        style: TextStyle(color: Colors.black, fontFamily: "MonserratSemiBold", fontSize: 15,),
                        children: <TextSpan> [
                          TextSpan(text:Helper.currenceFormat(int.tryParse( _products[i]["sellPriceProduct"])),
                            style: TextStyle(color: Colors.green, fontFamily: "MonserratSemiBold", fontSize: 15),
                          ),
                        ]
                      ),
                    ),
                    subtitle: (!_serviceOrSelle)?TextClasse(
                      text: _products[i]["quantite"],
                      family: "MonserratSemiBold",
                    ):Text(""),
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
          ),
          SizedBox(height: longueurPerCent(100, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20,),

              submitButton(context, "GENERER", (){

                if(_dateInput!=null && _clientSelect!=null && _products.length!=0) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Facturation2(typeFacturation: (_serviceOrSelle==false)?false:true, dateInput: _dateInput, client: _clientSelect, products: _products, emailEntreprise: _emailEntreprise,)));
                }

                else displaySnackBarNom(context, "Veuillez remplir tous les champs", Colors.white);
              }),
              Padding(padding: EdgeInsets.only(left: 20)),

             FloatingActionButton(
                backgroundColor: bleuPrincipale,
                onPressed: () {

                 addProductInProductList();
                },
                child: Icon(Icons.add,color: Colors.white,),
              )
            ],
          ),
          SizedBox(height: longueurPerCent(50, context),),
        ],
      ):Center(child:CircularProgressIndicator(),)
    );
  }


  void addProductInProductList(){
    if(_serviceOrSelle==false) {
      bool productNotExitInMap;
      setState(() {
        productNotExitInMap = _products.where((element) => element["productName"] ==_productSelect).isEmpty;
      });
      print(productNotExitInMap);
      // ignore: unrelated_type_equality_checks
      if(_quantiteController.text!="" && _productSelect!=null && productNotExitInMap==true) {
        if(_productQuantite[_productName.indexWhere((element) => element == _productSelect)] >= int.tryParse(_quantiteController.text))
          setState(() {
            _products.add(
                {
                  "quantite": _quantiteController.text,
                  "productName": _productSelect,
                  "sellPriceProduct": _productSellPrice[_productName.indexWhere((element) => element == _productSelect)],
                  "idProduct": _productId[_productName.indexWhere((element) => element == _productSelect)],
                  "remainingQuantity": _productQuantite[_productName.indexWhere((element) => element == _productSelect)] - int.tryParse(_quantiteController.text)
                }
            );
            print(_productQuantite[_productName.indexWhere((element) => element == _productSelect)] - int.tryParse(_quantiteController.text));
          }); else displaySnackBarNom(context, "La quantité de ce produit n'est plus suffisant. Le nombre restant est: ${_productQuantite[_productName.indexWhere((element) => element == _productSelect)]}", Colors.white);
      }
      else if(productNotExitInMap==false) displaySnackBarNom(context, "Vous avez déjà ajouté ce produit", Colors.white);
      else displaySnackBarNom(context, "Veuillez remplir tous les champs", Colors.white);
    }
    else {
      bool productNotExitInMap;
      setState(() {
        productNotExitInMap = _products.where((element) => element["service"] ==_serviceController.text).isEmpty;
      });
      print(productNotExitInMap);
      if(_serviceController.text!="" && _amountServiceController.text!="" && productNotExitInMap==true) {
        setState(() {
          _products.add({
            "quantite": "1",
            "service": _serviceController.text,
            "sellPriceProduct": _amountServiceController.text
          });

          _serviceController.text="";
          _amountServiceController.text="";
        });
      }
      else if(productNotExitInMap==false) displaySnackBarNom(context, "Vous avez déjà ajouté ce produit", Colors.white);
      else displaySnackBarNom(context, "Veuillez remplir tous les champs", Colors.white);
    }
  }

  Widget DropdownSearchWidget(List<String> data, BuildContext context, String itemSelect, String hintText, String textInSearchBar){
    return Container(
        height: 40,
        width: largeurPerCent(210, context),
        margin: EdgeInsets.only(right: largeurPerCent(22, context)),
        child: DropdownSearch<String>(
          mode: Mode.DIALOG,
          maxHeight: 450,
          items: data.toList(),
          onChanged: (value) {
            itemSelect = value;
          },
          onSaved: (value) {
            setState(() {
              itemSelect = value;
            });
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


  displaySnackBarNom(BuildContext context, String text, Color couleur ) {
    final snackBar = SnackBar(duration: Duration(seconds: 1),content: Text(text,   style: TextStyle(color: couleur, fontSize: 15),),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


  TextClasse  displayRecapTextBold(String text){
    return TextClasse(text: text, color: HexColor("#001C36"), family: "MonserratBold", fontSize: 9,);
  }

  TextClasse  displayRecapTextBold2(String text){
    return TextClasse(text: text, color: HexColor("#001C36"), family: "MonserratBold", fontSize: 18,);
  }

  TextClasse  displayRecapTextGrey(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 12,);
  }
}
