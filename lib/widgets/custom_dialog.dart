import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Function(String) onChanged;
  final String textButton;
  final Function()? onPressed;
  final String label;

  const CustomDialog({
    Key? key,
    required this.onChanged,
    required this.textButton,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(textButton),
        ),
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(height: 20),
          TextFormField(
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
