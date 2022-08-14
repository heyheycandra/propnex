import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:technical_take_home/theme/colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_take_home/helper/app_scale.dart';

class LoginFormField extends StatefulWidget {
  final String? hint;
  final IconData? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboarType;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final double? keyboardHeight;
  final Function(String?)? onChange, onAction;
  final String? Function(String?)? validator;

  final void Function()? onIconTap;

  const LoginFormField(
      {this.isPassword = false,
      this.hint,
      this.suffixIcon,
      this.keyboarType,
      this.focusNode,
      this.keyboardHeight,
      this.onChange,
      this.validator,
      this.onAction,
      this.onIconTap,
      this.controller,
      this.textInputAction,
      Key? key})
      : super(key: key);
  @override
  _LoginFormFieldState createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      key: widget.key,
      obscureText: widget.isPassword,
      inputFormatters: widget.keyboarType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null,
      keyboardType: widget.keyboarType,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      scrollPadding: EdgeInsets.symmetric(vertical: widget.keyboardHeight ?? 0),
      style: TextStyle(color: sampleAppBlack, fontSize: context.scaleFont(16)),
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: GestureDetector(
          onTap: widget.onIconTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Icon(
              widget.suffixIcon,
              color: sampleAppLightBlue,
              size: context.scaleFont(22),
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 32,
          minWidth: 32,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: sampleAppGray,
          fontSize: context.scaleFont(14),
        ),
        labelText: widget.hint,
        labelStyle: TextStyle(fontSize: context.scaleFont(14), color: sampleAppAccent),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: sampleAppAccent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: sampleAppAccent,
          ),
        ),
        filled: true,
        fillColor: sampleAppFillField,
      ),
      onChanged: widget.onChange,
      onFieldSubmitted: widget.onAction,
      validator: widget.validator,
    );
  }
}
