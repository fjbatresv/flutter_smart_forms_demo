import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_forms/smart_field.model.dart';

class FormData {
  DocumentReference ref;
  String name;
  String button;
  List<SmartField> fields;

  FormData.fromMap(Map<dynamic, dynamic> map, {this.ref}) {
    this.name = map['name'];
    this.button = map['button'];
    this.fields = map['fields'].map<SmartField>((field) {
      return SmartField.fromMap(field);
    }).toList();
  }

  FormData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, ref: snapshot.reference);
}
