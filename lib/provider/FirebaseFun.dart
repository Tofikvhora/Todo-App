import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireBaseFunctions extends ChangeNotifier {
  String? storePro;
  Color? storeColor;
  Color? newBoxColor;
  FirebaseFirestore fs = FirebaseFirestore.instance;
  DateTime date = DateTime.now();
  String greetings = "";
  Future<void> storeDataBase(String collection, TextEditingController name,
      TextEditingController cat, TextEditingController dis, String date) async {
    fs.collection(collection).doc().set({
      "Name": name.text,
      "Category": cat.text,
      "Description": dis.text,
      "Date": date,
    });
  }

  void storeProgress(String progress, Color proColor, Color boxColor) {
    storePro = progress;
    storeColor = proColor;
    newBoxColor = boxColor;
    notifyListeners();
  }

  void greetingFunction() {
    var hour = date.hour;
    if (hour < 12) {
      greetings = "Good Morning";
      notifyListeners();
    }
    if (hour < 4 && hour > 12) {
      greetings = "Good Afternoon";
      notifyListeners();
    }
    if (hour > 4) {
      greetings = "Good Evening";
      notifyListeners();
    }
    notifyListeners();
  }
}
