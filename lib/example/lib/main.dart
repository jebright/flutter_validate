import 'package:flutter/material.dart';
import 'package:flutter_validate/example/lib/validationFormField.dart';
import 'package:flutter_validate/example/lib/validationForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.code), text: 'field level'),
                Tab(icon: Icon(Icons.enhanced_encryption), text: 'form level'),
              ],
            ),
            title: Text('Validation demo'),
          ),
          body: TabBarView(
            children: [
              ValidationFormField(),
              ValidationForm(),
            ],
          ),
        ),
      ),
    );
  }

    // return MaterialApp(
    //   title: appTitle,
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: Text(appTitle),
    //     ),
    //     body: MyCustomForm(),
    //   ),
    // );
  //}
}

