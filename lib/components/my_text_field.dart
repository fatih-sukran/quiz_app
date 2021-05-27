import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/theme.dart';

class MyTextField extends StatefulWidget {
  final IconData prefixIconData;
  final IconData suffixIconData;
  final TextEditingController controller;
  final bool autoFocus;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function(String) onFieldSubmitted;
  final String Function(String) validator;
  final String label;
  final String hintLabel;

  const MyTextField({
    Key key,
    this.prefixIconData,
    this.suffixIconData,
    this.controller,
    this.autoFocus = false,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
    this.label,
    this.hintLabel,
  }) : super(key: key);
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (widget.label != null)
            Container(
              padding: EdgeInsets.only(left: 4.0),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.label,
                style: GoogleFonts.rubik(fontSize: 18, color: Colors.white),
              ),
            ),
          TextFormField(
            autofocus: widget.autoFocus,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            controller: widget.controller,
            validator: widget.validator,
            style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: MyTheme.secondaryColor,
                  width: 0.0,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: MyTheme.secondaryColor,
                  width: 0.0,
                ),
              ),
              prefixIcon: widget.prefixIconData == null
                  ? null
                  : Icon(
                      widget.prefixIconData,
                      size: 30,
                      color: MyTheme.secondaryColor,
                    ),
              suffixIcon: widget.suffixIconData == null
                  ? null
                  : Icon(widget.suffixIconData,
                      size: 30, color: MyTheme.secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
