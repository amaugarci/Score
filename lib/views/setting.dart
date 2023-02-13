import 'dart:async';

import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
enum PLAYER {
  multi,
  two,
}
class _RegistrationScreenState extends State<RegistrationScreen> {
  late Timer _timer;
  late DateTime? _dateTime;
  PLAYER _playerCount = PLAYER.two;
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
                    children: const [
                      Text('Max Number of players'),
                      SizedBox(
                        width: 20,
                      ),
                      Text('2'),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 100),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Winner by Two'),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                            child: Radio(
                                value: PLAYER.two,
                                groupValue: _playerCount,
                                onChanged: (PLAYER? value) {
                                  setState(() {
                                    _playerCount = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Winner Serve'),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                            child: Radio(
                                value: PLAYER.multi,
                                groupValue: _playerCount,
                                onChanged: (PLAYER? value) {
                                  setState(() {
                                    _playerCount = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, "/setting");
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
                      Navigator.pushNamed(context, "/match");
                    },
                  )),
            ))
          ]),
        )
    );
  }
}
