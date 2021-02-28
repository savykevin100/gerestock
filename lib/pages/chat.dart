import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:url_launcher/url_launcher.dart';



class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  String nameUser;

  launchWhatsApp(String phone) async {
    String url ="https://api.whatsapp.com/send?phone="+phone;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchNumber(String url) async {
    await launch("tel:$url");
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, "Chat"),
        body:Container(
          height: MediaQuery.of(context).size.height/1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "Contactez-nous ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HexColor("#001C36"),
                    fontSize: 40,
                    fontFamily: "MonserratBold",
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(30, context),),
              SizedBox(height: longueurPerCent(40, context),),
              Container(
                margin: EdgeInsets.only(bottom: longueurPerCent(10, context),left: longueurPerCent(40, context),right: longueurPerCent(40, context)),
                height: longueurPerCent(50.0, context),
                child: GestureDetector(
                  onTap: () {
                    launchWhatsApp("22961861183");
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    color: HexColor("#55D062"),
                    elevation: 7.0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: longueurPerCent(10, context)),
                            child: Image.asset("lib/assets/images/whatsapp.png",
                              width: largeurPerCent(40, context),),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:longueurPerCent(20, context)),
                            child: Text(
                              "WhatsApp",
                              style: TextStyle(
                                color: HexColor("#FFFFFF"),
                                fontSize: 23,
                                fontFamily: "MonserratBold",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: longueurPerCent(10, context),left: longueurPerCent(40, context),right: longueurPerCent(40, context), top: 50),
                height: longueurPerCent(50.0, context),
                child: GestureDetector(
                  onTap: () {
                   _launchNumber("61861183");
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.blue,
                    elevation: 7.0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: longueurPerCent(5, context)),
                            child: Icon(Icons.call, size: 30, color: Colors.white,)
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:longueurPerCent(10, context)),
                            child: Text(
                              "Appel",
                              style: TextStyle(
                                color: HexColor("#FFFFFF"),
                                fontSize: 23,
                                fontFamily: "MonserratBold",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }


}