import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:memory_game/pages/memory_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Colors.grey[10],
          accentColor: Colors.purple,
          textTheme: TextTheme(
            headline1:
                TextStyle(fontWeight: FontWeight.w100, color: Colors.black),
          )),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;
  String localAudioCacheURI;

  String _INIT = "assets/Group.png";
  String _MENU = "assets/menu.png";
  String _SCORE = "assets/score.png";
  // var time = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    //reStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 80,
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   title: Text(
      //     'Memory By Codenpilar ',
      //     style: Theme.of(context).textTheme.headline6,
      //   ),
      // ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            children: [
              Container(
                height: 150,
              ),
              Container(
                child: Image.asset(
                  _INIT,
                  width: 250,
                ),
              ),
              Container(
                height: 100,
              ),
              FlatButton(
                child: Text(
                  ('START'),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          // Memory1page(20)));
                          // Memory2page()));
                          MemoryPage(25, 0)));
                },
              ),
              Container(
                height: 100,
              ),
              FlatButton(
                child: Text(
                  ('CREDITS'),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          // Memory1page(20)));
                          // Memory2page()));
                          MemoryPage(20, 0)));
                },
              ),
              Container(
                height: 100,
              ),
              Text(
                'Developed by Sebiano di Luca',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sarpanch',
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
