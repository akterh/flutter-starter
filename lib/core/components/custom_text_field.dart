import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camerasync/core/components/input_label.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_style.dart';

class CustomTextField<T> extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.title,
    this.hint,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.onPress,
    this.errorText,
    this.prefixIconColor,
    this.suffixIconColor,
    this.fillColor,
    this.hintColor,
    this.onSaved,
    this.keyboardType,
    this.isEmail,
    this.borderThink,
    this.validator,
    this.prefixIconSize,
    this.suffixIconSizeWidth,
    this.suffixIconSizeHeight,
    this.onChanged,
    this.errorTextHeight,
    this.textColor,
    this.hintTextSize,
    this.height,
    this.width,
    this.radius,
    this.onTap,
    this.borderColor,
    this.isPassword = false,
    this.obscureText = false,
    this.readOnly = false,
    this.isDense = false,
    this.textInputAction = TextInputAction.next,
    this.errorStyle,
    this.underLineBorderColor,
    this.focusNode,
    this.isError = false,
    this.isRequired = true,
    this.isFocusedBorder = true,
    this.hintStyle,
    this.titleStyle,
    this.onTapOutside,
    this.maxLines = 1,
    this.style,
    this.maxLength,
    this.autofillHints,
  });

  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onPress;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? textColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final String? errorText;
  final double? prefixIconSize;
  final double? suffixIconSizeWidth;
  final double? suffixIconSizeHeight;
  final double? errorTextHeight;
  final double? hintTextSize;
  final double? height;
  final double? width;
  final double? radius;
  final FormFieldSetter<T>? onSaved;
  final FormFieldValidator<T>? validator;
  final bool? isEmail;
  final bool isPassword;
  final bool obscureText;
  final bool readOnly;
  final bool isDense;
  final double? borderThink;
  final TextInputAction? textInputAction;
  final TextStyle? errorStyle;
  final TextStyle? style;
  final Color? underLineBorderColor;
  final FocusNode? focusNode;
  final bool isError;
  final bool isRequired;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final TapRegionCallback? onTapOutside;
  final int? maxLines;
  final int? maxLength;
  final bool isFocusedBorder;
  final List<String>? autofillHints;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.radius ?? 16).r;

    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: widget.isError
            ? AppColors.kErrorColor1
            : widget.borderColor ?? AppColors.kWhiteColor,
        width: widget.borderThink ?? 1.0,
      ),
      borderRadius: borderRadius,
    );

    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: widget.isError
            ? AppColors.kErrorColor1
            : AppColors.kPrimaryColor400,
        width: widget.borderThink ?? 1.0,
      ),
      borderRadius: borderRadius,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          InputLabel(
            title: widget.title!,
            isRequired: widget.isRequired,
            textStyle: widget.titleStyle,
          ),
        TextFormField(
          controller: widget.controller,
          readOnly: widget.readOnly,
          focusNode: widget.focusNode,
          obscureText: obscureText,
          obscuringCharacter: "*",
          cursorColor: AppColors.kPrimaryColor700,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          style: widget.style ??
              kBodyRegularRegular.copyWith(
                color: AppColors.kFontBaseColor1,
              ),
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          validator: widget.validator,
          autofillHints: widget.autofillHints,
          onTapOutside: widget.onTapOutside,

          /// ✅ FIXED INPUT FORMATTERS
          inputFormatters: widget.keyboardType == TextInputType.number
              ? [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+(\.\d{0,6})?$'),
            ),
          ]
              : null,

          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor ?? AppColors.kWhiteColor,
            hintText: widget.hint ?? "",
            hintStyle: widget.hintStyle ??
                kBodyRegularRegular.copyWith(
                  color: AppColors.kGreyColor200,
                ),
            errorText: widget.errorText,
            errorStyle:
            kBodySmallRegular.copyWith(color: AppColors.kErrorColor1),
            contentPadding: EdgeInsets.symmetric(
              vertical: widget.height ?? 17.h,
              horizontal: widget.width ?? 16.w,
            ),
            isDense: widget.isDense,
            counter: const Offstage(),
            border: border,
            enabledBorder: border,
            focusedBorder: widget.isFocusedBorder ? focusedBorder : null,
            focusedErrorBorder: border,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? InkWell(
              onTap: _toggleVisibility,
              borderRadius: BorderRadius.circular(24.r), // Makes tap area circular
              child: Padding(
                padding: EdgeInsets.all(8.r), // Comfortable tap area
                child: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.kPrimaryColor400,
                  size: 24.r,
                ),
              ),
            )
                : widget.suffixIcon == null
                ? null
                : InkWell(
              onTap: widget.onPress,
              child: widget.suffixIcon,
            ),

          ),
        ),
      ],
    );
  }

  void _toggleVisibility() {
    setState(() => obscureText = !obscureText);
  }
}
