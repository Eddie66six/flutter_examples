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

  _buildProfileInfo(double widthCard){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Julia, 22",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)),
          Text("Harvard University",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16)),
          Container(
            width: widthCard,
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Material(
                    color: Color.fromARGB(255, 102, 129, 194),
                    child: InkWell(
                      child: SizedBox(width: 56, height: 56, child: Icon(Icons.close, color: Colors.white)),
                      onTap: () {},
                    ),
                  ),
                ),
                SizedBox(width: 40),
                ClipOval(
                  child: Material(
                    color: Color.fromARGB(255, 28, 199, 33),
                    child: InkWell(
                      child: SizedBox(width: 56, height: 56, child: Icon(Icons.check, color: Colors.white)),
                      onTap: () {},
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  _buildCardImage(double height, double width, {String urlImage}){
    var largeRadius = 80.0;
    var smallRadius = 10.0;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: urlImage != null ? null : LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(230, 43, 66, 148),
            Colors.transparent
          ],
          stops: [
            0.15,
            0.5
          ]
        ),
        image: urlImage == null ? null : DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(urlImage)
          ),
          color: Colors.red,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(smallRadius),
          topRight: Radius.circular(largeRadius),
          bottomLeft: Radius.circular(largeRadius),
          bottomRight: Radius.circular(smallRadius  * 3)
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.7;
    var width = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                _buildCardImage(
                  height,
                  width,
                  urlImage: "https://uploads.disquscdn.com/images/dc368ebd907dfb3c40406ed0c842b10023f20651969cbd4bf77e524b3bf29ce7.jpg"
                ),
                _buildCardImage(
                  height,
                  width
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: _buildProfileInfo(width),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 100,
                    height: 40,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 28, 199, 33),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(child: Text("active",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05)
          ],
        ),
      ),
    );
  }
}