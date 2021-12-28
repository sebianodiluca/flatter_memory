import 'package:flutter/material.dart';
import 'package:memory_game/main.dart';
import 'package:memory_game/pages/sound_player.dart';

import 'memory_page.dart';

class WinPage extends StatelessWidget {
  @override
  void initState() {
    // super.initState();
    player.init();
  }

  @override
  void dispose() {
    player.dispose();
    //super.dispose();
  }

  final player = SoundPlayer();
  String _WIN = "assets/win.png";
  String _LOST = "assets/lost.png";
  bool win;
  double time;
  int timeWin;
  double level;
  double score;
  WinPage(this.win, double time, this.timeWin, this.level, this.score);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Container(
          height: 70,
        ),
        Text(
          (win) ? 'HAI VINTO' : 'HAI PERSO',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 25,
              fontFamily: 'Sarpanch',
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30,
        ),
        Container(
          child: Image.asset(
            (win) ? _WIN : _LOST,
            width: 250,
          ),
        ),
        Container(
          height: 30,
        ),
        Text(
          'Credit ${score.floor()}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30,
        ),

        Center(
            child: Text(
          (win)
              ? 'Hai impiegato ${timeWin} secondi! '
              : 'Ritenta sarai piu fortunato',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
        //   FlatButton(
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(18.0),
        //       side: BorderSide(color: Colors.red)),
        //   child: Text(
        //     'Gioca di nuovo',
        //     style: Theme.of(context).textTheme.headline6,
        //   ),
        //   onPressed: () {
        //     showResult(haiVinto);
        //   },
        // ),
        Container(
          height: 30,
        ),
        FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)),
            onPressed: () async {
              //await player.play();
              // scoreAttuale = widget.scorePrecedente + timeWin;
              if (win) {
                time = (level - (level * 8 / 100));
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => MemoryPage(time, score)));
              } else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyApp()
                        //MemoryPage(level, score)
                        ));
              }
            },
            child: Text(
              (win) ? 'Continua' : 'Ricomincia',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ],
    )));
  }
}
