import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: controller1,
              decoration: const InputDecoration(
                hintText: "Enter Year",
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: controller2,
              decoration: const InputDecoration(
                hintText: "Enter Your Text",
              ),
            ),
            TextField(
              controller: controller3,
              decoration: const InputDecoration(
                hintText: "Enter a number",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () => getCentury(
                int.parse(controller1.text),
                context,
              ),
              child: const Text("Show result 1"),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => showString(controller2.text),
              child: const Text("Show result 2"),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => showResult3(
                context,
                num: int.parse(controller3.text.trim()),
              ),
              child: const Text("Show result 3"),
            ),
          ],
        ),
      ),
    );
  }

  // **************** Question 1 ****************

  void getCentury(int years, BuildContext context) {
    double number = years / 100;

    int century = number.ceil();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text("number of century is : $century"),
      ),
    );
  }

  // **************** Question 2 ****************

  void showString(String text) {
    String reversed = text.split("").reversed.join();

    bool result = reversed == text;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text("Is text symmetrical : $result"),
      ),
    );
  }

  // **************** Question 3 ****************

  Future<void> showResult3(BuildContext context, {required int num}) async {
    List<int> listNums = [];
    List<int> listResults = [];
    listNums.add(num);

    controller3.clear();
    await customDialoge(
      listNums: listNums,
      context: context,
    );

    for (int i = 0; i < listNums.length; i++) {
      int lastIndex = listNums.length - 1;

      if (i != lastIndex) {
        int product = listNums[i] * listNums[i + 1];
        listResults.add(product);
      }
    }
    int biggestMember = listResults.reduce(max);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text("Biggest member is $biggestMember"),
      ),
    );
  }

  Future<void> customDialoge({
    required List<int> listNums,
    required BuildContext context,
    String text = "Add a new number ?",
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Question 3"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text),
                TextField(
                  controller: controller3,
                  decoration: const InputDecoration(),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  listNums.add(int.parse(controller3.text.trim()));
                  controller3.clear();
                },
                child: const Text('Add'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
              )
            ],
          );
        });
  }
}
