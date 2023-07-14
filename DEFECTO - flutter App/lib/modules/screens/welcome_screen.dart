import 'package:defecto/modules/screens/upload_screen.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/consts.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = "welcome_screen";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: const Text('Welcome Dear!'),
      ),
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Defecto , Welcome .. ',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              const Text(
                'An Artificial Intelligence System ',
                style: TextStyle(
                    fontSize: 18, height: 2, fontWeight: FontWeight.bold),
              ),
              const Text(
                'for identifying defective products ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Expanded(
                  flex: 3,
                  child: Image(
                    image: AssetImage('assets/images/defecto_welcome.png'),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, UploadScreen.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 30, right: 30, top: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(fontSize: 20),
                        )),
                  ))
            ],
          ),
        ),
      ),
    );
    ;
  }
}
