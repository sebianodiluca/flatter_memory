// ignore_for_file: sdk_version_set_literal, sdk_version_ui_as_code

import 'dart:async';
import 'dart:html';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:memory_game/main.dart';
import 'package:memory_game/pages/win.dart';
//import 'package:flutter/rendering.dart';

class MemoryPage extends StatefulWidget {
  double level;
  double scorePrecedente;
  // final double time;
  // final int score;
  MemoryPage(this.level, this.scorePrecedente);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MemoryPage> with TickerProviderStateMixin {
  List<GlobalKey<FlipCardState>> cardStateKeys = [
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
  ];
  List<bool> cardFlips = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  String _PIC01 = "logo_close_card.png";
  // String _prova = 'primo_.png';
  List<String> data = [
    "primo_.png",
    "primo_.png",
    "secondo_.png",
    "secondo_.png",
    "terzo_.png",
    "terzo_.png",
    "quarto_.png",
    "quarto_.png",
    "settimo_.png",
    "settimo_.png",
    "sesto_.png",
    "sesto_.png",
  ];

  int previousIndex = -1;
  bool flip = false;
  Timer timer;
  double time;
  double scoreAttuale;
  double timerView = 0;
  int timeWin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('inizio');
    time = widget.level;
    scoreAttuale = widget.scorePrecedente;
    timerView = time * 85 / 100;
    int tim = time.toInt() + 1;
    // int timMilliseconds= (widget.time *1000).toInt();
    startTimer();
    data.shuffle();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: tim),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
  }

  stopTimer() {
    timer.cancel();
    controller.stop();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (time > 0) {
        setState(() {
          time = time - 1;
          timeWin = (widget.level - time).toInt();
        });
      } else
        stopTimer();
    });
    print('dentro il timer');
  }

  AnimationController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('widget.time  ${widget.time} ');
    // print('this.time ${this.time}');
    // print('time: $time');
    // print('widget.score ${widget.score}');
    bool haiVinto = false;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(height: 20),
        Theme(
          data: ThemeData.dark(),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: (time > 0)
                  ? Container(height: 30)
                  : Container(
                      child: Text(
                        'HAI PERSO',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )),
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: 340,
              height: 30,
              child: LinearProgressIndicator(
                color: Color.fromRGBO(242, 145, 156, 1),
                backgroundColor: (time > widget.level / 3)
                    ? Color.fromRGBO(188, 222, 223, 1)
                    : Colors.red,
                minHeight: 30,
                value: controller.value,
                semanticsLabel: '${time.floor}',
              ),
            ),
            Align(
                heightFactor: 1,
                alignment: Alignment.bottomCenter,
                child: Text("${time.floor()}")),
          ],
        ),
        Container(
          height: 30,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) => FlipCard(
            key: cardStateKeys[index],
            onFlipDone: (isFront) => (time > 0)
                ? {
                    if (previousIndex != -1)
                      {
                        if (data[index] == data[previousIndex])
                          {
                            // print('uguali'),
                            previousIndex = -1,
                            if (cardFlips.every((element) => element == false))
                              {
                                //print('HAI VINTO '),
                                // timeWin = widget.score + timeWin,

                                haiVinto = true,
                                scoreAttuale = (widget.scorePrecedente == 0)
                                    ? widget.level - timeWin
                                    : widget.scorePrecedente +
                                        widget.level -
                                        timeWin,
                                showResult(haiVinto),
                              }
                          }
                        else
                          {
                            //print('disuguali'),
                            cardFlips[index] = true,
                            cardFlips[previousIndex] = true,
                            cardStateKeys[previousIndex]
                                .currentState
                                .controller
                                .reverse(),
                            //print('toglle indice$index'),
                            cardStateKeys[index]
                                .currentState
                                .controller
                                .reverse(),
                            // print(
                            //     'toglle indice precedente$previousIndex'),
                            previousIndex = -1,
                          },
                      }
                    else
                      {previousIndex = index},
                    // print(index),
                    // print(previousIndex),
                  }
                : {
                    scoreAttuale = widget.scorePrecedente,
                    showResult(haiVinto),
                  },
            direction: FlipDirection.HORIZONTAL,
            flipOnTouch: (time < timerView) ? cardFlips[index] : false,
            front: Center(
              child: (time > timerView)
                  ? Container(
                      width: 100,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        color: Colors.grey[300],
                      ),
                      child: Image.asset(
                        //_prova,
                        data[index],
                      ))
                  //  Image.asset(

                  //   data[index],
                  //   // fit: BoxFit.cover,

                  : Center(
                      child: FlatButton(
                          onPressed: () => {
                                if (cardFlips[index])
                                  cardStateKeys[index]
                                      .currentState
                                      .toggleCard(),
                                cardFlips[index] = false,
                              },
                          child: Container(
                              width: 90,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                color: Colors.grey[300],
                              ),
                              child: Image.asset(
                                _PIC01,
                                // fit: BoxFit.cover,
                                //_prova,
                                //data[index],
                              ))

                          // Image.asset(

                          ),
                    ),
            ),
            back: Center(
              //margin: EdgeInsets.all(8),
              child: FlatButton(
                  color: Colors.transparent,
                  onPressed: () => {},
                  child: Container(
                      width: 90,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        color: Colors.grey[300],
                      ),
                      child: Image.asset(
                        '${data[index]}',
                        // fit: BoxFit.cover,
                        //_prova,
                        //data[index],
                      ))

                  // Image.asset(

                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ),
          ),
          //: {stopTimer(), showResult(haiVinto)},
          itemCount: data.length,
        )
      ]),
    ));
  }

  showResult(win) {
    //controller.stop();
    stopTimer();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            WinPage(win, time, timeWin, widget.level, scoreAttuale)));
  }
}
