import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_coivd19_tracker_app/View/world_states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // ANIMATION CONTROLLER
  late final AnimationController _controller =
  AnimationController(duration: const Duration(seconds: 3), vsync: this)
    ..repeat();

  // ANIMATION DISPOSE AND INITIALIZATION
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WorldStatesScreen()));
    });

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: const SizedBox(
                height: 200,
                width: 200,
                child:  Center(
                  child:  Image(
                    image:  AssetImage("assets/virus.png"),
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                    angle: _controller.value * 0.8 * math.pi, child: child);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            const Align(
              alignment: Alignment.center,
              child:  Text(
                "Covid19\nTracker App",
                style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
