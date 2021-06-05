import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ringo/ringo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Ringo _ringo;

  final tokenized = StringBuffer();
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initRingo();
    controller.addListener(_controllerListener);
  }

  Future _lattice() async {}

  Future<void> _initRingo() async {
    _ringo = await Ringo.init();
    final result = _ringo.tokenize('吾輩はRingoである');
    print(result);
  }

  void _controllerListener() {

    final words = _ringo.tokenize(controller.text);
    for (final word in words) {
      tokenized.write('$word\n');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ringo'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: controller,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Center(
                child: Text(
                  'result\n\n$tokenized',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
