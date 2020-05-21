import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_forms/form.model.dart';
import 'package:smart_forms/smart_form.dart';

class FormRender extends StatefulWidget {
  final FormData data;

  const FormRender({Key key, this.data}) : super(key: key);

  @override
  State<FormRender> createState() {
    return _FormRender();
  }
}

class _FormRender extends State<FormRender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: SmartForm(
            fields: widget.data.fields,
            buttonText: widget.data.button,
            onPressed: (List<TextEditingController> controllers) {
              controllers.forEach((controller) {
                print(controller.value);
              });
            },
          ),
        ),
      ),
    );
  }
}
