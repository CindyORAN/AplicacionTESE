import 'package:cloud_firestore/cloud_firestore.dart';

//init in todo initState
//of a class StatefulWidget
class Connection {
  Future<List<String>> getUsers(String nameNode) async {
    //data type users
//modify List Users 7u7
    var Users = [];
    CollectionReference collectionReference = FirebaseFirestore.instance
        //"users"
        .collection(nameNode); //extract the node what you want
    QuerySnapshot users = await collectionReference.get();
    if (users.docs.length != 0) {
      for (var doc in users.docs) {
        Users.add(doc.data());
      }
      //on success add User
      return Users;
    }
    //on failed
    return null;
  }
}
