import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.readOnly = false,
  });

  final String title;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconButton? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: validator,
          maxLines: 1,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
          ),
          readOnly: readOnly,
        ),
      ],
    );
  }
}
