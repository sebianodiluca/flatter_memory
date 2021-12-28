import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:audioplayers/audioplayers.dart';

final pathToReadAudio = 'assets/sample4.aac';

class SoundPlayer {
  FlutterSoundPlayer _audioPlayer;
  Future init() async {
    _audioPlayer = FlutterSoundPlayer();
    await _audioPlayer.openAudioSession();
  }

  void dispose() {
    _audioPlayer.closeAudioSession();
    _audioPlayer = null;
  }

  Future play() async {
    await _audioPlayer.startPlayer(
      fromURI: pathToReadAudio,
    
    );
  }

  Future _stop() async {
    await _audioPlayer.stopPlayer();
  }

  Future tooglePlaying() async {
    await play();
  }
}
