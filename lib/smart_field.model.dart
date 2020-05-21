class SmartField {
  String label;
  bool require;
  String type;
  String errorMesage;

  SmartField.fromMap(Map<dynamic, dynamic> map) {
    this.label = map['label'];
    this.require = map['required'];
    this.type = map['type'];
    this.errorMesage = map['error_message'];
  }

}