import 'dart:async';

import 'package:api_integration/COVID_App/View/WorldStateScreen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller= AnimationController(
      duration: Duration(seconds: 5),
      vsync: this)..repeat();

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5),
            ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldStatesScreen()))

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             AnimatedBuilder(
                 animation: _controller,
                 child: Container(
                   height:  200,
                   width: 200,
                   child: Center(
                     child: Image(
                       image: AssetImage("assets/images/covid.png"),
                     ),
                   ),
                 ),
                 builder: (BuildContext context, Widget? child){
                   return Transform.rotate(
                       angle: _controller.value * 2.0 * math.pi,
                        child: child,
                   );
                 }),
            SizedBox(height: MediaQuery.of(context).size.height * .08,),
            
            Align(
                alignment: Alignment.center,
                child: Text("Covid 19 \n Tracker App",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),

          ],
        ),
      ),
    );
  }
}
