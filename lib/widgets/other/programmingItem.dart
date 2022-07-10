import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/other/Flutter%20Logo.dart';

class ProgrammingItem extends StatefulWidget {
  String name;
  dynamic icon;
  bool isSelected;
  Function() onTap;

  ProgrammingItem({
    Key? key,
    required this.name,
    required this.icon,
    this.isSelected = true,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ProgrammingItem> createState() => _ProgrammingItemState();
}

class _ProgrammingItemState extends State<ProgrammingItem> {
  Color iconColor = globals.white1;
  Color iconColor2 = globals.white2;
  final double _containerSize = 40;
  final double _iconSize = 25;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        widget.isSelected = !widget.isSelected;
        widget.onTap();
      }),
      child: widget.icon.runtimeType == IconData
          ? widget.isSelected == true
              ? Container(
                  height: _containerSize,
                  width: _containerSize,
                  margin: const EdgeInsets.all(6.0),
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  child: Icon(
                    widget.icon,
                    size: _iconSize,
                    color: iconColor2,
                  ),
                )
              : Container(
                  height: _containerSize,
                  width: _containerSize,
                  margin: const EdgeInsets.all(6.0),
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    widget.icon,
                    size: _iconSize,
                    color: iconColor,
                  ),
                )

          /// Flutter
          : widget.icon.runtimeType == String && widget.icon == 'Flutter'
              ? widget.isSelected == true
                  ? Container(
                      height: _containerSize,
                      width: _containerSize,
                      margin: const EdgeInsets.all(6.0),
                      padding: const EdgeInsets.all(6.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: iconColor,
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      child: MyFlutterLogo(
                        size: _iconSize,
                        color: iconColor2,
                      ),
                    )
                  : Container(
                      height: _containerSize,
                      width: _containerSize,
                      margin: const EdgeInsets.all(6.0),
                      padding: const EdgeInsets.all(6.0),
                      alignment: Alignment.center,
                      child: MyFlutterLogo(
                        size: _iconSize,
                        color: iconColor,
                      ),
                    )
              : const SizedBox.shrink(),
    );
  }
}

class TaskProgrammingItem extends StatelessWidget {
  String name;
  dynamic icon;

  final Color _iconColor = globals.white1;
  final double _iconSize = 35;

  TaskProgrammingItem({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon.runtimeType == IconData
        ? Tooltip(
            message: name,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                size: _iconSize,
                color: _iconColor,
              ),
            ),
          )

        /// Flutter
        : icon.runtimeType == String && icon == 'Flutter'
            ? Tooltip(
                message: name,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: MyFlutterLogo(
                    size: _iconSize,
                    color: _iconColor,
                  ),
                ),
              )
            : const SizedBox.shrink();
  }
}
