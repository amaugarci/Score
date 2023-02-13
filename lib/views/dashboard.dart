import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool changed = false;
  String title = "Scoreboard ";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: Text(title),
      ),
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal:40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/match");
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD2D2D4), width: 1),
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.blue
                ),
                child:const Align(
                  alignment: Alignment.center,
                  child: Text('New Match',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/setting");
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD2D2D4), width: 1),
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.blue
                ),
                child:const Align(
                  alignment: Alignment.center,
                  child: Text('Setting',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
