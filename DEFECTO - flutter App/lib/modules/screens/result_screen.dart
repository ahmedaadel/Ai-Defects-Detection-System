import 'package:flutter/material.dart';

import '../../shared/constants/consts.dart';

class ResultScreen extends StatefulWidget {
  static const id = "result_screen";
  final String result;

  ResultScreen({required this.result});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Result'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              //images to be tested or live video here
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    //Here to replace with the right result
                    'Done!\n\n${widget.result}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
