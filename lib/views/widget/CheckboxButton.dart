import 'package:flutter/material.dart';

class CheckboxButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool currentstatus;
  const CheckboxButton(
      {Key? key, required this.onPressed, required this.currentstatus})
      : super(key: key);
  @override
  _CheckboxButtonState createState() => _CheckboxButtonState();
}

class _CheckboxButtonState extends State<CheckboxButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onPressed();
      },
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          border: Border.all(
              color: widget.currentstatus?Colors.blue:Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white),
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: widget.currentstatus?Colors.blue:Colors.white),
        ),
      ),
    );
  }
}
