import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';

class EntryField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String image;
  final String initialValue;
  final bool readOnly;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final String hint;
  final InputBorder border;
  final Widget suffixIcon;
  final Function onTap;
  final bool secure;
  final TextCapitalization textCapitalization;

  EntryField({
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
    this.secure = false,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        cursorColor: kMainColor,
        onTap: onTap,
        obscureText: secure,
        autofocus: false,
        controller: controller,
        initialValue: initialValue,
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
          counter: Offstage(),
          icon: (image != null)
              ? ImageIcon(
                  AssetImage(image),
                  color: kMainColor,
                  size: 20.0,
                )
              : null,
        ),
      ),
    );
  }
}
