import 'package:flutter/material.dart';

class CircularMenuItem extends StatelessWidget {
  /// if icon and item are passed, icon will be ignored
  final Widget? item;

  /// Deprecated. Use [item] instead.
  @Deprecated('Use item instead')
  final AnimatedIcon? animatedIcon;

  /// if icon and item are passed, icon will be ignored
  final IconData? icon;
  final Color? color;
  final Color? iconColor;
  final VoidCallback onTap;
  final double iconSize;
  final double padding;
  final double margin;
  final List<BoxShadow>? boxShadow;
  final bool enableBadge;
  final double? badgeRightOffset;
  final double? badgeLeftOffset;
  final double? badgeTopOffset;
  final double? badgeBottomOffset;
  final double? badgeRadius;
  final TextStyle? badgeTextStyle;
  final String? badgeLabel;
  final Color? badgeTextColor;
  final Color? badgeColor;

  /// creates a menu item .
  /// [onTap] must not be null.
  /// [padding] and [margin]  must be equal or greater than zero.
  CircularMenuItem(
      {required this.onTap,
      this.item,
      @Deprecated('Use item instead') this.animatedIcon,
      this.icon,
      this.color,
      this.iconSize = 30,
      this.boxShadow,
      this.iconColor,
      this.padding = 10,
      this.margin = 10,
      this.enableBadge = false,
      this.badgeBottomOffset,
      this.badgeLeftOffset,
      this.badgeRightOffset,
      this.badgeTopOffset,
      this.badgeRadius,
      this.badgeTextStyle,
      this.badgeLabel,
      this.badgeTextColor,
      this.badgeColor})
      : assert(padding >= 0.0),
        assert(margin >= 0.0),
        assert(item == null || icon == null,
            'You can\'t use item and icon at the same time!');

  Widget _buildCircularMenuItem(BuildContext context, Widget? _item) {
    return Stack(clipBehavior: Clip.none, children: [
      Positioned(
          bottom: -2,
          right: -2,
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(45)),
              child: ClipOval(
                  child: Container(
                height: 40,
                width: 40,
                color: Theme.of(context).primaryColor,
              )))),
      Container(
          decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2),
              borderRadius: BorderRadius.circular(45)),
          child: ClipOval(
            child: Material(
              color: Theme.of(context).scaffoldBackgroundColor, // button color
              child: InkWell(
                splashColor: Theme.of(context).primaryColor, // inkwell color
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: _item != null
                      ? Center(child: _item)
                      : Icon(
                          icon,
                          color: Theme.of(context).primaryColor,
                          size: 19,
                        ),
                ),
                onTap: onTap,
              ),
            ),
          )),
    ]);
    // return       Container(
    //   margin: EdgeInsets.all(margin),
    //   decoration: BoxDecoration(
    //     color: Colors.transparent,
    //     boxShadow: boxShadow ??
    //         [
    //           BoxShadow(
    //             color: color ?? Theme.of(context).primaryColor,
    //             blurRadius: 10,
    //           ),
    //         ],
    //     shape: BoxShape.circle,
    //   ),
    //   child: ClipOval(
    //     child: Material(
    //       color: color ?? Theme.of(context).primaryColor,
    //       child: InkWell(
    //         child: Padding(
    //           padding: EdgeInsets.all(padding),
    //           child: _item == null
    //               ? Icon(
    //                   icon,
    //                   size: iconSize,
    //                   color: iconColor ?? Colors.white,
    //                 )
    //               : _item,
    //         ),
    //         onTap: onTap,
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _buildCircularMenuItemWithBadge(BuildContext context, Widget? _item) {
    return _Badge(
      color: badgeColor,
      bottomOffset: badgeBottomOffset,
      rightOffset: badgeRightOffset,
      leftOffset: badgeLeftOffset,
      topOffset: badgeTopOffset,
      radius: badgeRadius,
      textStyle: badgeTextStyle,
      onTap: onTap,
      textColor: badgeTextColor,
      label: badgeLabel,
      child: _buildCircularMenuItem(context, _item),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? _item = animatedIcon ?? item;
    return enableBadge
        ? _buildCircularMenuItemWithBadge(context, _item)
        : _buildCircularMenuItem(context, _item);
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    Key? key,
    required this.child,
    required this.label,
    this.color,
    this.textColor,
    required this.onTap,
    this.radius,
    this.bottomOffset,
    this.leftOffset,
    this.rightOffset,
    this.topOffset,
    this.textStyle,
  }) : super(key: key);

  final Widget child;
  final String? label;
  final Color? color;
  final Color? textColor;
  final VoidCallback onTap;
  final double? rightOffset;
  final double? leftOffset;
  final double? topOffset;
  final double? bottomOffset;
  final double? radius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: (leftOffset == null && rightOffset == null) ? 8 : rightOffset,
          top: (topOffset == null && bottomOffset == null) ? 8 : topOffset,
          left: leftOffset,
          bottom: bottomOffset,
          child: FittedBox(
            child: GestureDetector(
              onTap: onTap,
              child: CircleAvatar(
                maxRadius: radius ?? 10,
                minRadius: radius ?? 10,
                backgroundColor: color ?? Theme.of(context).primaryColor,
                child: FittedBox(
                  child: Text(
                    label ?? '',
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        TextStyle(
                          fontSize: 10,
                          color: textColor ?? Theme.of(context).accentColor,
                        ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
