import 'dart:io';
import 'package:flutter/material.dart';
import 'home_page.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitTime();
  }

  void waitTime() async{
    sleep(const Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context){
        return HomePage();
      }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  'Make Sure you have Internet connection',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            CircularProgressIndicator(
              strokeWidth: 8.0,
              semanticsLabel: 'Loading',
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
