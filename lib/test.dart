import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/pages/clients/clientDetail.dart';





class HomePage extends StatefulWidget {
  static String id = "Fournisseurs";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Fournisseurs"),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context,  i) {
                return Column(
                  children: [
                    InkWell(
                      onTap: (){
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => ClientDetail()));
                      },
                      child: ListTile(
                        title: TextClasse(
                          text: "Alimentaire",
                          family: "MonserratSemiBold",
                        ),
                        leading: Icon(
                          Icons.navigate_next,
                          color: HexColor("#ADB3C4"),
                          size: 30,
                        ),
                      ),
                    ),
                    ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        itemBuilder: (context,  i) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ClientDetail()));
                                },
                                child: ListTile(
                                  title: TextClasse(
                                    text: "Huile",
                                    family: "MonserratLight",
                                  ),
                                  contentPadding: EdgeInsets.only(left: 100),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 100),
                                child: Divider(color: HexColor("#ADB3C4"),),
                              ),
                            ],
                          );
                        }
                    ),
                  ],
                );
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/FicheFournisseur");

        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
      ),
    );
  }
}
