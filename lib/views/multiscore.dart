import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:test/common/helper.dart';
import 'package:test/main.dart';
import 'package:test/provider/setting_provider.dart';
import 'package:test/views/widget/CheckboxButton.dart';

class MultiScoreScreen extends StatefulWidget {
  const MultiScoreScreen({Key? key}) : super(key: key);

  @override
  _MultiScoreScreenState createState() => _MultiScoreScreenState();
}

class _MultiScoreScreenState extends State<MultiScoreScreen> {
  late List<TextEditingController> players=[];
  List<int> mark=[];
  late Timer _timer;
  late DateTime? _dateTime;
  late int _points;
  int winner=0;
  late bool winnerByTwo;
  bool isEnd=false;
  bool isfirst=true,allDisable=false;
  @override
  void initState() {
    super.initState();
    setState(() {
    });
    _dateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _dateTime = _dateTime?.add(const Duration(seconds: 1));
      if (mounted) {
        setState(() {});
      }
    });
  }
  void checkCurrentRound(){
    int maxValue=mark.firstWhere((element) => element>=_points,orElse: () => 0);
    if(maxValue!=0){
      maxValue=mark.reduce((max));
      if(winnerByTwo){
        int mid=0;
        for(int i=0;i<mark.length;i++){
          if(maxValue-mark[i]<=1){
            mid++;
          }
        }
        if(mid==1){
          setState(() {
            isEnd=true;
            winner=mark.indexWhere((element) => element==maxValue);
          });
        }else{
          setState(() {
            isEnd=false;
          });
        }
      }else{
        maxValue=mark.reduce((max));
        int mid=0;
        for(int i=0;i<mark.length;i++){
          if(maxValue-mark[i]==0){
            mid++;
          }
        }
        if(mid==1){
          setState(() {
            isEnd=true;
            winner=mark.indexWhere((element) => element==maxValue);
          });
        }
        else{
          setState(() {
            isEnd=false;
          });
        }
      }
    }else{
      setState(() {
        isEnd=false;
      });
    }
  }
  void increase(int index){
    setState(() {
      mark[index]++;
      checkCurrentRound();
    });
  }
  void decrease(int index){
    setState(() {
      if(mark[index]!=0)
      {
        mark[index]--;
      }
      checkCurrentRound();
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
        for(int i=0;i<settingProvider.playerNumber;i++){
          mark.add(0);
          players.add(TextEditingController(text: 'Player ${i+1}'));
        }
        _points=settingProvider.points;
        winnerByTwo=settingProvider.winnerByTwo;
        isfirst=false;
      });
    }
    
    return Scaffold(
      resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(),
          title: const Text("Scoreboard"),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 50,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 110, 198, 210),
                        fontSize: 20)),
                child: const Text('Home'),
                onPressed: () {
                  Navigator.pop(context);     
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 110, 198, 210),
                        fontSize: 20)),
                child: const Text('Reset'),
                onPressed: () {
                  setState(() {
                    for(int i=0;i<settingProvider.playerNumber;i++){
                      mark[i]=0;
                      players[i]=TextEditingController(text: 'Player ${i+1}');
                    }
                    isfirst=false;
                    isEnd=true;
                    allDisable=false;
                  });
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 110, 198, 210),
                        fontSize: 20)),
                child: Text('End Game', style:isEnd ?const TextStyle(): const TextStyle(
                        color:Colors.grey)),
                onPressed: () {
                  if(isEnd){
                    showVictoryDialog(players[winner].text);
                    allDisable=true;
                  }
                },
              ),
            ],
          )
        ),
        body: SingleChildScrollView(
          child: InkWell(
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              color: Colors.white,
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
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade400, width: 3),
                      borderRadius: BorderRadius.circular(3.0),
                      color: const Color(0xFF9AEAFF)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Match Title:', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700, height: 0.7),),
                          const SizedBox(width: 15,),
                          Text(settingProvider.title, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700, height: 0.7,color: Colors.red),),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Ponts:', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700, height: 0.7),),
                          const SizedBox(width: 15,),
                          Text(settingProvider.points.toString(), style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700, height: 0.7,color: Colors.blue),),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade900, width: 5),
                      borderRadius: BorderRadius.circular(3.0),
                      color: const Color(0xFF84F184)),
                  child: ListView.builder(
                  itemCount: settingProvider.playerNumber,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (BuildContext context, int index){
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding:EdgeInsets.only(top: 8),
                                child: TextField(
                                  readOnly: allDisable?true:false,
                                  controller: players[index],
                                  style: const TextStyle(fontSize: 20,),
                                  textAlign: TextAlign.center,
                                  maxLength: 30,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    isDense: true,
                                    counter: Offstage(),
                                    border: OutlineInputBorder(),  
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 25),
                                        contentPadding:EdgeInsets.only(left: 10, top: 5, bottom: 5),
                                  ),
                                ),
                              ),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(color: const Color(0xFFFC4242))),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(mark[index].toString(), style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700, height: 1, color: Colors.black),))
                            ),
                            InkWell(
                              onTap: (){
                                if(allDisable){
                                  return;
                                }
                                increase(index);
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(60),
                                    color: const Color(0xFF05AF8F)),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('+', style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700, height: 1,color: Colors.white),)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                if(allDisable){
                                  return;
                                }
                                decrease(index);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(60),
                                    color: const Color(0xFFFC4242)),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('-', style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700, height: 1,color: Colors.white),)),
                              ),
                            ),
                          ],
                        ),
                      );
                  }),
                )
                  
              ]),
            ),
          ),
        ),
        
        );
  }
  showVictoryDialog(String playerName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Align(
          alignment: Alignment.center,
          child: Text("Victory")),
          contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3,),
          content: Text(playerName,style: TextStyle(fontSize: 20, color: Colors.red),),  
          buttonPadding: EdgeInsets.all(0),
          actions: <Widget>[
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
