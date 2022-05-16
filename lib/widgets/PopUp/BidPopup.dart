import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/bid_item.dart';
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
                        const TargetWidget(),
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
                      child: ListView(
                        children: widget.childrenBid,
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

  _makeBid() {
    debugPrint('Make Bid');
  }

}
