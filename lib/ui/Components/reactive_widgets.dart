import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum ReactiveFields {
  TEXT,
  DROP_DOWN,
  PASSWORD,
  DATE_PICKER,
  DATE_PICKER_FIELD,
  CHECKBOX_LISTTILE,
  RADIO_LISTTILE
}

class ReactiveField extends StatelessWidget {
  @required
  final ReactiveFields type;
  @required
  final String controllerName;
  final int maxLines;
  final double width, height;
  final Map<String, String> validationMesseges;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  final String hint, title, radioVal;
  final dynamic checkboxVal;
  final Color borderColor, hintColor, textColor, fillColor, enabledBorderColor;
  final bool secure, autoFocus, readOnly, filled;
  final List<dynamic> items;
  final BuildContext context;
  final String label;
  final Widget suffexIcon;
  final Widget prefixIcon;
  final Function onDropDownChanged;
  final textDirection;
  final FocusNode focusNode;
  const ReactiveField(
      {this.type,
      this.controllerName,
      this.validationMesseges,
      this.hint,
      this.width = double.infinity,
      this.height = 60,
      this.keyboardType = TextInputType.emailAddress,
      this.secure = false,
      this.autoFocus = false,
      this.readOnly = false,
      this.label,
      this.textDirection = TextDirection.LTR,
      this.title = '',
      this.borderColor = Colors.grey,
      this.hintColor = Colors.black,
      // this.textColor = const Color(0xFFACBBC2),
      this.textColor = Colors.black,
      this.fillColor = Colors.transparent,
      // this.checkBoxCheckColor = AppColors.mainColor,
      this.enabledBorderColor = Colors.grey,
      this.maxLines = 1,
      this.filled = false,
      this.radioVal = '',
      this.checkboxVal = true,
      this.items,
      this.context,
      this.onDropDownChanged,
      this.suffexIcon,
      this.prefixIcon,
      this.focusNode,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      width: width,
      // height: height,
      child: buildReactiveField(locale),
    );
  }

  buildReactiveField(locale) {
    var validationM = validationMesseges ??
        {
          'required': locale.get("Required") ?? "Required",
          'minLength': locale.get("Password must exceed 8 characters") ??
              "Password must exceed 8 characters",
          'mustMatch': locale.get("Passwords doesn't match") ??
              "Passwords doesn't match",
          'email': locale.get("Please enter valid email") ??
              "Please enter valid email"
        };

    switch (type) {
      case ReactiveFields.TEXT:
        return ReactiveTextField(
          formControlName: controllerName,
          validationMessages: (controller) => validationM,
          keyboardType: keyboardType,
          style: TextStyle(color: textColor),
          readOnly: readOnly,
          maxLines: maxLines,
          decoration: decoration != null
              ? decoration
              : InputDecoration(
                  // labelStyle: TextStyle(color: Colors.blue),
                  filled: filled,
                  fillColor: fillColor,
                  // border: InputBorder.none,
                  // focusedBorder: InputBorder.none,
                  // enabledBorder: InputBorder.none,
                  // errorBorder: InputBorder.none,
                  // disabledBorder: InputBorder.none,

                  suffixIcon: suffexIcon,
                  prefix: prefixIcon,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: borderColor,
                      width: 2.0,
                    ),
                  ),

                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: borderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: enabledBorderColor,
                      width: 2.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),

                  labelText: label,
                  hintText: hint,

                  labelStyle: TextStyle(color: textColor),
                  hintStyle: TextStyle(color: hintColor),
                  // fillColor: Colors.grey,

                  // fillColor: Colors.white,
                ),
          autofocus: autoFocus,
        );
        break;
      case ReactiveFields.PASSWORD:
        return ReactiveTextField(
          formControlName: controllerName,
          validationMessages: (controller) => validationM,
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(color: textColor),
          decoration: decoration != null
              ? decoration
              : InputDecoration(
                  filled: filled,
                  fillColor: fillColor,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: borderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: enabledBorderColor,
                      width: 2.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),

                  labelText: label,
                  hintText: hint,

                  labelStyle: TextStyle(color: textColor),
                  hintStyle: TextStyle(color: hintColor),
                  // fillColor: Colors.grey,

                  // fillColor: Colors.white,
                ),
          autofocus: autoFocus,
          readOnly: readOnly,
          obscureText: true,
        );
        break;
      case ReactiveFields.DROP_DOWN:
        return ReactiveDropdownField(
          hint: Text(
            hint ?? " ",
            style: TextStyle(
                color: Color(0xFFACBBC2),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          items: items
              .map((item) => DropdownMenuItem<dynamic>(
                    value: item.sId,
                    child: new Text(
                      item.name.localized(context),
                      style: TextStyle(
                          color: Color(0xFFACBBC2),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
              .toList(),
          style: TextStyle(color: Color(0xFFACBBC2)),
          onChanged: onDropDownChanged,
          decoration: decoration != null
              ? decoration
              : InputDecoration(
                  // labelStyle: TextStyle(color: Colors.blue),
                  filled: filled,
                  fillColor: fillColor,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  labelText: label,
                  // hintText: hint,

                  labelStyle: TextStyle(color: textColor),
                  hintStyle: TextStyle(color: hintColor),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  // fillColor: Colors.white,
                  ),
          readOnly: readOnly,

          formControlName: controllerName,

          // style: TextStyle(color: textColor),
          // ),
        );
        break;
    }
  }
}
