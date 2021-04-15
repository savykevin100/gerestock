import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerestock/app_controller.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/modeles/utilisateurs.dart';
import 'package:gerestock/pages/facturations/facturation1.dart';
import 'package:gerestock/pages/parametres.dart';
import 'package:gerestock/pages/profileSettings.dart';
import 'package:gerestock/widgets/fournisseurs/fournisseursClientsWidget.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:gerestock/repository.dart' as userRepo;


class Accueil extends StatefulWidget {
  Accueil() : super();

  @override
  State<StatefulWidget> createState() {
    return _AccueilPageState();
  }
}

class _AccueilPageState extends StateMVC<Accueil> {

  AppController _con ;
  String dateCreatedAccount;
  TextEditingController _amountController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  _AccueilPageState() : super (AppController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDateCreatedAccount();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double deviceHeight = queryData.size.height;

    return new Scaffold(
      appBar:  AppBar(
        title: TextClasse(text: "Accueil", color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
        backgroundColor: primaryColor,
      ),
      drawer: ProfileSettings(),
      body: WillPopScope(
          onWillPop: onBackPressed,
          child: (_con.user!=null && _con.userPhone!="")?Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            height: double.infinity,
            child: GridView.count(
                    shrinkWrap: true,
                   crossAxisCount: 2,
                    children: <Widget>[
                      _happyVeganCard( "Produits",Colors.green,Icons.add,deviceHeight),
                      _happyVeganCard( "Clients", Color(0xFFC502FF),Icons.person,deviceHeight),
                      _happyVeganCard( "Fournisseurs", Color(0xFF02C5FF),Icons.shopping_cart,deviceHeight),
                      _happyVeganCard( "Mouvement de Stock", Color(0xFF707070),Icons.cached,deviceHeight),
                      _happyVeganCard( "Facturation", Color(0xFFFF8002),Icons.money ,deviceHeight),
                      _happyVeganCard( "Caisse", Color(0xFF092648),Icons.fact_check_outlined,deviceHeight),
                      _happyVeganCard( "Inventaire", Color(0xFF026DFF),Icons.list,deviceHeight),
                      //_happyVeganCard( "Abonnement", Color(0xFFFF0202),Icons.subscriptions,deviceHeight),
                      _happyVeganCard( "Dépenses", Color(0xFFFC2872),Icons.book,deviceHeight),
                      _happyVeganCard( "Paramètres", Color(0xFFC9C9C9),Icons.settings,deviceHeight),
                    ],
                  ),
          ):Center(child: CircularProgressIndicator(),)
        ),
        );
  }


