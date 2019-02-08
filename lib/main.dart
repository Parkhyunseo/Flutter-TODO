import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<Null> main() async {
  runApp(new TaskListApp());
}

class TaskListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TaskListApp",
      home: HomePage(),
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}
// with는 mixin?
class _HomePageState extends State<HomePage>{
  double _imageHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: new Stack(
        children: <Widget>[
          _buildImage(),
          _buildTopHeader()
        ],
      )
    );
  }

  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: new Row(
        children: <Widget>[
          new Icon(Icons.menu, size:32.0, color: Colors.white),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text(
                "Timeline",
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
              )
            ),
          ),
          new Icon(Icons.linear_scale, color: Colors.white), 
        ],
      )
    );
  }

  Widget _buildImage() {
    return new ClipPath(
      clipper: new DialognalCliper(),
      child : new Image.asset(
          'assets/back2.jpg',
          fit: BoxFit.cover,
          height: _imageHeight,
          colorBlendMode: BlendMode.srcOver,
          color: new Color.fromARGB(80, 20, 30, 40),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // prevent device orientation changes and force portrait?
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class DialognalCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size)
  {
    Path path = new Path();
    path.lineTo(0.0, size.height-60.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipeer) => true;
}