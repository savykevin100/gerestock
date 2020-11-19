
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/modeles/utilisateurs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
class InformationSupplementaire extends StatefulWidget {
  String email;
  InformationSupplementaire({this.email});
  @override
  _InformationSupplementaireState createState() =>
      _InformationSupplementaireState();
}

class _InformationSupplementaireState extends State<InformationSupplementaire> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Paramètres avancés"),
      body: Card(
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
                            new CircleAvatar(
                              backgroundColor: bleuPrincipale,
                              radius: 25.0,
                              child: new IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _selectImage(
                                      ImagePicker.pickImage(
                                          source: ImageSource.gallery),
                                      1);
                                },
                              ),
                            )
                          ],
                        )),
                  ]),
                  SizedBox(height: 40,),
                  TextFormField(
                    controller: _nomDeLentreprise,
                    decoration: InputDecoration(
                      hintText: "Nom de l'entreprise",
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
                    decoration: InputDecoration(
                      hintText: "Secteur d'activité",
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
                    decoration: InputDecoration(
                      hintText: "N°IFU",
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
                            controller: _numeroTelephone,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Numéro de Téléphone",
                              hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15, color: HexColor("#ADB3C4"))
                            ),
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
                    decoration: InputDecoration(
                      hintText: "Adresse",
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
                  submitButton(context, "ENREGISTRER", () async {
                    enregistrer();
                  }),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  void enregistrer(){
    if(_formKey.currentState.validate()) {
      EasyLoading.show(status: 'Chargement', dismissOnTap: false);
      if(_image!=null){
        try {
          firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
              .ref(widget.email +
              '/${Path.basename(_image.path)}}')
              .putFile(_image);

          task.whenComplete(() async {
            logo = await firebase_storage.FirebaseStorage.instance
                .ref(widget.email +
                '/${Path.basename(_image.path)}}')
                .getDownloadURL();
            if(logo!=null){
              try {
                await FirestoreService().addUtilisateur(
                    Utilisateur(
                        email: widget.email,
                        logo: logo,
                        nomDeLentreprise: _nomDeLentreprise.text,
                        secteurActivite: _secteurActivite.text,
                        ifu: _ifu.text,
                        pays:pays,
                        numeroTelephone: code+_numeroTelephone.text,
                        adresse: _adresse.text
                    ),
                    widget.email);
                EasyLoading.dismiss();
                EasyLoading.showSuccess('Enregistrement réussie!', maskType: EasyLoadingMaskType.custom);
                Duration(seconds: 2);
                Navigator.pushNamed(context, "/accueil");
              } catch(e){
                EasyLoading.dismiss();
                print(e.toString());
                EasyLoading.showError("L'ajout a échoué");
                EasyLoading.dismiss();
              }
            }
          });
        } catch(e) {
          print(e.toString());
          EasyLoading.showError("L'ajout a échoué");
          EasyLoading.dismiss();
        }
      }
    }
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
          child: Text(
            "Ajouter un logo",
            maxLines: 3,
            style: TextStyle(fontFamily: "MonserratSemiBold", fontSize: 16, color: HexColor("#254151")),
            textAlign: TextAlign.center,
          ),
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
}
