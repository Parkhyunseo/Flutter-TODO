import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:core';

import 'package:to/data/dummy.dart';
import 'package:to/ui/task_row.dart';

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
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildTimeline(),
          _buildTasksList()
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

/* static data가 추가되었을 경우 재시작을 해야한다 */
  Widget _buildProfileRow(){
    return new Padding(
      padding: new EdgeInsets.only(
        left: 16.0,
        top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/avatar.png'),
          ),
          new Padding(
            padding: const EdgeInsets.only(left:16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'Park Hyunseo',
                  style: new TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
                ),
                new Text(
                  'Game Developer',
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart()
  {
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight),  
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTaskHeader(),
          _buildTaskList()
        ],
      )
    );
  }

  Widget _buildTaskList()
  {
    return new Container();  
  }

  Widget _buildMyTaskHeader()
  {
    return new Padding(
      padding: const EdgeInsets.only(left: 64.0),
      child: new Column(
        children: <Widget>[
          new Text(
            'My Tasks',
            style: new TextStyle(
              fontSize: 34.0,
            )
          ),
          new Text(
            DateTime.now().year.toString() + ' ' + 
            DateTime.now().month.toString() + ' ' +
            DateTime.now().day.toString(),
            style: new TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
            )
          )
        ],
      ),
    );
  }

  Widget _buildTimeline()
  {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300]
      ),
    );
  }

  Widget _buildTasksList()
  {
    return new Expanded(
      child: new ListView(
        children: tasks.map((task) => new TaskRow(task: task)).toList(),
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