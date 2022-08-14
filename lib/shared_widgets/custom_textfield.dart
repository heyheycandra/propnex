import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:technical_take_home/theme/colors.dart';
import 'package:technical_take_home/helper/app_scale.dart';

class CustomFormTextField extends StatelessWidget {
  final String? hint, label;
  final Function(String?)? onChanged, onAction;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputformat;
  final FocusNode? focusNode;
  final bool? readOnly, enabled;
  final int? maxLine, maxLength;
  final Widget? suffix;
  final String? errorMessage;

  const CustomFormTextField(
      {Key? key,
      this.hint,
      this.label,
      this.validator,
      this.onChanged,
      this.onAction,
      this.inputType,
      this.inputAction,
      this.focusNode,
      this.readOnly,
      this.onTap,
      this.controller,
      this.inputformat,
      this.enabled,
      this.maxLine,
      this.maxLength,
      this.suffix,
      this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enableInteractiveSelection: this.inputType != TextInputType.number,
      inputFormatters: inputType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null,
      readOnly: readOnly ?? false,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: inputType,
      maxLength: maxLength,
      maxLines: maxLine,
      // inputFormatters: inputformat,
      textInputAction: inputAction,
      onFieldSubmitted: onAction,
      onTap: onTap,
      style: TextStyle(color: sampleAppMainText, fontSize: context.scaleFont(15)),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: context.scaleFont(12), color: sampleAppDanger),
        errorText: errorMessage,
        counterText: '',
        suffixIcon: suffix,
        // suffixText: validator != null ? '*' : '',
        // suffixStyle: TextStyle(
        //   fontSize: context.scaleFont(14),
        //   color: sampleAppDanger,
        // ),
        enabled: enabled ?? true,
        labelText: label,
        labelStyle: TextStyle(
            fontSize: context.scaleFont(14),
            color: (enabled == null)
                ? sampleAppMainText
                : enabled!
                    ? sampleAppMainText
                    : sampleAppMainText),
        hintText: hint,
        hintStyle: TextStyle(fontSize: context.scaleFont(15)),
        filled: true,
        fillColor: (enabled == null)
            ? sampleAppFillField
            : !enabled!
                ? sampleAppDisabledTextField
                : sampleAppFillField,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: sampleAppUnselect)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: sampleAppUnselect)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: sampleAppBlack, width: 1.8)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: sampleAppDanger)),
        focusedErrorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: sampleAppDanger, width: 1.8)),
      ),
    );
  }
}

class NoBordersTextField extends StatelessWidget {
  final String? hint, label;
  final Function(String?)? onChanged, onAction;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputformat;
  final FocusNode? focusNode;
  final bool? readOnly, enabled;
  final int? maxLine, maxLength;
  final Widget? suffix, prefix;
  final String? errorMessage;

  const NoBordersTextField(
      {Key? key,
      this.hint,
      this.label,
      this.validator,
      this.onChanged,
      this.onAction,
      this.inputType,
      this.inputAction,
      this.focusNode,
      this.readOnly,
      this.onTap,
      this.controller,
      this.inputformat,
      this.enabled,
      this.maxLine,
      this.maxLength,
      this.suffix,
      this.prefix,
      this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enableInteractiveSelection: this.inputType != TextInputType.number,
      inputFormatters: inputType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null,
      readOnly: readOnly ?? false,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: inputType,
      maxLength: maxLength,
      maxLines: maxLine,
      // inputFormatters: inputformat,
      textInputAction: inputAction,
      onFieldSubmitted: onAction,
      onTap: onTap,
      style: TextStyle(color: sampleAppMainText, fontSize: context.scaleFont(15)),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: context.scaleFont(12), color: sampleAppDanger),
        errorText: errorMessage,
        counterText: '',
        prefixIcon: prefix,
        suffixIcon: suffix,
        enabled: enabled ?? true,
        labelText: label,
        labelStyle: TextStyle(
            fontSize: context.scaleFont(14),
            color: (enabled == null)
                ? sampleAppMainText
                : enabled!
                    ? sampleAppMainText
                    : sampleAppMainText),
        hintText: hint,
        hintStyle: TextStyle(fontSize: context.scaleFont(15)),
        filled: true,
        fillColor: (enabled == null)
            ? sampleAppFillField
            : !enabled!
                ? sampleAppDisabledTextField
                : sampleAppFillField,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}