  Future<bool> onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Fermer l'application",  style: TextStyle( color:primaryColor,
            fontSize: 15.0,
            fontFamily: "MonserratBold")),
        content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonserratLight")),
        actions: <Widget>[
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NON", style: TextStyle( color: primaryColor,
                  fontSize: 12.0,
                  fontFamily: "MonserratBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),

          SizedBox(width: largeurPerCent(50, context),),
          new GestureDetector(
              onTap: () => exit(0),
              child: Text("OUI", style: TextStyle( color:primaryColor,
                  fontSize: 12.0,
                  fontFamily: "MonserratBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),
          SizedBox(width: largeurPerCent(20, context),),
        ],
      ),
    ) ??
        false;
  }

  Future _showPaymentDialog() async {
    await       showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: TextClasse(text: "Votre abonnement est fini. Veuillez créditer votre compte pour continuer.", family: "MonserratSemiBold", fontSize: 15,),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 30,),
                    //TextClasse(text: "Montant à créditer", family: "MonserratRegular",),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Montant à créditer",
                        hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15)
                      ),

                      style: TextStyle(
                          color:Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontFamily: "MonserratSemiBold"
                      ),
                      controller: _amountController,
                      // ignore: missing_return
                      validator: (String value) {
                        if(value.isEmpty) {
                          return ("Entrer le montant à crediter");
                        }
                      },
                    ),
                    SizedBox(height: 30,),
                    //TextClasse(text: "Numéro de paiement", family: "MonserratRegular",),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Numéro de paiement",
                          hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15)

                      ),
                      style: TextStyle(
                          color:Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontFamily: "MonserratSemiBold"
                      ),
                      controller: _numberController,
                      // ignore: missing_return
                      validator: (String value) {
                        if(value.isEmpty) {
                          return ("Entrer votre numéro de téléphone");
                        } else if (value.length<6) {
                          return ("Le numéro entré est invalide ");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: TextClasse(text: "Fermer", family: "MonserratSemiBold", fontSize: 15,),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () async{
                  _amountController.text ="";
                  _numberController.text = "";
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 20,),
              FlatButton(
                child: TextClasse(text: "Crediter", family: "MonserratSemiBold", fontSize: 15,),
                textColor: Colors.white,
                color: HexColor("#119600"),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                   navigateKkiaPay();
                  }
                },
              )  ,
            ],
          );
        }
    );
  }



  Widget _happyVeganCard(String title, Color couleur,IconData icone ,double deviceHeight) {

    void moveToFoodDetailsScreen() {
      if(DateTime.now().isBefore(DateTime.parse(_con.user.created).add(Duration(minutes: 1))) || DateTime.now().isBefore(DateTime.parse(_con.user.dateExpiryAmount))) {
        if(title=="Clients" || title=="Fournisseurs"){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return FournisseursClientsWidget(title: title,);
          }));
        } else if(title == "Facturation")
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Facturation1(userPhone: _con.userPhone,)));
        else if(title == "Paramètres")
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Parametres(userPhone: _con.userPhone,)));
        else
          Navigator.of(context).pushNamed("/"+title);
      } else if(DateTime.now().isAfter(DateTime.parse(_con.user.dateExpiryAmount))){
         _showPaymentDialog();
      }

    }

    return new GestureDetector(
      onTap: () => moveToFoodDetailsScreen(),
      child: Container(
          width: 200,
          padding:EdgeInsets.only(left: 5.0,right: 5.0),
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Container(
                          height: (deviceHeight/5),
                          width: MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  topLeft: Radius.circular(5.0)),
                                  color: couleur,
                              ),
                        child: Icon(icone,color: Colors.white,size: 40,),
                          ),
                    ),
                    SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: AutoSizeText(
                          title,
                          style: TextStyle(fontSize: 15.0, fontFamily: "MonserratBold", color: couleur),
                          maxLines: 1,
                          minFontSize: 11,
                        )
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  void navigateKkiaPay(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  KKiaPay(
        amount: int.tryParse(_amountController.text),
        phone: '61000000',
        data: 'hello world',
        sandbox: true,
        apikey: '1b28e1d0772911eaa95c41ede0b15bcd',
        callback: sucessCallback,
        name: _con.user.companyName,
        theme: ("#3675BD"),
      )),
    );
  }

  Future<void> sucessCallback(response, context) async {
    int duringAbonnment;
    print(_amountController.text);
    
   setState(() {
     duringAbonnment = int.tryParse(_amountController.text)~/100;
     //duringAbonnment =int.tryParse((double.parse((int.tryParse(_amountController.text) / 100).toString())).toString());
   });
    print(duringAbonnment);
    setState(() {
      _con.user.amount = double.parse(_amountController.text);
      _con.user.dateExpiryAmount = DateTime.now().add(Duration(days: duringAbonnment)).toString();
    });
   try{
     print(_con.user.amount);
     FirestoreService().addUtilisateur(
         Utilisateur(
           //email: widget.userPhone,
             password: _con.user.password,
             created: _con.user.created,
             logo: _con.user.logo,
             companyName: _con.user.companyName,
             activitySector: _con.user.activitySector,
             ifu: _con.user.ifu,
             country:_con.user.country,
             telephoneNumber: _con.user.telephoneNumber,
             address:_con.user.address,
             amount: _con.user.amount,
             dateExpiryAmount: _con.user.dateExpiryAmount
         ),
         _con.userPhone);
   } catch (e){
     print(e);
   }
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Accueil()
      ),
    );
  }


  Future<void> getDateCreatedAccount() async{
    dateCreatedAccount = await userRepo.getDateCreatedAccount();
  }

}
