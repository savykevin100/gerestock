
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/app_controller.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/utilisateurs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// ignore: must_be_immutable
class Parametres extends StatefulWidget {

String userPhone;

Parametres({this.userPhone});
  @override
  _ParametresState createState() =>
      _ParametresState();
}

class _ParametresState extends StateMVC<Parametres> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  String code="+229";
  String pays="Bénin";
  String logo="";
  TextEditingController _nomDeLentreprise = TextEditingController();
  TextEditingController _secteurActivite = TextEditingController();
  TextEditingController _ifu = TextEditingController();
  TextEditingController _numeroTelephone = TextEditingController();
  TextEditingController _adresse = TextEditingController();


  String telephoneNumber;
  Map<String, dynamic> _userData;
  bool _enableNomDeLentreprise=false;
  bool _enableSecteurActivite=false;
  bool _enableIfu=false;
  bool _enableNumeroTelephone=false;
  bool _enableAdresse=false;
  bool _enableModify=false;



  AppController _con ;



  _ParametresState() : super(AppController()) {
    _con = controller;
  }





  Future<void> fetchDataUser(){
    FirebaseFirestore.instance.collection("Utilisateurs").doc(widget.userPhone).get().then((value) {
      print(value.data());
      if(this.mounted)
        setState(() {
          _userData = value.data();
           logo=_userData["logo"];
          _nomDeLentreprise.text=_userData["companyName"];
          _secteurActivite.text=_userData["activitySector"];
          _ifu.text=_userData["ifu"];
           telephoneNumber=_userData["telephoneNumber"];
          _adresse.text=_userData["address"];
        });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.userPhone!="")
      fetchDataUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: TextClasse(text: "Paramètres avancés", color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
        backgroundColor: primaryColor,
      ),
      body: (_userData!=null)?Card(
        margin: EdgeInsets.symmetric(
          horizontal: largeurPerCent(16, context),
        ),
        elevation: 5.0,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 28),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 20,),
                  Stack(fit: StackFit.loose, children: <Widget>[
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _displayLogo(),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 100.0, left: 140.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                             (_enableModify)?CircleAvatar(
                              backgroundColor: bleuPrincipale,
                              radius: 25.0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _selectImage(
                                    // ignore: deprecated_member_use
                                      ImagePicker.pickImage(
                                          source: ImageSource.gallery),
                                      1);
                                },
                              )
                            ):Container()
                          ],
                        )),
                  ]),
                  SizedBox(height: 40,),
                  TextFormField(
                    controller: _nomDeLentreprise,
                    enabled: _enableNomDeLentreprise,
                    decoration: InputDecoration(
                        hintText: _userData["companyName"],
                        hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15, color: HexColor("#ADB3C4"))
                    ),
                    // ignore: missing_return
                    validator: (value){
                      // ignore: missing_return
                      if(value.isEmpty)
                        return ("Veuillez entrer le nom de l'entreprise");
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _secteurActivite,
                    enabled: _enableSecteurActivite,
                    decoration: InputDecoration(
                        hintText: _userData["activitySector"],
                        hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15, color: HexColor("#ADB3C4"))
                    ),
                    // ignore: missing_return
                    validator: (value){
                      // ignore: missing_
                      if(value.isEmpty)
                        return ("Veuillez entrer le secteur d'activité de l'entreprise");
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _ifu,
                    enabled: _enableIfu,
                    decoration: InputDecoration(
                        hintText: _userData["ifu"],
                        hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15, color: HexColor("#ADB3C4"))
                    ),
                    // ignore: missing_return
                    validator: (value){
                      // ignore: missing_
                      if(value.isEmpty)
                        return ("Veuillez entrer le numéro IFU");
                    },
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child:  Column(
                          children: [
                            SizedBox(height: 15,),
                            CountryCodePicker(
                              onChanged: (e)  {
                                print(e.code.toString());
                                setState(() {
                                  code = e.code.toString();
                                  pays=e.name;
                                });
                              },
                              initialSelection: 'BJ',
                              showCountryOnly: true,
                              showOnlyCountryWhenClosed: false,
                              favorite: ['+229', 'FR'],
                            ),
                          ],
                        ),),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding:EdgeInsets.only(top: 15),
                          child: TextFormField(
                            enabled: _enableNumeroTelephone,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: telephoneNumber.substring(4, telephoneNumber.length),
                                hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15, color: HexColor("#ADB3C4"))
                            ),
                            // ignore: missing_return
                            onChanged: (value)=> telephoneNumber=value.toString(),
                            // ignore: missing_return
                            validator: (value){
                              // ignore: missing_
                              if(value.isEmpty)
                                return ("Veuillez entrer le numéro de téléphone");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _adresse,
                    enabled: _enableAdresse,
                    decoration: InputDecoration(
                        hintText: _userData["address"],
                        hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15, color: HexColor("#ADB3C4"))
                    ),
                    // ignore: missing_return
                    validator: (value){
                      // ignore: missing_
                      if(value.isEmpty)
                        return ("Veuillez entrer l'adresse de l'entreprise");
                    },
                  ),
                  SizedBox(height: 40,),
                  (_enableModify)?submitButton(context, "ENREGISTRER", () async {
                    enregistrer();
                  setState(() {
                    _enableModify=false;
                    _enableNomDeLentreprise=false;
                    _enableSecteurActivite=false;
                    _enableIfu=false;
                    _enableNumeroTelephone=false;
                    _enableAdresse=false;
                  });
                  }):submitButton(context, "MODIFIER", (){
                    setState(() {
                      _enableModify=true;
                      _enableNomDeLentreprise=true;
                      _enableSecteurActivite=true;
                      _enableIfu=true;
                      _enableNumeroTelephone=true;
                      _enableAdresse=true;
                    });
                  }),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ),
      ):Center(child: CircularProgressIndicator(),)
    );
  }






  void enregistrer(){
    if(_formKey.currentState.validate() && _image!=null) {
      EasyLoading.show(status: 'Patientez svp...', dismissOnTap: false);
      if(_image!=null){
        try {
          firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
              .ref().child(widget.userPhone + "/LogoEntreprise")
              .putFile(_image);
          task.whenComplete(() async {
            logo = await firebase_storage.FirebaseStorage.instance
                .ref(widget.userPhone + "/LogoEntreprise")
                .getDownloadURL();
            if(logo!=null){
              addInfoDb();
            }
          });
        } catch(e) {
          print(e.toString());
          EasyLoading.showError("L'ajout a échoué");
          EasyLoading.dismiss();
        }
      }
    } else {
      EasyLoading.show(status: 'Chargement', dismissOnTap: false);
      addInfoDb();
    }
  }


  showAlertDialog(BuildContext context, String text) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Retour"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ALERT"),
      content: Text(text),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image = tempImg);
        break;
    }
  }

  Widget _displayLogo() {
    if (_image == null) {
      return Container(
        height: 140,
        width: 140,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: _userData["logo"],
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color:Colors.red, height: 110, width: largeurPerCent(210, context),),
          )
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: HexColor("#707070"),
            )),
      );
    } else {
      return Container(
        height: 140,
        width: 140,
        child: Image.file(
          _image,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Future<void> addInfoDb() async {
    try {
      await FirestoreService().addUtilisateur(
          Utilisateur(
            //email: widget.userPhone,
            logo: logo,
            companyName: _nomDeLentreprise.text,
            activitySector: _secteurActivite.text,
            ifu: _ifu.text,
            country:pays,
            telephoneNumber: code+telephoneNumber,
            address: _adresse.text,
            password: _userData["password"],
            created: _userData["created"],
            dateExpiryAmount: _userData["dateExpiryAmount"],
            amount: _userData["amount"],
          ),
          widget.userPhone);
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Modification réussie!', maskType: EasyLoadingMaskType.custom);
      Duration(seconds: 2);
    } catch(e){
      EasyLoading.dismiss();
      print(e);
      EasyLoading.showError("L'ajout a échoué");
      EasyLoading.dismiss();
    }
  }
}
