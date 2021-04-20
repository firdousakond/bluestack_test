import 'package:bluesstack_app/view/home.dart';
import 'file:///D:/AndroidProjects/PracticeDemo/bluestack_flutter/bluesstack_app/lib/view/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[600],
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/loginPage',
      routes: {
        '/loginPage': (context) => LoginPage(),
        '/homePage': (context) => HomePage()
      },
    );
  }

}
