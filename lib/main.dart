import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color mainColor = Color(0xFF1A1C1E);
  String dataSource = "https://youtu.be/5XRuEYXWfYc";
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(dataSource)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
        title: Text('Video Player'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : Container(),
          VideoProgressIndicator(_controller!, allowScrubbing: true,padding: EdgeInsets.all(0.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.skip_previous),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  _controller!.value.isPlaying
                      ? _controller!.pause()
                      : _controller!.play();
                },
                icon: Icon(Icons.play_arrow),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.skip_next),
                color: Colors.white,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('Beautiful Sea Video',style: TextStyle(color:Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('This is a sample video Player made using Flutter, you can try it by yourself and see what you can get',style: TextStyle(color:Colors.white, fontSize: 18.0, fontWeight: FontWeight.normal),),
          ),
        ],
      ),
    );
  }
}
