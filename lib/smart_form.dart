import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_forms/smart_field.model.dart';

import 'custom_form_field.dart';

class   SmartForm extends StatefulWidget {
  final List<SmartField> fields;
  final String buttonText;
  final Function(List<TextEditingController>) onPressed;

  const SmartForm({Key key, this.fields, this.buttonText, this.onPressed})
      : super(key: key);

  @override
  State<SmartForm> createState() {
    return _SmartForm();
  }
}

class _SmartForm extends State<SmartForm> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focuses = [];
  TextInputType _convertToType(String type) {
    switch (type) {
      case "text":
        return TextInputType.text;
        break;
      case "multiline":
        return TextInputType.multiline;
        break;
      case "number":
        return TextInputType.number;
        break;
      case "phone":
        return TextInputType.phone;
        break;
      case "email":
        return TextInputType.emailAddress;
        break;
      case "url":
        return TextInputType.url;
        break;
      default:
        return TextInputType.text;
        break;
    }
  }

  List<Widget> _buildForms(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.fields.length; i++) {
      SmartField field = widget.fields[i];
      widgets.add(
        Padding(
          padding: EdgeInsets.only(
              bottom: i < widget.fields.length - 1 ? 10 : 60,
              top: i == 0 ? 20 : 0),
          child: CustomFormField(
            type: _convertToType(field.type),
            focusNode: _focuses[i],
            controller: _controllers[i],
            nextFocus: i < widget.fields.length - 1 ? _focuses[i + 1] : null,
            label: field.label,
            required: field.require,
            errorMessage: field.errorMesage,
            validate: true,
            callback: validateForm,
          ),
        ),
      );
    }
    widgets.add(
        RaisedButton(child: Text(widget.buttonText), onPressed: validateForm));
    widgets.add(SizedBox(
      height: 20,
    ));
    return widgets;
  }

  void validateForm() {
    if (_form.currentState.validate()) {
      widget.onPressed(_controllers);
    }
  }

  @override
  void initState() {
    _controllers = widget.fields.map<TextEditingController>((field) {
      return TextEditingController();
    }).toList();
    _focuses = widget.fields.map<FocusNode>((field) {
      return FocusNode();
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildForms(context),
          )),
    );
  }
}
