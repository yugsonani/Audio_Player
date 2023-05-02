import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class song extends StatefulWidget {
  const song({Key? key}) : super(key: key);

  @override
  State<song> createState() => _songState();
}

class _songState extends State<song> {
  bool play = true;
  bool stop = true;
  bool h = true;
  final assetAudioPlayer = AssetsAudioPlayer();

  @override
  void dispose() {
    super.dispose();
    assetAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map s = ModalRoute.of(context)!.settings.arguments as Map;
    assetAudioPlayer.open(Audio("${s['path']}"));
    return Scaffold(
      appBar: AppBar(
        title: Text("${s['name']} Playing"),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Align(
            child: Container(
              width: 500,
              height: 800,
              child: Image.network(
                "${s['imeg1']}",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 190)),
                Container(
                  width: 250,
                  height: 250,
                  child: Image.network(
                    "${s['imeg1']}",
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(padding: EdgeInsets.all(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${s['name']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        )),
                  ],
                ),
                Text("${s['name1']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      fontSize: 17,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (stop == true) {
                              play = false;
                            }
                            stop = !stop;
                            assetAudioPlayer.pause();
                          });
                        },
                        icon: (stop == true)
                            ? Icon(
                                Icons.stop,
                                color: Colors.green,
                                size: 40,
                              )
                            : Icon(
                                Icons.stop,
                                color: Colors.green,
                                size: 40,
                              )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            assetAudioPlayer.playOrPause();
                            play = !play;
                          });
                        },
                        icon: (play == true)
                            ? Icon(
                                Icons.pause,
                                color: Colors.green,
                                size: 40,
                              )
                            : Icon(
                                Icons.play_arrow,
                                color: Colors.green,
                                size: 40,
                              )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            h = !h;
                          });
                        },
                        icon: (h == true)
                            ? Icon(
                                Icons.headphones,
                                color: Colors.green,
                                size: 40,
                              )
                            : Icon(
                                Icons.headset_off,
                                color: Colors.green,
                                size: 40,
                              )),
                  ],
                ),
                StreamBuilder(
                    stream: assetAudioPlayer.currentPosition,
                    builder: (context, snapshot) {
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${snapshot.data.toString().split(".")[0]}',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                                Text(
                                  "/",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                                (assetAudioPlayer.current.value != null)
                                    ? Text(
                                        "${assetAudioPlayer.current.value?.audio.duration.toString().split(".")[0]}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    : Text(
                                        "00:00:00",
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                              ],
                            ),
                            Slider(
                                activeColor: Colors.green.shade700,
                                inactiveColor: Colors.green,
                                min: 0,
                                max: (assetAudioPlayer.current.value != null)
                                    ? assetAudioPlayer.current.value?.audio
                                            .duration.inSeconds
                                            .toDouble() ??
                                        0
                                    : 0,
                                value: snapshot.data!.inSeconds.toDouble(),
                                onChanged: (e) {
                                  assetAudioPlayer
                                      .seek(Duration(seconds: e.toInt()));
                                }),
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
