import 'package:flutter/foundation.dart';
import 'package:note_app/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class NoteViewModel with ChangeNotifier{

  bool isDark = true;
  set setIsDark(bool newValue){
    isDark = newValue;
    notifyListeners();
  }


  List<NoteModel> noteList = [];

  Future<void> getNotes()async{
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    fireStore.collection('Notes').snapshots().listen((event) {
      print(event);
    });
  }

}