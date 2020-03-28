import 'package:brewcrew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String sugars,String name,int strength) async {
    return await brewCollection.document(uid).setData({
      'sugers':sugars,
      'name' :name,
      'stregth':strength
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        suger: doc.data['sugers'] ?? '0',
      );
    }).toList();
  }

  //get brew stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }
}