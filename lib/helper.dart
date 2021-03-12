import 'package:flutter/cupertino.dart';
import 'package:gerestock/repository.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


ValueNotifier<String> numUser = new ValueNotifier("");

class Helper{




  static String currenceFormat(int amount){
//    var f = NumberFormat.simpleCurrency(name: 'XOF', decimalDigits: 0, customPattern: '\u00a4 #,##.#')).format(amouunt);
    final oCcy = new NumberFormat("#,##0.00", "fr_FR");

    var f = NumberFormat.currency(locale: "fr_FR", name: 'FCFA', decimalDigits: 0, customPattern: '#,###.# \u00a4').format(amount);


    return f;
  }

  static String currentFormatDate(String date){
    return  date.toString().substring(0, 10) ;
    //return  date.toString().substring(0,10) + " à"  + date.toString().substring(10, 19) ;
  }

  static String currentFormatWithName(String date){
    initializeDateFormatting();
    String f = DateFormat.yMd(currentFormatWithName(date)).toString();
    return f;
  }


   String numeroUser(){
    String num;
      userNumero().then((value) {
          numUser.value = value;
          num = value;
      });
      print(numUser.value);
      print(num);
      return numUser.value;
  }

}