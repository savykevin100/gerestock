import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:hexcolor/hexcolor.dart';

class Inventaire extends StatefulWidget {
  @override
  _InventaireState createState() => _InventaireState();
}

class _InventaireState extends State<Inventaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bleuPrincipale,
        elevation: 0.0,
        leading: IconButton(
            icon:Icon(Icons.arrow_back_ios),
          onPressed: (){
              Navigator.pop(context);
          },
        ),
        title: Text("Inventaires",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        actions: [
          IconButton(
            icon:Icon(Icons.search,color:Colors.white)
          ),
          IconButton(
              icon:Icon(Icons.list,color:Colors.white)
          ),
        ],
      ),
      body:Center(
        child: Card(
           // margin: EdgeInsets.symmetric(horizontal: largeurPerCent(21, context), vertical: longueurPerCent(46, context)),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context,  i) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Alimentaire",
                      style:TextStyle(fontFamily:"MonserratMedium")
                      ),
                          subtitle: Text("25 Produits", style:TextStyle(fontFamily:"MonserratMedium" ,fontSize: 13)),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: HexColor("#ADB3C4"),
                            size: 30,
                          ),
                        ),
                        Divider(color: HexColor("#ADB3C4"),)
                      ],
                    );
                  }
              ),
            )
        ),
      ),
    );
  }
}