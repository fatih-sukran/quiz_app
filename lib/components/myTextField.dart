import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final Key fieldKey;
  final int minLines;
  final int maxLines;
  final InputDecoration inputDecoration;
  final String labelText;
  final String hintText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  MyTextField({
    Key key,
    this.fieldKey,
    this.labelText,
    this.hintText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.minLines = 1,
    this.maxLines = 1,
    this.inputDecoration,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.black54, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.grey,
        ),
      ),
    );
  }
}
