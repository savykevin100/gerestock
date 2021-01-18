import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/decaissement_models.dart';
import 'package:gerestock/modeles/depenses.dart';

import '../../helper.dart';

class NouvelleDepense extends StatefulWidget {
  @override
  _NouvelleDepenseState createState() => _NouvelleDepenseState();
}

class _NouvelleDepenseState extends State<NouvelleDepense> {
  String dateOperation;
  TextEditingController intituleDepenseController=TextEditingController();
  TextEditingController montantController =TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String emailEntreprise;

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }


  bool currentUser=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        emailEntreprise = value.email;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarWithSearch(context,"Dépenses"),
      body: ListView(
        children: [
          SizedBox(height: longueurPerCent(20, context),),
          TextClasse(text: "Nouvelle dépense",color: Colors.black,fontSize: 30,textAlign: TextAlign.center, family: "MonserratBold"),
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Date", context),
              InkWell(
                onTap: (){
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 12, 1),
                      maxTime: DateTime(2050, 1, 1), onChanged: (date) {
                        setState(() {
                          dateOperation = date.toString().substring(0, 10);
                        });
                      }, onConfirm: (date) {
                        setState(() {
                          dateOperation = date.toString().substring(0, 10);
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.fr);
                },
                child:Container(
                    height: longueurPerCent(41, context),
                    width: largeurPerCent(210, context),
                    margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1.0, color: HexColor("#707070")),
                    ),
                    child: (dateOperation!=null)?Center(child: TextClasse(text: dateOperation, color:  HexColor("#707070"), family: "MonserratBold",),):Text("")
                ),
              )
            ],
          ),
          SizedBox(height: longueurPerCent(20, context),),
          textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Intitulé dépense", context), context, intituleDepenseController, TextInputType.text),
          SizedBox(height: longueurPerCent(20, context),),
          textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Montant", context), context, montantController, TextInputType.number),
          SizedBox(height: longueurPerCent(100, context),),
          submitButton(context, "ENREGISTRER", (){
           registerDepense();
          })
        ],
      ),
    );
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur ) {
    final snackBar = SnackBar(
      content: Text(text,   style: TextStyle(color: couleur, fontSize: 15)),
    duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar,);
  }

  TextClasse  displayRecapTextBold(String text){
    return TextClasse(text: text, color: HexColor("#001C36"), family: "MonserratBold", fontSize: 9,);
  }

  TextClasse  displayRecapTextGrey(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 12,);
  }

  void registerDepense() {
    if(dateOperation!=null && intituleDepenseController.text!="" && montantController.text!=""){
      try {
        EasyLoading.show(status: 'Chargement', dismissOnTap: false);
        FirestoreService().addDepense(Depense(
            operationDate: dateOperation,
            expenseTitle: intituleDepenseController.text,
            amount: int.tryParse(montantController.text),
            created: DateTime.now().toString()
        ), emailEntreprise);
        FirestoreService().addDecaissement(DecaissementModels(
            created: DateTime.now().toString(),
            operationDate: dateOperation,
            expenseTitle: intituleDepenseController.text,
            amount: int.tryParse(montantController.text),
            etat: "Dépense"
        ), emailEntreprise);
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Enregistrement réussie!', maskType: EasyLoadingMaskType.custom);
        Navigator.pop(context);
      } catch (e){
        EasyLoading.dismiss();
        EasyLoading.showError("L'ajout a échoué");
      }
    } else {
      displaySnackBarNom(context, "Veuillez remplir tous les champs", Colors.white);
    }
  }
}
