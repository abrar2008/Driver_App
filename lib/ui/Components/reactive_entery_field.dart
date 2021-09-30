import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'dart:ui' as uii;
class ReactiveEntryField extends StatelessWidget {
  @required
  final int align;

  final String controller;
  final String label;
  final String image;
  final String initialValue;
  final bool readOnly;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final String hint;
  InputBorder border, errorBorder, enabledBorder;
  final Widget suffixIcon;
  final Function onTap;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  // final bool useImageWidget;
  final Widget imageWidget;

  ReactiveEntryField(
      {this.align,
        this.controller,
      this.label,
      this.image,
      this.initialValue,
      this.readOnly,
      this.keyboardType,
      this.maxLength,
      this.hint,
      this.border,
      this.maxLines,
      this.suffixIcon,
      this.onTap,
      this.textCapitalization,
      this.enabledBorder = InputBorder.none,
      this.errorBorder = InputBorder.none,
      this.obscureText = false,
      // this.useImageWidget = false,
      this.imageWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: ReactiveTextField(

        textAlign: align == 1 ? TextAlign.left :TextAlign.start ,
        textDirection : 1== align ? uii.TextDirection.ltr:null,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        cursorColor: kMainColor,
        onTap: onTap,
        autofocus: false,
        formControlName: controller,
        showErrors: (control) => control.invalid && control.touched && control.dirty,

        validationMessages: (control) => {
          ValidationMessage.required: 'must not be empty',
          ValidationMessage.email: 'The email value must be a valid email',
        },
        obscureText: obscureText,
        // initialValue: initialValue,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.caption,
        minLines: 1,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(

          suffixIcon: suffixIcon,
          labelText: label,
          hintText: hint,
          border: border,
          errorBorder: errorBorder,
          enabledBorder: enabledBorder,
          counter: Offstage(),
          icon: (image != null)
              ? ImageIcon(
                  AssetImage(image),
                  color: kMainColor,
                  size: 20.0,
                )
              : imageWidget,
        ),
      ),
    );
  }
}
