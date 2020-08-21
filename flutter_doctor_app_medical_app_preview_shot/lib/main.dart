import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var textStyleGrey = TextStyle(color: Color.fromARGB(255, 138, 134, 133),
    fontSize: 12);
  var textStyleBlue = TextStyle(color: Color.fromARGB(255, 134, 159, 196),
    fontSize: 16, fontFamily: "Shadows Into Light");
  var textStyleBlueW = TextStyle(color: Color.fromARGB(255, 134, 159, 196),
    fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Shadows Into Light");

  _buildLine({double height = 1, double marginTop = 3, double marginBottom = 15}){
    return Container(
      height: height,
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      color: Color.fromARGB(255, 137, 134, 135));
  }
  _buildContentPaper(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("name / age / address", style: textStyleGrey),
            SizedBox(height: 20),
            Text("Cameron Williansom, 29 years old", style: textStyleBlue),
            _buildLine(),
            Text("160 Example St, NY", style: textStyleBlue),
            _buildLine(),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cimeditine 50 mg - 2 tabs TID", style: textStyleBlueW),
            Text("Oxprelol 50 mg - 2 tabs QD", style: textStyleBlueW),
            Text("Refill 0", style: textStyleBlueW, textAlign: TextAlign.start),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("13.07.2020   Dr. Jhon Doe", style: textStyleBlue),
            _buildLine(marginTop: 1, marginBottom: 5),
            Text("date / signature", style: textStyleGrey),
          ],
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.7;
    var width = MediaQuery.of(context).size.width * 0.8;
    var heightPaper = height *0.7;
    var widthPaper = width *0.9;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Stack(
          children: [
            //card
            ClipPath(
              clipper: PayCardComponent(),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: RadialGradient(
                    center: Alignment.centerRight,//const Alignment(0.8, 0.5),
                    radius: 1.3,
                    colors: [
                      const Color.fromARGB(255, 233, 233, 233),
                      const Color.fromARGB(255, 255, 255, 255),
                    ],
                    stops: [0.4, 1.0],
                  ),
                ),
              ),
            ),
            //bar code
            Positioned(
              left: width * 0.075,
              top: height - height * 0.18,
              child: Container(
                height: height * 0.15,
                width: width *0.85,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("https://pngimage.net/wp-content/uploads/2018/05/barcode-png-tumblr-5.png")
                  )
                ),
              ),
            ),
            //shadow
            Positioned(
              left: width * 0.05,
              top: MediaQuery.of(context).padding.top-10,
              child: Transform.rotate(angle: -pi*1.005,
                child:
                  Container(
                  color: Color.fromARGB(255, 208, 212, 220),
                  height: heightPaper,
                  width: widthPaper,
                )
              )
            ),
            //paper
            Positioned(
              left: width * 0.05,
              top: MediaQuery.of(context).padding.top-10,
              child: Transform.rotate(angle: (pi*2) * 1.005,
                child:
                  Container(
                  color: Color.fromARGB(255, 247, 250, 250),
                  height: heightPaper,
                  width: widthPaper,
                  padding: EdgeInsets.all(15),
                  child: _buildContentPaper(),
                )
              )
            ),
            //clips
            Positioned(
              top: -0,
              right: width*0.1,
              child: SizedBox(
                height: 40,
                width: 20,
                child: CustomPaint(
                  painter: ClipsComponent(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PayCardComponent extends CustomClipper<Path> {
  final double heightPoint;
  PayCardComponent({this.heightPoint = 0.75});
  @override
  Path getClip(Size size) {
    var calc = 0.05;
    return Path()
      ..lineTo(0, size.height * heightPoint)
      ..quadraticBezierTo(15, size.height * heightPoint, 15, size.height* (heightPoint + calc/2))
      ..quadraticBezierTo(15, size.height* (heightPoint + calc), 0, size.height* (heightPoint + calc))
      ..lineTo(0, size.height * (heightPoint + calc))
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height *(heightPoint + calc))
      ..quadraticBezierTo(size.width-15, size.height* (heightPoint + calc), size.width-15, size.height* (heightPoint + calc/2))
      ..quadraticBezierTo(size.width-15, size.height* heightPoint, size.width, size.height* heightPoint)
      ..lineTo(size.width, size.height * heightPoint)
      ..lineTo(size.width, 0)
      ..close();
  }
  
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;  
  }
}

class ClipsComponent extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var strokeWidth = 4.0;
    var paint = Paint()
      ..color = Color.fromARGB(255, 168, 172, 179)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    

    //left
    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height);
    canvas.drawPath(path, paint);
    //right
    path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0.35);
    canvas.drawPath(path, paint);
    //middle
    path = Path()
      ..moveTo(size.width- (size.width-strokeWidth*2), size.height * 0.35)
      ..lineTo(size.width- (size.width-strokeWidth*2), size.height);
    canvas.drawPath(path, paint);

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width/2, 0),
        height: size.width,
        width: size.width,
      ),
      pi,
      pi,
      false,
      paint,
    );

    //middle
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width/2 + strokeWidth, size.height * 0.35),
        height: size.width-strokeWidth*2,
        width: size.width-strokeWidth*2,
      ),
      pi,
      pi,
      false,
      paint,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width/2, size.height),
        height: size.width,
        width: size.width,
      ),
      pi*2,
      pi,
      false,
      paint,
    );
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}