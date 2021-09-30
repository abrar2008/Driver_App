import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AlternativeTextField extends StatefulWidget {
  final String hint;
  final Color backgroundColor;
  final Color fontColor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPhoneNumber;
  final bool isPassword;
  final bool enabled;
  final prefix;
  final int maxLines;
  final TextInputAction textInputAction;
  final Function(String) onFieldSubmitted;
  final Function(String) onChanged;
  final FocusNode focusNode;
  final Function autoFill;
  final isAutoFill;
  final String label;
  final void Function(String) onSaved;
  final String Function(String) validator;

  const AlternativeTextField({
    Key key,
    this.hint,
    this.backgroundColor,
    this.fontColor,
    this.controller,
    this.keyboardType,
    this.isPhoneNumber: false,
    this.isPassword: false,
    this.prefix,
    this.enabled: true,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.focusNode,
    this.onChanged,
    this.autoFill,
    this.label,
    this.isAutoFill = false,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  _AlternativeTextFieldState createState() => _AlternativeTextFieldState();
}

class _AlternativeTextFieldState extends State<AlternativeTextField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: widget.backgroundColor,
        margin: EdgeInsets.all(8.0),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 0,
            ), // Platform.isIOS? 12: widget.maxLines > 1 ? 12: 0
            child: Row(
              crossAxisAlignment: widget.maxLines == 1
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: <Widget>[
                widget.prefix ?? Container(),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextFormField(
                    onSaved: widget.onSaved,
                    validator: widget.validator,
                    enabled: widget.enabled,
                    focusNode: widget.focusNode,
                    keyboardType: widget.keyboardType,
                    controller: widget.controller,
                    onFieldSubmitted: widget.onFieldSubmitted,
                    onChanged: widget.onChanged,
                    maxLines: widget.maxLines,
                    textInputAction: widget.textInputAction,
                    textDirection:
                        widget.isPhoneNumber ? TextDirection.ltr : null,
                    obscureText: widget.isPassword ? hidePassword : false,
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.enabled ? Colors.black : Colors.grey,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: widget.label,
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: widget.fontColor,
                      ),
                    ),
                  ),
                ),
                if (widget.isAutoFill)
                  IconButton(
                    icon: Icon(
                      Icons.auto_fix_high,
                      color: Colors.grey,
                    ),
                    onPressed: widget.autoFill,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
