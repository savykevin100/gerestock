import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
class FicheEntrees extends StatefulWidget {
  @override
  _FicheEntreesState createState() => _FicheEntreesState();
}

class _FicheEntreesState extends State<FicheEntrees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Entrées"),
      body: Card(
        elevation: 5.0,
        child: Center(
          child: Column(
            children: [
              Text("Nouvelle Entrée"),
          Row(
              children: <Widget>[
                Text("Date de réception"),
                Expanded(
                  child:TextField(
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        ),
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
      )
    );
  }
}
