import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:flutter/material.dart';

class CommonDatePicker {
  const CommonDatePicker._();

  static Future<DateTime?> pickDate({
    required BuildContext context,
    DateTime? initialDate,
  }) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.primaryBlueColor,
              onPrimary: context.white,
              onSurface: context.black,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
