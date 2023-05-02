import 'package:audio_player/song.dart';
import 'package:flutter/material.dart';

import 'global.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => audio(),
        '1': (context) => song(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

class audio extends StatefulWidget {
  const audio({Key? key}) : super(key: key);

  @override
  State<audio> createState() => _audioState();
}

class _audioState extends State<audio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF1A1F24),
      appBar: AppBar(
        title: Text(
          "Spotify",
          style: TextStyle(
            fontSize: 29,
            color: Colors.green,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView(
        children: Global.song
            .map(
              (e) => Column(
                children: [
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '1',
                        arguments: e,
                      );
                    },
                    leading: Image.network(
                      '${e['imeg']}',
                      height: 60,
                      width: 60,
                    ),
                    title: Text(
                      "${e['name']}",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    trailing: Icon(
                      Icons.play_circle,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    height: 8,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
