import 'package:flutter/material.dart';

/// animation动画
class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  /* AnimationStatus animationStatus;
  double animationValue;*/

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    /*//动画的值发生变化时调用
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      //动画状态发生变化时被调用
      ..addStatusListener((AnimationStatus state) {
        setState(() {
          animationStatus = state;
        });
      });*/
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('animation动画'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  controller.reset();
                  controller.forward();
                },
                child: Text(
                  'Start',
                  textDirection: TextDirection.ltr,
                ),
              ),
              /* Text(
                'State:${animationStatus.toString()}',
                textDirection: TextDirection.ltr,
              ),
              Text(
                'Value:${animationValue.toString()}',
                textDirection: TextDirection.ltr,
              ),*/
              AnimatedLogo(
                animation: animation,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Container(
      width: animation.value,
      height: animation.value,
      child: FlutterLogo(),
    );
  }
}
