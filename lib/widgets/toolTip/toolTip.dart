import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/toolTip/toolTipWidgets.dart';
import 'package:super_tooltip/super_tooltip.dart';

class TargetWidget extends StatefulWidget {
  const TargetWidget({Key? key}) : super(key: key);

  @override
  _TargetWidgetState createState() => _TargetWidgetState();
}

class _TargetWidgetState extends State<TargetWidget> {
  SuperTooltip? tooltip;
  bool _isClickedTooltip = false;

  //bool _isLoadingTooltip = true;
  List<List<String>> _toolTipList = [
    ['+0', '+0', '0'],
    ['+0', '+0', '0'],
    ['+0', '+0', '0'],
    ['+0', '+0', '0'],
  ];

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    // if (tooltip != null && tooltip!.isOpen ) {//on screen change close not done
    //   tooltip!.close();
    // }
    return Stack(
      children: [
        InkWell(
          onTap: () => onTap(),
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: Icon(
              Icons.info_outline,
              size: 20,
              color: globals.white1,
            ),
          ),
        ),
        _isClickedTooltip == true
            ? SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  color: globals.white1,
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Future<bool> _loadToolTip() async {
    if (globals.isLoadinTooltip == false) {
      globals.isLoadinTooltip = true;
      debugPrint('Loading toolTip');
      await Future.delayed(const Duration(seconds: 2));
      _toolTipList = [
        ['+400', '+5', '12'],
        ['+200', '+0', '4'],
        ['+50', '-5', '3'],
        ['-50', '-10', '8'],
      ];
      debugPrint('Loading toolTip end');
      return true;
    } else {
      debugPrint('false');
      return false;
    }
  }

  Future<void> onTap() async {
    if (_isClickedTooltip == false) {
      setState(() {
        _isClickedTooltip = true;
      });
      if (await _loadToolTip() == false) {
        return;
      }
      // if(_isLoadingTooltip == false){
      //   debugPrint('stop  onTap');
      //   return;
      // }

      // await _scrollUp();

      var renderBox = context.findRenderObject() as RenderBox;
      final overlay =
          Overlay.of(context)!.context.findRenderObject() as RenderBox?;

      var targetGlobalCenter = renderBox
          .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

      // We create the tooltip on the first use
      tooltip = SuperTooltip(
        minHeight: 500,
        maxHeight: 500,
        minWidth: 700,
        maxWidth: 700,
        popupDirection: TooltipDirection.up,
        arrowTipDistance: 15.0,
        arrowBaseWidth: 40.0,
        arrowLength: 20.0,
        borderColor: globals.darkBlue2,
        borderWidth: 2.0,
        snapsFarAwayVertically: true,
        showCloseButton: ShowCloseButton.none,
        hasShadow: true,
        touchThrougArea: Rect.zero,
        outsideBackgroundColor: globals.darkBlue1.withOpacity(0.6),
        backgroundColor: globals.darkBlue1,
        touchThroughAreaShape: ClipAreaShape.rectangle,
        content: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Task Payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: globals.whiteBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ToolTipWidget(
                      index: 0,
                      usdAmount: _toolTipList[0][0],
                      kpAmount: _toolTipList[0][1],
                      time: _toolTipList[0][2],
                      totalTime: _toolTipList[0][2],
                    ),
                    ToolTipWidget(
                      index: 1,
                      usdAmount: _toolTipList[1][0],
                      kpAmount: _toolTipList[1][1],
                      time: _toolTipList[1][2],
                      totalTime: (int.parse(_toolTipList[0][2]) +
                              int.parse(_toolTipList[1][2]))
                          .toString(),
                    ),
                    ToolTipWidget(
                      index: 2,
                      usdAmount: _toolTipList[2][0],
                      kpAmount: _toolTipList[2][1],
                      time: _toolTipList[2][2],
                      totalTime: (int.parse(_toolTipList[0][2]) +
                              int.parse(_toolTipList[1][2]) +
                              int.parse(_toolTipList[2][2]))
                          .toString(),
                    ),
                    ToolTipWidget(
                      index: 3,
                      usdAmount: _toolTipList[3][0],
                      kpAmount: _toolTipList[3][1],
                      time: _toolTipList[3][2],
                      totalTime: (int.parse(_toolTipList[0][2]) +
                              int.parse(_toolTipList[1][2]) +
                              int.parse(_toolTipList[2][2]) +
                              int.parse(_toolTipList[3][2]))
                          .toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      tooltip!.show(context);
      setState(() {
        _isClickedTooltip = false;
      });
      globals.isLoadinTooltip = false;
    }
  }
// Future<void> _scrollUp() async {
//   await globals.controllerMiddlePage.animateTo(
//     globals.controllerMiddlePage.position.maxScrollExtent,
//     duration: const Duration(seconds: 2),
//     curve: Curves.fastOutSlowIn,
//   );
// }
}
