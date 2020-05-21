import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_forms/form.model.dart';
import 'package:smart_forms/form_render.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Forms',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Smart Forms'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _getForms() {
    return Firestore.instance
        .collection('smart_forms')
        .snapshots(includeMetadataChanges: false)
        .map((QuerySnapshot query) => query.documents
            .map<FormData>((e) => FormData.fromSnapshot(e))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _getForms(),
          builder: (_, AsyncSnapshot<List<FormData>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: snapshot.data.map<Widget>((FormData data) {
                    return RaisedButton(
                      child: Text(data.name),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormRender(data: data),
                        ),
                      ),
                    );
                  }).toList(),
                );
                break;
              default:
                return CircularProgressIndicator();
                break;
            }
          },
        ),
      ),
    );
  }
}
