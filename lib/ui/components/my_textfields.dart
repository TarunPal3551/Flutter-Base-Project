import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final Key key;
  final String labelText;
  final void Function(String) onChanged;
  final VoidCallback trailingFunction;
  final String defaultValue;
  final bool showTrailingWidget;
  final Widget trailing;
  final bool autofocus;
  final TextEditingController controller;
  final Function(String) validator;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderWidth;
  final double focusedBorderWidth;
  final double borderRadius;
  final String hintText;
  final bool overrideHintText;
  final double width;
  final EdgeInsets margin;
  final EdgeInsets contentPadding;
  final Widget prefixIcon;
  final int maxLines;

  MyTextField({
    @required this.labelText,
    @required this.onChanged,
    this.key,
    this.hintText,
    this.trailingFunction,
    this.defaultValue,
    this.keyboardType,
    this.controller,
    this.validator,
    this.trailing,
    this.width,
    this.margin,
    this.maxLines = 1,
    this.prefixIcon,
    this.overrideHintText = false,
    this.showTrailingWidget = true,
    this.autofocus = false,
    this.isPasswordField = false,
    this.borderColor,
    this.focusedBorderColor,
    this.borderWidth = 1,
    this.focusedBorderWidth = 2,
    this.borderRadius = 20,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 20.0,
    ),
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _showPassword;

  @override
  void initState() {
    _showPassword = !widget.isPasswordField;
    super.initState();
  }

  void toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.width,
      // padding: const EdgeInsets.all(5.0),
      margin: this.widget.margin,
      child: TextFormField(
        controller: this.widget.controller,
        validator: this.widget.validator,
        initialValue: this.widget.defaultValue,
        textAlignVertical: TextAlignVertical.center,
        autofocus: this.widget.autofocus,
        keyboardType: this.widget.keyboardType,
        onChanged: this.widget.onChanged,
        obscureText: this.widget.isPasswordField ? !this._showPassword : false,
        maxLines: this.widget.maxLines,
        decoration: InputDecoration(
          hintText: 'Enter Value',
          hintStyle: TextStyle(fontSize: 15),
          contentPadding: this.widget.contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(this.widget.borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: this.widget.borderColor ?? Theme.of(context).accentColor,
              width: this.widget.borderWidth,
            ),
            borderRadius: BorderRadius.circular(this.widget.borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: this.widget.focusedBorderColor ??
                  Theme.of(context).accentColor,
              width: this.widget.focusedBorderWidth,
            ),
            borderRadius: BorderRadius.circular(this.widget.borderRadius),
          ),
        ).copyWith(
          hintText: this.widget.overrideHintText
              ? this.widget.hintText
              : "Enter ${this.widget.labelText}",
          labelText: this.widget.labelText,
          prefixIcon: this.widget.prefixIcon,
          suffixIcon: this.widget.showTrailingWidget
              ? this.widget.trailing == null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: this.widget.isPasswordField
                          ? IconButton(
                              splashRadius: 1,
                              icon: _showPassword
                                  ? Icon(Icons.visibility, size: 25.0)
                                  : Icon(Icons.visibility_off, size: 25.0),
                              onPressed: toggleShowPassword,
                            )
                          : null,
                    )
                  : this.widget.trailing
              : null,
        ),
      ),
    );
  }
}
