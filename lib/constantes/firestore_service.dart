import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerestock/modeles/clients_fournisseurs.dart';
import 'package:gerestock/modeles/decaissement_models.dart';
import 'package:gerestock/modeles/depenses.dart';
import 'package:gerestock/modeles/entrer_models.dart';
import 'package:gerestock/modeles/facture.dart';
import 'package:gerestock/modeles/inventaire.dart';
import 'package:gerestock/modeles/produits.dart';
import 'package:gerestock/modeles/utilisateurs.dart';
class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  // ignore: deprecated_member_use
  FirebaseFirestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Future<void> addUtilisateur(Utilisateur utilisateur, String idDocument) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        // ignore: deprecated_member_use
        .setData(utilisateur.toMap());
  }

  Future<void> addClientOrFournisseur(
      ClientsFounisseursModel clientsFouniss, String idDocument, String referenceDb) {
    return _db
        .collection("Utilisateurs")
        // ignore: deprecated_member_use
        .document(idDocument)
        .collection(referenceDb)
        .add(clientsFouniss.toMap())
        .then((value) {
      this
          ._db
          .collection("Utilisateurs")
          .doc(idDocument)
          .collection(referenceDb)
          // ignore: deprecated_member_use
          .doc(value.documentID)
          // ignore: deprecated_member_use
          .updateData({"id": value.documentID});
    });
  }

  Future<void> addDepense(Depense depense, String idDocument) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection("Depenses")
        .add(depense.toMap())
        .then((value) {
      this
          ._db
          .collection("Utilisateurs")
          // ignore: deprecated_member_use
          .document(idDocument)
          .collection("Depenses")
          // ignore: deprecated_member_use
          .doc(value.documentID)
          // ignore: deprecated_member_use
          .updateData({"id": value.documentID});
    });
  }

  Future<void> addDecaissement(DecaissementModels decaissementModels, String idDocument) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection("Decaissement")
        .add(decaissementModels.toMap())
        .then((value) {
      this
          ._db
          .collection("Utilisateurs")
          .doc(idDocument)
          .collection("Decaisssement")
          .doc(value.id)
          .update({"id": value.id});
    });
  }

  Future<void> addProductInFamily(
      Produit produit, String idDocument, String nomFamille) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection("Familles")
        .doc(nomFamille)
        .collection("TousLesProduits")
        .add(produit.toMap())
        .then((value) {
      this
          ._db
          .collection("Utilisateurs")
          .doc(idDocument)
          .collection("Familles")
          .doc(nomFamille)
          .collection("TousLesProduits")
          .doc(value.id)
          .update({"id": value.id});
    });
  }

  Future<void> addProductInTousLesProduits(
    Produit produit,
    String idDocument,
  ) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection("TousLesProduits")
        .add(produit.toMap())
        .then((value) {
      this
          ._db
          .collection("Utilisateurs")
          .doc(idDocument)
          .collection("TousLesProduits")
          .doc(value.id)
          .update({"id": value.id});
    });
  }

  Future<void> addFacture(
      Facture facture,
      String idDocument,
      ) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection("Factures")
        .add(facture.toMap())
        .then((value) {
      this
          ._db
          .collection("Utilisateurs")
          .doc(idDocument)
          .collection("Factures")
          .doc(value.id)
          .update({"id": value.id});
    });
  }


  Future<void> addNewEnter(EntrerModels entrerModels, String emailEntreprise){
   _db.collection("Utilisateurs").doc(emailEntreprise).collection("Entrees").add(entrerModels.toMap()).then((value){
     _db.collection("Utilisateurs").doc(emailEntreprise).collection("Entrees").doc(value.id).update({"id": value.id});
   });
  }


  Future<void> addInventaire(Inventaires inventaire, String emailEntreprise){
   _db.collection("Utilisateurs").doc(emailEntreprise).collection("Inventaires").add(inventaire.toMap()).then((value){
     _db.collection("Utilisateurs").doc(emailEntreprise).collection("Inventaires").doc(value.id).update({"id": value.id});
   });
  }


  Stream<List<Facture>> getFacture(
      String idDocument) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection("Factures")
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
          .map(
            (doc) => Facture.fromMap(doc.data()),
      )
          .toList(),
    );
  }

  Stream<List<ClientsFounisseursModel>> getClientsFourniss(
      String idDocument, String titre) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection(titre)
        .orderBy("name", descending:false)
        .snapshots()
        .map(
          // ignore: deprecated_member_use
          (snapshot) => snapshot.documents
              .map(
                // ignore: deprecated_member_use
                (doc) => ClientsFounisseursModel.fromMap(doc.data(), doc.documentID),
              )
              .toList(),
        );
  }

  Stream<List<Depense>> getDepenses(String idDocument) {
    return _db
        .collection("Utilisateurs")
        .document(idDocument)
        .collection("Depenses")
        .orderBy("created", descending: true)
        .snapshots()
        .map(
          // ignore: deprecated_member_use
          (snapshot) => snapshot.documents
              .map(
                // ignore: deprecated_member_use
                (doc) => Depense.fromMap(doc.data(), doc.documentID),
              )
              .toList(),
        );
  }

  Stream<List<DecaissementModels>> getDecaissement(String idDocument) {
    return _db
        .collection("Utilisateurs")
        .document(idDocument)
        .collection("Decaissement")
        .orderBy("created", descending: true)
        .snapshots()
        .map(
          // ignore: deprecated_member_use
          (snapshot) => snapshot.documents
              .map(
                // ignore: deprecated_member_use
                (doc) => DecaissementModels.fromMap(doc.data(), doc.documentID),
              )
              .toList(),
        );
  }

  Stream<List<ClientsFounisseursModel>> getClientDetails(
      String idDocument, String titre, idClient) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection(titre)
        .where("id", isEqualTo: idClient)
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => ClientsFounisseursModel.fromMap(doc.data(), doc.documentID),
              )
              .toList(),
        );
  }

  Stream<List<Produit>> getClientInFamilly(
      String idDocument, String nomFamille) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection(nomFamille)
        .orderBy("nomFamille", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Produit.fromMap(doc.data()),
              )
              .toList(),
        );
  }

  Stream<List<Produit>> getFamilly(String idDocument) {
    return _db
        .collection("Utilisateurs")
        .doc(idDocument)
        .collection("Familles")
        .orderBy("nomFamille", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Produit.fromMap(doc.data()),
              )
              .toList(),
        );
  }


  Stream<List<Inventaires>> getInventaire(String emailEntreprise) {
    return _db
        .collection("Utilisateurs")
        .doc(emailEntreprise)
        .collection("Inventaires")
        .orderBy("created", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Inventaires.fromMap(doc.data()),
              )
              .toList(),
        );
  }
}
