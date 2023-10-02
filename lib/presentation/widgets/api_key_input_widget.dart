import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/custom_text_field.dart';

class ApiInputWidget extends StatefulWidget {
  final bool isRequired;
  final TextEditingController controller;
  final String hintText;
  final bool isActive;
  final Function(bool isActive) onChangeAction;
  final FormFieldValidator<String>? validator;
  const ApiInputWidget(
      {super.key,
      required this.isRequired,
      required this.controller,
      required this.hintText,
      this.validator,
      required this.isActive,
      required this.onChangeAction});

  @override
  State<ApiInputWidget> createState() => _ApiInputWidgetState();
}

class _ApiInputWidgetState extends State<ApiInputWidget> {
  bool isVisible = false;

  @override
  void didUpdateWidget(covariant ApiInputWidget oldWidget) {
    if (oldWidget.hashCode != widget.hashCode) {
      oldWidget = widget;
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
            flex: 3,
            child: CustomTextField(
              controller: widget.controller,
              hintText: widget.hintText,
              enable: widget.isActive,
              labelText: widget.hintText,
              obscureText: !isVisible,
              maxLines: 1,
              validator: widget.isActive ? widget.validator : null,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(
                  isVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
              ),
            )),
        if (!widget.isRequired)
          Flexible(
              child: Switch(
            value: widget.isActive,
            onChanged: (value) {
              widget.onChangeAction(!value);
            },
          ))
      ]),
    );
  }
}
