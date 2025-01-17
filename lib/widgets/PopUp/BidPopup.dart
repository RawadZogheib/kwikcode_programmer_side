import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/api/my_api.dart';
import 'package:kwikcode_programmer_side/api/my_session.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/bid_item.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/errorWarningPopup.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';
import 'package:kwikcode_programmer_side/widgets/toolTip/toolTip.dart';

class BidPopup extends StatefulWidget {
  List<BidItem> childrenBid;
  TaskSquare childTaskIsActive;
  Function onBackTap;

  BidPopup({
    Key? key,
    required this.childrenBid,
    required this.childTaskIsActive,
    required this.onBackTap,
  }) : super(key: key);

  @override
  State<BidPopup> createState() => _BidPopupState();
}

class _BidPopupState extends State<BidPopup> {
  //List<BidItem> _bidChildren = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;
    // if (globals.loadBid == false) {
    //   globals.loadBid = true;
    //   _loadBid();
    // }
    return Container(
      height: 530,
      //_height * 0.8,
      width: 640,
      //_width * 0.5,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: globals.darkBlue1,
        border: Border.all(color: globals.white1).scale(2.0),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Row(
            children: [
              const SizedBox(width: 20),
              InkWell(
                onTap: () => widget.onBackTap(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: globals.white2,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.childTaskIsActive.taskName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        color: globals.whiteBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () => _makeBid(),
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: globals.white2,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Text(
                    'Mak a bid',
                    style: TextStyle(
                        fontSize: 14,
                        color: globals.darkBlue1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 220,
                        decoration: BoxDecoration(
                          border: Border.all(color: globals.logoColorBlue)
                              .scale(1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            Text(
                              'Languages',
                              style: TextStyle(
                                fontSize: 18,
                                color: globals.white2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Expanded(
                              child: Container(
                                width: 210,
                                padding: const EdgeInsets.all(8.0),
                                child: ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior()
                                      .copyWith(scrollbars: false),
                                  child: SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Wrap(
                                      spacing: 12.0,
                                      alignment: WrapAlignment.center,
                                      children:
                                          widget.childTaskIsActive.iconList,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Task Payment: ',
                          style: TextStyle(
                              fontSize: 16,
                              color: globals.white2,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        TargetWidget(taskId: widget.childTaskIsActive.taskId),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: globals.darkBlue2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior()
                            .copyWith(scrollbars: false),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListView.builder(
                            controller: ScrollController(),
                            padding: const EdgeInsets.all(8.0),
                            itemCount: widget.childrenBid.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                widget.childrenBid[0].color = globals.gold;
                              } else {
                                widget.childrenBid[index].color =
                                    globals.white2;
                              }
                              return widget.childrenBid[index];
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _makeBid() async {
    String _userName = (await SessionManager().get('userName')).toString();
    for (var element in widget.childrenBid) {
      if (element.bidName == _userName) {
        errorPopup(context, globals.error401);
        return;
      }
    }
    debugPrint('Make Bid');

    try {
      debugPrint(
          '=========>>======================================================>>==================================================>>=========');
      debugPrint('load ranks');

      var data = {
        'version': globals.version,
        'account_Id': await SessionManager().get('Id'),
        'task_Id': widget.childTaskIsActive.taskId,
      };

      var res = await CallApi()
          .postData(data, '/Bids/Control/(Control)makeBid.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == 'Success') {
        if (mounted) {
          widget.childrenBid.add(
            BidItem(
              bidName: body[1],
              kwikPointsAmount: body[2],
              //await SessionManager().get('myKwikPoints')
              color: globals.white2,
            ),
          );
          widget.childrenBid.sort((BidItem a, BidItem b) =>
              b.kwikPointsAmount - a.kwikPointsAmount);

          setState(() {
            widget.childrenBid;
          });
        }
      } else if (body[0] == "errorVersion") {
        errorPopup(context, globals.errorVersion);
      } else if (body[0] == "errorToken") {
        errorPopup(context, globals.errorToken);
      } else if (body[0] == "error4") {
        warningPopup(context, globals.error4);
      } else {
        errorPopup(context, globals.errorElse);
      }
    } catch (e) {
      debugPrint(e.toString());
      errorPopup(context, globals.errorException);
    }
    debugPrint('load ranks end!!!');
    debugPrint(
        '=========<<======================================================<<==================================================<<=========');
  }
}
