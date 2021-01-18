import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/pages/mouvementsDeStock/confirmEntrees.dart';
import 'package:gerestock/spash_screen.dart';

import '../../helper.dart';
class FicheEntrees extends StatefulWidget {

  @override
  _FicheEntreesState createState() => _FicheEntreesState();
}

class _FicheEntreesState extends State<FicheEntrees> {

  String dateInput;
  TextEditingController montantEntrerController = TextEditingController();
  TextEditingController livreurController = TextEditingController();
  String fournisseur;
  List<String> fournisseurDb = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _emailEntreprise;

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }



  void fetchFournisseursFromDb(String email){
   try {
     FirebaseFirestore.instance.collection("Utilisateurs").doc(email).collection("Fournisseurs").get().then((value){
       value.docs.forEach((element) {
         print(element.data()["name"]);
         setState(() {
           fournisseurDb.add(element.data()["name"]);
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
        print(_emailEntreprise);
        fetchFournisseursFromDb(_emailEntreprise);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:appBarWithSearch(context,"Entrées"),
      body: ListView(
        children: [
          SizedBox(height: longueurPerCent(20, context),),
          TextClasse(text: "Nouvelle entrée",color: Colors.black,fontSize: 30,textAlign: TextAlign.center, family: "MonserratBold"),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Date de réception", context),
              InkWell(
                onTap: (){
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime(2040, 12, 31), onChanged: (date) {
                        setState(() {
                          dateInput = date.toString().substring(0,10);
                        });
                      }, onConfirm: (date) {
                        setState(() {
                          dateInput = date.toString().substring(0,10);
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
                    child: (dateInput!=null)?Center(child: TextClasse(text: Helper.currentFormatDate(dateInput), color:  HexColor("#707070"), family: "MonserratBold",),):Text("")
                ),
              )
            ],
          ),
          SizedBox(height: longueurPerCent(20, context),),
          textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Montant entrée", context), context, montantEntrerController, TextInputType.number),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Fournisseur", context),
              (fournisseurDb.length>0)?Container(
                height:41,
                width: largeurPerCent(210, context),
                margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(width: 1.0, color: HexColor("#707070")),
                ),
                child:  DropdownButton(
                  underline: Text(""),
                  hint: fournisseur == null
                      ? Text(
                    '',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                      : Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                    fournisseur,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                    ),
                  ),
                      ),
                  isExpanded: true,
                  iconSize: 30.0,
                  items:
                  fournisseurDb.map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val,),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                  setState(() {
                    fournisseur=val;
                  });
                  },
                ),
              ):Text("")
            ],
          ),
          SizedBox(height: longueurPerCent(20, context),),
          textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Livreur", context), context, livreurController, TextInputType.text),
          SizedBox(height: longueurPerCent(100, context),),
          submitButton(context, "CONTINUER", (){
            if(dateInput!=null && fournisseur!=null && montantEntrerController.text!="") {
              print(montantEntrerController.text);
              print(livreurController.text);
              print(fournisseur);
              print(dateInput);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ConfirmEntrees(dateInput: dateInput, fournisseur: fournisseur, livreur: livreurController.text, montantEntrer: montantEntrerController.text,)));
            }
            else
              displaySnackBarNom(context, "Veuillez choisir la date et le fournisseur", Colors.white);
          })
        ],
      )
    );
  }


  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  TextClasse  displayRecapTextBold(String text){
    return TextClasse(text: text, color: HexColor("#001C36"), family: "MonserratBold", fontSize: 9,);
  }

  TextClasse  displayRecapTextGrey(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 12,);
  }
}
