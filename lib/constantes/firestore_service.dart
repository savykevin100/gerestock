import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerestock/modeles/utilisateurs.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
  FirestoreService._internal();
  FirebaseFirestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Future<void> addUtilisateur(Utilisateur utilisateur, String idDocument) {
    return _db.collection("Utilisateurs").document(idDocument).setData(utilisateur.toMap());
   }
}