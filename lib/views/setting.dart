import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:test/common/helper.dart';
import 'package:test/provider/setting_provider.dart';
import 'package:test/views/widget/CheckboxButton.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {
  late Timer _timer;
  late DateTime? _dateTime;
  late int maxPlayerCount;
  late bool isfirst=true,winnerByTwo,winnerServe;
  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _dateTime = _dateTime?.add(const Duration(seconds: 1));
      if (mounted) {
        setState(() {});
      }
    });
  }
  getCurrentDate(DateTime? datetime) {
    var date =
        datetime != null ? datetime.toString() : DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate =
        "${dateParse.hour}:${dateParse.minute}:${dateParse.second}";
    return formattedDate.toString();
  }
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider =
        Provider.of<SettingProvider>(context, listen: true);
    if(isfirst){
      setState(() {
        maxPlayerCount=settingProvider.maxPlayerCount;
        winnerByTwo=settingProvider.winnerByTwo;
        winnerServe=settingProvider.winnerServe;
        isfirst=false;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        title: const Text("Setting Page"),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  getCurrentDate(_dateTime),
                  style: const TextStyle(color: Colors.blue, fontSize: 30),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.shade400, width: 3),
                  borderRadius: BorderRadius.circular(3.0),
                  color: const Color(0xFF9AEAFF)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Settings'),
                  Row(
                    children: [
                      const Text('Max Number of players'),
                      const SizedBox(
                        width: 20,
                      ),
                      NumberPicker(
                        value: maxPlayerCount,
                        itemCount: 1,
                        minValue: 2,
                        maxValue: 10,
                        onChanged: (value) {
                          setState(() {
                            maxPlayerCount=value;
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 100),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Winner by Two'),
                          CheckboxButton(
                            currentstatus: winnerByTwo,
                            onPressed: (){
                              setState(() {
                                winnerByTwo=!winnerByTwo;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Winner Serve'),
                          CheckboxButton(
                            currentstatus: winnerServe,
                            onPressed: (){
                              setState(() {
                                winnerServe=!winnerServe;
                              });
                            },
                          ),
                        ],
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      settingProvider.setWinnerByTwo(winnerByTwo);
                      settingProvider.setWinnerServe(winnerServe);
                      settingProvider.setMaxPlayerCount(maxPlayerCount);
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/match");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFFD2D2D4), width: 1),
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.blue),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  padding: const EdgeInsets.only(bottom: 80, right: 20),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 110, 198, 210),
                            fontSize: 20)),
                    child: const Text('Home'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/match");
                    },
                  )),
            ))
          ]),
        )
    );
  }
}
