import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/api/my_api.dart';
import 'package:kwikcode_programmer_side/api/my_session.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/PopUp/errorWarningPopup.dart';
import 'package:kwikcode_programmer_side/widgets/toolTip/toolTipWidgets.dart';
import 'package:super_tooltip/super_tooltip.dart';

class TargetWidget extends StatefulWidget {
  String taskId;

  TargetWidget({Key? key, required this.taskId}) : super(key: key);

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
    if (tooltip != null && tooltip!.isOpen) {
      // On screen change close not done
      tooltip!.close();
    }
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
    if (globals.isLoadingTooltip == false) {
      globals.isLoadingTooltip = true;
      debugPrint('Loading payment');
      try {
        debugPrint(
            '=========>>======================================================>>==================================================>>=========');
        var data = {
          'version': globals.version,
          'account_Id': await SessionManager().get('Id'),
          'task_Id': widget.taskId,
        };

        var res = await CallApi()
            .postData(data, '/Tasks/Control/(Control)getPayment.php');
        debugPrint(res.body);
        List<dynamic> body = json.decode(res.body);

        if (body[0] == 'Success') {
          if (mounted) {
            for (List<dynamic> _element in body[1]) {
              _toolTipList = [
                ['${_element[0]}', '${_element[1]}', '${_element[2]}'],
                ['${_element[3]}', '${_element[4]}', '${_element[5]}'],
                ['${_element[6]}', '${_element[7]}', '${_element[8]}'],
                ['${_element[9]}', '${_element[10]}', '${_element[11]}'],
              ];
            }
            print(_toolTipList);
            // setState((){
            _toolTipList;
            // });
            setState(() {
              _isClickedTooltip = false;
            });
            await Future.delayed(const Duration(milliseconds: 100));
            return true;
          }
        } else if (body[0] == "errorVersion") {
          errorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          errorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          warningPopup(context, globals.warning7);
        } else {
          errorPopup(context, globals.errorElse);
        }
      } catch (e) {
        debugPrint(e.toString());
        errorPopup(context, globals.errorException);
      }
      debugPrint('load payment end!!!');
      debugPrint(
          '=========<<======================================================<<==================================================<<=========');
      setState(() {
        _isClickedTooltip = false;
      });
      await Future.delayed(const Duration(milliseconds: 100));
      debugPrint('Loading toolTip end');
      return false;
    } else {
      setState(() {
        _isClickedTooltip = false;
      });
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
        debugPrint('false');
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
      globals.isLoadingTooltip = false;
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
