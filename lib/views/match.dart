import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:test/common/helper.dart';
import 'package:test/provider/setting_provider.dart';
import 'package:test/views/widget/CheckboxButton.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final List<int> points = [11, 15, 16, 17, 18, 19, 20, 21];
  late bool winnerServe, winnerByTwo;
  List<int> players=[2];
  late TextEditingController controller;
  late Timer _timer;
  late DateTime? _dateTime;
  PLAYER _playerCount = PLAYER.two;
  int _round = 1;
  int _currentPlayerCount = 2, _point = 11;
  late String title;
  bool isfirst = true;
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
    if (isfirst) {
      setState(() {
        for(int i=2;i<settingProvider.maxPlayerCount;i++){
          players.add(i+1);
        }
        winnerByTwo=settingProvider.winnerByTwo;
        winnerServe=settingProvider.winnerServe;
        title = settingProvider.title;
        controller = TextEditingController(text: settingProvider.title);
        isfirst = false;
      });
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(),
          title: const Text("New Match"),
          centerTitle: true,
        ),
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
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
                    const Text('New Match'),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text('Number of players'),
                        const SizedBox(
                          width: 20,
                        ),
                        Center(
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                value: _currentPlayerCount,
                                buttonHeight: 30,
                                buttonWidth: 80,
                                onChanged: (value) {
                                  setState(() {
                                    _currentPlayerCount = value as int;
                                  });
                                },
                                icon: Container(),
                                buttonElevation: 2,
                                buttonPadding: const EdgeInsets.only(left: 25),
                                itemHeight: 30,
                                dropdownMaxHeight: 200,
                                dropdownWidth: 80,
                                dropdownPadding: null,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: const Color(0xFF9AEAFF),
                                ),
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 6,
                                scrollbarAlwaysShow: true,
                                items: players
                                .map((item) =>
                                  DropdownMenuItem<int>(
                                    value: item,
                                    child: Text(
                                      item.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                  .toList(),
                                ),
                            ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text('Multiple Players'),
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
                                    // setState(() {
                                    //   _playerCount = value!;
                                    // });
                                  }),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Two Players'),
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
                                    // setState(() {
                                    //   _playerCount = value!;
                                    // });
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _currentPlayerCount != 2
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text('Best of 1'),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Radio(
                                        value: 1,
                                        groupValue: _round,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _round = value!;
                                          });
                                        }),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('Best of 3'),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Radio(
                                        value: 3,
                                        groupValue: _round,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _round = value!;
                                          });
                                        }),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('Best of 5'),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Radio(
                                        value: 5,
                                        groupValue: _round,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _round = value!;
                                          });
                                        }),
                                  )
                                ],
                              )
                            ],
                          ),
                    _currentPlayerCount != 2
                        ? Container():
                    const SizedBox(height: 20,),
                    Row(children: [
                      const Text('Points'),
                      const SizedBox(
                        width: 20,
                      ),
                       Center(
                         child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              value: _point,
                              buttonHeight: 30,
                              buttonWidth: 80,
                              onChanged: (value) {
                                setState(() {
                                  _point = value as int;
                                });
                              },
                              icon: Container(),
                              buttonElevation: 2,
                              buttonPadding: const EdgeInsets.only(left: 25),
                              itemHeight: 30,
                              dropdownMaxHeight: 200,
                              dropdownWidth: 80,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: const Color(0xFF9AEAFF),
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              items: points
                              .map((item) =>
                                DropdownMenuItem<int>(
                                  value: item,
                                  child: Text(
                                    item.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                .toList(),
                              ),
                          ),
                       )
                    ]),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(right: 200),
                      child: Column(
                        children: [
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
                          const SizedBox(
                            height: 20,
                          ),
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Match Title:',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              height: 0.7),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            controller: controller,
                            onChanged: (value) {
                              setState(() {
                                title = value;
                              });
                            },
                            maxLength: 30,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              isDense: true,
                              counter: Offstage(),
                              border: UnderlineInputBorder(),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                              contentPadding:
                                  EdgeInsets.only(left: 16, top: 3, bottom: 3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        settingProvider.setPlayerNumber(_currentPlayerCount);
                        settingProvider.setBestOfNumber(_round);
                        settingProvider.setPonts(_point);
                        settingProvider.setTitle(controller.text);
                         settingProvider.setWinnerByTwo(winnerByTwo);
                          settingProvider.setWinnerServe(winnerServe);
                        if (_currentPlayerCount == 2) {
                          Navigator.pushNamed(context, "/twoscore");
                        } else {
                          Navigator.pushNamed(context, "/multiscore");
                        }
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
                            'Start',
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
                      child: const Text('Setting'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/setting");
                      },
                    )),
              ))
            ]),
          ),
        ));
  }
}
