import 'package:dayuri/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_text_field.dart';

class CommonQuantitySelector extends StatefulWidget {
  final int quantity;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;
  final ValueChanged<int>? onQuantityChanged;

  final double? height;
  final double? padding;
  final double? radius;

  /// Minimum quantity allowed
  final int minQuantity;

  /// Maximum quantity allowed
  final int? maxQuantity;

  const CommonQuantitySelector({
    super.key,
    required this.quantity,
    this.onDecrease,
    this.onIncrease,
    this.onQuantityChanged,
    this.height,
    this.padding,
    this.radius,
    this.minQuantity = 0,
    this.maxQuantity,
  });

  @override
  State<CommonQuantitySelector> createState() => _CommonQuantitySelectorState();
}

class _CommonQuantitySelectorState extends State<CommonQuantitySelector> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.quantity.toString());

    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant CommonQuantitySelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_focusNode.hasFocus && oldWidget.quantity != widget.quantity) {
      _controller.text = widget.quantity.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateQuantity(String value) {
    if (value.isEmpty) return;

    int? newQuantity = int.tryParse(value);

    if (newQuantity == null) return;

    // Minimum quantity
    if (newQuantity < widget.minQuantity) {
      newQuantity = widget.minQuantity;
    }

    // Maximum quantity
    if (widget.maxQuantity != null && newQuantity > widget.maxQuantity!) {
      newQuantity = widget.maxQuantity!;
    }

    widget.onQuantityChanged?.call(newQuantity);
  }

  void _submitQuantity() {
    if (_controller.text.trim().isEmpty) {
      _controller.text = widget.quantity.toString();
      return;
    }

    _updateQuantity(_controller.text);

    _controller.text = widget.quantity.toString();

    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMinQuantity = widget.quantity <= widget.minQuantity;

    final bool isMaxQuantity =
        widget.maxQuantity != null && widget.quantity >= widget.maxQuantity!;

    return Container(
      height: widget.height ?? AppSizes.s32,
      padding: EdgeInsets.all(widget.padding ?? AppSizes.p4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? AppSizes.r8),
        border: Border.all(color: context.greyC8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // MINUS

          CommonIconWidget(
            onTap: isMinQuantity ? null : widget.onDecrease,
            icon: Icons.remove,
            size: AppSizes.icon24,
            color: /*isMinQuantity ? context.greyC8 : */context.black,
          ),

          // QUANTITY TEXT FIELD
          Expanded(
            child: CommonTextFormField(
              controller: _controller,
              focusNode: _focusNode,
              filled: false,
              borderColor: AppColorsConstants.transparent,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              contentPadding: EdgeInsets.zero,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onFieldSubmitted: (_) {
                _submitQuantity();
              },
              onTap: () {
                _controller.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: _controller.text.length,
                );
              },
              labelText: '',
            ),
          ),
          /* // QUANTITY
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p12),
            child: CommonTextWidget(
              title: widget.quantity.toString(),
              fontSize: AppSizes.f14,
              fontWeight: FontWeight.w600,
            ),
          ),*/

          // PLUS
          CommonIconWidget(
            onTap: isMaxQuantity ? null : widget.onIncrease,
            icon: Icons.add,
            size: AppSizes.icon24,
            color: isMaxQuantity ? context.greyC8 : context.black,
          ),
        ],
      ),
    );
  }
}
