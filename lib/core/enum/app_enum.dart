import 'package:dayuri/core/constants/app_colors.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

enum ApiStatus {
  initial,
  loading,
  success,
  failure,
}

extension ApiStatusExtension on ApiStatus {
  bool get isInitial => this == ApiStatus.initial;

  bool get isLoading => this == ApiStatus.loading;

  bool get isSuccess => this == ApiStatus.success;

  bool get isFailure => this == ApiStatus.failure;
}

enum NoteType {
  text,
  // voice,
  followup;

  bool get isText => this == NoteType.text;

  // bool get isVoice => this == NoteType.voice;

  bool get isFollowUp => this == NoteType.followup;

  // Label for display
  String get label {
    switch (this) {
      case NoteType.text:
        return AppStringsConstants.text;
    // case NoteType.voice:
    //   return AppStringsConstants.voice;
      case NoteType.followup:
        return AppStringsConstants.followUp;
    }
  }

  // Icon for UI
  IconData get icon {
    switch (this) {
      case NoteType.text:
        return Icons.text_fields_outlined;
    // case NoteType.voice:
    //   return Icons.mic_none_outlined;
      case NoteType.followup:
        return Icons.calendar_today_outlined;
    }
  }
}


enum OrderStatus {
  draft,
  sent,
  sale,
  cancel;

  String get label => switch (this) {
    OrderStatus.draft => AppStringsConstants.quotation,
    OrderStatus.sent => AppStringsConstants.quotationSent,
    OrderStatus.sale => AppStringsConstants.saleOrder,
    OrderStatus.cancel => AppStringsConstants.cancelled,
  };

  Color get color => switch (this) {
    OrderStatus.draft => AppColorsConstants.grey89,
    OrderStatus.sent => AppColorsConstants.blue,
    OrderStatus.sale => AppColorsConstants.green,
    OrderStatus.cancel => AppColorsConstants.red,
  };

  String get apiValue => switch (this) {
    OrderStatus.draft => AppStringsConstants.draftL,
    OrderStatus.sent => AppStringsConstants.sentL,
    OrderStatus.sale => AppStringsConstants.saleL,
    OrderStatus.cancel => AppStringsConstants.cancelL,
  };

  static OrderStatus? fromString(String value) {
    final status = value.toLowerCase().trim();

    return switch (status) {
      AppStringsConstants.draftL => OrderStatus.draft,
      AppStringsConstants.sentL => OrderStatus.sent,
      AppStringsConstants.saleL => OrderStatus.sale,
      AppStringsConstants.cancelL => OrderStatus.cancel,
      _ => null,
    };
  }
}

enum AddressType {
  gpsLocation,
  shippingAddress,
  billingAddress;

  bool get isGpsLocation => this == AddressType.gpsLocation;

  bool get isShippingAddress => this == AddressType.shippingAddress;

  bool get isBillingAddress => this == AddressType.billingAddress;

  String get label {
    switch (this) {
      case AddressType.gpsLocation:
        return AppStringsConstants.gpsLocation;
      case AddressType.shippingAddress:
        return AppStringsConstants.shippingAddress;
      case AddressType.billingAddress:
        return AppStringsConstants.billingAddress;
    }
  }
}
