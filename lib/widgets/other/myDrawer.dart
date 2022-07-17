import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/api/my_api.dart';
import 'package:kwikcode_programmer_side/api/my_session.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/errorWarningPopup.dart';
import 'package:kwikcode_programmer_side/widgets/RankPage/RankItem.dart';
import 'package:kwikcode_programmer_side/widgets/RankPage/RankPage.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';
import 'package:kwikcode_programmer_side/widgets/other/NewsContainer.dart';
import 'package:kwikcode_programmer_side/widgets/other/StatusMap.dart';
import 'package:kwikcode_programmer_side/widgets/other/StrikeThroughWidget2.dart';
import 'package:kwikcode_programmer_side/widgets/other/programmingItem.dart';
import 'package:loading_animations/loading_animations.dart';

class MyDrawer extends StatefulWidget {
  Function(TaskSquare) onBid;

  MyDrawer({Key? key, required this.onBid}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  bool _isLoggedIn = false;

  String _status = '-9999';
  bool _isLoading = false;

  int _k = 0;
  final Map<String, int> _indexMap = {
    'My Tasks': 0,
    'My Bids': 1,
    'My Wallet': 2,
    'Ranks': 3,
    'Chat': 4,
    'News': 5,
    'Updates': 6,
    'Notifications': 7,
    'Settings': 8,
    'About': 9,
    'Logout': 10
  };

  Animation? _animation, _animation1, _animation2;
  AnimationController? _animationController;

  final double _drawerLeftSize = 324;
  double _drawerRightSize = 324;
  final double _drawerRightSize1 = 324;
  final double _drawerRightSize2 = 648;
  final double _drawerDividerSize = 24;
  final double _iconSize = 35;
  Widget _currentWidget = Container();

  @override
  void initState() {
    // TODO: implement initState
    _loadAnimation();
    _checkIsRank();
    //_loadIsLoggedIn();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    globals.drawerIsRank = false;
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    //double _width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _animationController!,
        builder: (BuildContext context, widget) {
          return SizedBox(
            width: _drawerLeftSize + _animation!.value,
            child: Drawer(
              child: Material(
                color: globals.darkBlue1,
                //HexColor('#222222'), //globals.blue1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: ScrollController(),
                  child: Row(
                    children: [
                      SizedBox(
                        width: _drawerLeftSize,
                        child: ScrollConfiguration(
                          behavior: MyCustomScrollBehavior()
                              .copyWith(scrollbars: false),
                          child: ListView(
                            controller: ScrollController(),
                            children: <Widget>[
                              Column(
                                children: [
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    height: 250,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      'Assets/Other/KwikCodeLogo.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 12),
                                        // const SizedBox(height: 22),
                                        const SearchFieldDrawer(),
                                        const SizedBox(height: 12),
                                        MenuItem(
                                          text: 'My Tasks',
                                          icon: NewIcons.tasks,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 0),
                                        ),
                                        const SizedBox(height: 5),
                                        MenuItem(
                                          text: 'My Bids',
                                          icon: Icons.timer_outlined,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 1),
                                        ),
                                        const SizedBox(height: 5),
                                        MenuItem(
                                          text: 'My Wallet',
                                          icon: NewIcons.wallet,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 2),
                                        ),
                                        const SizedBox(height: 5),
                                        MenuItem(
                                          text: 'Ranks',
                                          icon: Icons.leaderboard,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 3),
                                        ),
                                        const SizedBox(height: 5),
                                        MenuItem(
                                          text: 'Chat',
                                          icon: NewIcons.comments,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 4),
                                        ),
                                        const SizedBox(height: 5),
                                        MenuItem(
                                          text: 'News',
                                          icon: NewIcons.newspaper,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 5),
                                        ),
                                        const SizedBox(height: 5),
                                        MenuItem(
                                          text: 'Updates',
                                          icon: Icons.update,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 6),
                                        ),
                                        const SizedBox(height: 8),
                                        const Divider(color: Colors.white70),
                                        const SizedBox(height: 8),
                                        MenuItem(
                                          text: 'Notifications',
                                          icon: Icons.notifications_outlined,
                                          color: globals.white1,
                                          onClicked: () =>
                                              selectedItem(context, 7),
                                        ),
                                        MenuItem(
                                          text: 'Settings',
                                          icon: NewIcons.cogs,
                                          color: globals.white1,
                                          onClicked: () =>
                                              selectedItem(context, 8),
                                        ),
                                        MenuItem(
                                          text: 'About',
                                          icon: Icons.info,
                                          color: globals.white1,
                                          onClicked: () =>
                                              selectedItem(context, 9),
                                        ),
                                        const SizedBox(height: 8),
                                        MenuItem(
                                          text: 'Logout',
                                          icon: Icons.logout,
                                          color: globals.red1,
                                          onClicked: () =>
                                              selectedItem(context, 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      _status != '-9999'
                          ? const VerticalDivider(color: Colors.white70)
                          : const SizedBox(),
                      _status != '-9999'
                          ? Column(
                              children: [
                                const SizedBox(height: 20),
                                Transform(
                                  transform: Matrix4.translationValues(
                                      0.0, _animation1?.value * _height, 0.0),
                                  child: SizedBox(
                                    width: _drawerRightSize,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          onTap: () => _onBackTap(),
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: globals.white2,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            _status,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 26,
                                              color: globals.white2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            onTap: () => _isLoading == false
                                                ? _refreshDrawer(_status)
                                                : null,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                _isLoading == false
                                                    ? Icon(
                                                        NewIcons.sync_alt,
                                                        color: globals.white2,
                                                      )
                                                    : SizedBox(
                                                        height: 24.0,
                                                        width: 24.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: globals.white2,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Expanded(
                                  child: Transform(
                                    transform: Matrix4.translationValues(
                                        0.0, _animation2?.value * _height, 0.0),
                                    child: _currentWidget,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      _status != '-9999'
                          ? const SizedBox(width: 8.0)
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    if (_isLoading == false) {
      //Navigator.of(context).pop();
      switch (index) {
        case 0: // My Tasks
          await _case0();
          break;
        case 1: // My Bids
          await _case1();
          break;
        case 2: // My Wallet
          await _case2();
          break;
        case 3: // Rank
          await _case3();
          break;
        case 4: // Chat
          await _case4();
          break;
        case 5: // News
          await _case5();
          break;
        case 6: // Updates
          await _case6();
          break;
        case 7: // Notifications
          await _case7();
          break;
        case 8: // Settings
          await _case8();
          break;
        case 9: // About
          await _case9();
          break;
        case 10: // Logout
          await _case10();
          break;
      }
    }
  }

  Future<void> _case0() async {
    if (_status != 'My Tasks') {
      _isLoadingTrue();
      debugPrint('My Tasks');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize1) {
        _drawerRightSize = _drawerRightSize1;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadMyTasks().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidget();
            }
            if (_snapShot.hasData) {
              return SizedBox(
                width: _drawerRightSize,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: _snapShot.data),
                  ),
                ),
              );
            }
            return _loadingWidget();
          });
    } else if (!_animationController!.isAnimating &&
        _status == 'My Tasks' &&
        _isLoading == false) {
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadMyTasks().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidget();
            }
            if (_snapShot.hasData) {
              return SizedBox(
                width: _drawerRightSize,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: _snapShot.data),
                  ),
                ),
              );
            }
            return _loadingWidget();
          });
    }
    _status = 'My Tasks';
  }

  Future<void> _case1() async {
    if (_status != 'My Bids') {
      _isLoadingTrue();
      debugPrint('My Bids');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize1) {
        _drawerRightSize = _drawerRightSize1;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadMyBids().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidget();
            }
            if (_snapShot.hasData) {
              return SizedBox(
                width: _drawerRightSize,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: _snapShot.data),
                  ),
                ),
              );
            }
            return _loadingWidget();
          });
    } else if (!_animationController!.isAnimating &&
        _status == 'My Bids' &&
        _isLoading == false) {
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadMyBids().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidget();
            }
            if (_snapShot.hasData) {
              return SizedBox(
                width: _drawerRightSize,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: _snapShot.data),
                  ),
                ),
              );
            }
            return _loadingWidget();
          });
    }
    _status = 'My Bids';
  }

  Future<void> _case2() async {
    if (_status != 'My Wallet') {
      debugPrint('My Wallet');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize1) {
        _drawerRightSize = _drawerRightSize1;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadMyWallet().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidgetWallet();
            }
            if (_snapShot.hasData) {
              return Container(
                width: _drawerRightSize - 20,
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: globals.logoColorPink),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            width: 120,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: globals.logoColorPink,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: Text(
                              'US Dollar: ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: globals.darkBlue1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '\$ ${_snapShot.data[1]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                color: globals.white2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: globals.logoColorBlue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            width: 120,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: globals.logoColorBlue,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: Text(
                              'KwikPoints: ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: globals.darkBlue1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StrikeThroughWidget2(
                                  color: globals.white2,
                                  child: Text(
                                    'KP',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: globals.white2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${_snapShot.data[2]}', //$_myKwikPoints',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: globals.white2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return _loadingWidgetWallet();
          });
    } else if (!_animationController!.isAnimating &&
        _status == 'My Wallet' &&
        _isLoading == false) {
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadMyWallet().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidgetWallet();
            }
            if (_snapShot.hasData) {
              return Container(
                width: _drawerRightSize - 20,
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: globals.logoColorPink),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            width: 120,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: globals.logoColorPink,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: Text(
                              'US Dollar: ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: globals.darkBlue1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '\$ ${_snapShot.data[1]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                color: globals.white2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: globals.logoColorBlue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            width: 120,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: globals.logoColorBlue,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: Text(
                              'KwikPoints: ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: globals.darkBlue1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StrikeThroughWidget2(
                                  color: globals.white2,
                                  child: Text(
                                    'KP',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: globals.white2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${_snapShot.data[2]}', //$_myKwikPoints',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: globals.white2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return _loadingWidgetWallet();
          });
    }
    _status = 'My Wallet';
  }

  Future<void> _case3() async {
    if (_status != 'Ranks') {
      debugPrint('Ranks');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize2) {
        _drawerRightSize = _drawerRightSize2;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadRanks().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidgetRank();
            }
            if (_snapShot.hasData) {
              return Container(
                width: _drawerRightSize, // - 20,
                margin: const EdgeInsets.all(8.0),
                child: RankPage(
                    myKwikPoints: int.parse(_snapShot.data[0]),
                    childrenRankItem: _snapShot.data[1]),
              );
            }
            return RankPage(
                myKwikPoints: _snapShot.data[1],
                childrenRankItem: _snapShot.data[2]);
          });
    } else if (!_animationController!.isAnimating &&
        _status == 'Ranks' &&
        _isLoading == false) {
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadRanks().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidgetRank();
            }
            if (_snapShot.hasData) {
              return Container(
                width: _drawerRightSize, // - 20,
                margin: const EdgeInsets.all(8.0),
                child: RankPage(
                    myKwikPoints: int.parse(_snapShot.data[0]),
                    childrenRankItem: _snapShot.data[1]),
              );
            }
            return _loadingWidgetRank();
          });
    }
    _status = 'Ranks';
  }

  Future<void> _case4() async {
    if (_status != 'Chat') {
      debugPrint('Chat');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize1) {
        _drawerRightSize = _drawerRightSize1;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      setState(() {
        _currentWidget = SizedBox(
          width: _drawerRightSize,
        );
      });
      _status = 'Chat';
    }
    // Navigator.of(context).pop();
    warningPopup(context, 'Coming Soon!!');
  }

  Future<void> _case5() async {
    if (_status != 'News') {
      debugPrint('News');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize1) {
        _drawerRightSize = _drawerRightSize1;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadNews().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidgetNews();
            }
            if (_snapShot.hasData) {
              return SizedBox(
                width: _drawerRightSize,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: _snapShot.data),
                  ),
                ),
              );
            }
            return _loadingWidgetNews();
          });
    } else if (!_animationController!.isAnimating &&
        _status == 'News' &&
        _isLoading == false) {
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadNews().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidgetNews();
            }
            if (_snapShot.hasData) {
              return SizedBox(
                width: _drawerRightSize,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: _snapShot.data),
                  ),
                ),
              );
            }
            return _loadingWidgetNews();
          });
    }
    _status = 'News';
  }

  Future<void> _case6() async {
    if (_status != 'Updates') {
      debugPrint('Updates');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize1) {
        _drawerRightSize = _drawerRightSize1;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadUpdates().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidgetUpdates();
            }
            if (_snapShot.hasData) {
              return SizedBox(
                width: _drawerRightSize,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: _snapShot.data),
                  ),
                ),
              );
            }
            return _loadingWidgetUpdates();
          });
    } else if (!_animationController!.isAnimating &&
        _status == 'Updates' &&
        _isLoading == false) {
      _isLoadingTrue();
      _currentWidget = FutureBuilder(
          future: _loadUpdates().whenComplete(() => _isLoadingFalse()),
          builder: (context, AsyncSnapshot _snapShot) {
            if (_snapShot.connectionState == ConnectionState.waiting) {
              return _loadingWidgetUpdates();
            }
            if (_snapShot.hasData) {
              return SizedBox(
                width: _drawerRightSize,
                child: ScrollConfiguration(
                  behavior:
                      MyCustomScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: _snapShot.data),
                  ),
                ),
              );
            }
            return _loadingWidgetUpdates();
          });
    }
    _status = 'Updates';
  }

  Future<void> _case7() async {
    if (_status != 'Notifications') {
      debugPrint('Notifications');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize1) {
        _drawerRightSize = _drawerRightSize1;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      setState(() {
        _currentWidget = SizedBox(
          width: _drawerRightSize,
        );
      });
      _status = 'Notifications';
      // }
      Navigator.of(context).pop();
      warningPopup(context, 'Coming Soon!!');
    }
  }

  Future<void> _case8() async {
    if (_status != 'Settings') {
      debugPrint('Settings');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize1) {
        _drawerRightSize = _drawerRightSize1;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      setState(() {
        _currentWidget = SizedBox(
          width: _drawerRightSize,
        );
      });
      _status = 'Settings';
    }
    Navigator.of(context).pop();
    warningPopup(context, 'Coming Soon!!');
  }

  Future<void> _case9() async {
    if (_status != 'About') {
      debugPrint('About');
      if (_status != '-9999') {
        await _animationController!.reverse();
      }

      /// Resize animation
      if (_drawerRightSize != _drawerRightSize2) {
        _drawerRightSize = _drawerRightSize2;
        _loadAnimation();
      }

      ///
      _animationController!.forward();
      setState(() {
        _currentWidget = Container(
          width: _drawerRightSize - 20,
          margin: const EdgeInsets.all(8.0),
          child: const StatusMap(),
        );
      });
      _status = 'About';
    }
  }

  Future<void> _case10() async {
    Navigator.of(context).pop();
    await SessionManager().destroy();

    Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
  }

  Future<void> _loadIsLoggedIn() async {
    if (await SessionManager().containsKey('isLoggedIn')) {
      _isLoggedIn = await SessionManager().get('isLoggedIn');
      _isLoggedIn;
    } else {
      _isLoggedIn = false;
      _case10();
    }
  }

  void _loadAnimation() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween(begin: 0, end: _drawerRightSize + _drawerDividerSize)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.fastOutSlowIn));
    _animation1 = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    _animation2 = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.15, 1.0, curve: Curves.fastOutSlowIn)));
  }

  _onBackTap() async {
    //Navigator.of(context).pop();
    await _animationController!.reverse().then((value) => setState(() {
          _status = '-9999';
          _currentWidget = const SizedBox();
        }));
  }

  void _checkIsRank() {
    if (globals.drawerIsRank == true) {
      selectedItem(context, 3);
    }
  }

  Future<void> _refreshDrawer(String index) async {
    debugPrint('Refresh Drawer');
    await selectedItem(context, _indexMap[_status]!);
    // await Future.delayed(const Duration(seconds: 2));
  }

  Future<List<TaskSquare>> _loadMyTasks() async {
    final List<TaskSquare> _childrenMyTasks = [];
    try {
      debugPrint(
          '=========>>======================================================>>==================================================>>=========');
      debugPrint('load tasks');

      var data = {
        'version': globals.version,
        'account_Id': await SessionManager().get('Id'),
      };

      // await Future.delayed(const Duration(seconds: 6));
      var res =
          await CallApi().postData(data, '/Tasks/Control/(Control)myTasks.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == 'Success') {
        if (mounted) {
          _childrenMyTasks.clear();

          for (List<dynamic> _element in body[1]) {
            List<TaskProgrammingItem> _listTaskProgrammingItem = [];

            for (List<dynamic> _element3 in _element[9]) {
              _listTaskProgrammingItem.add(TaskProgrammingItem(
                name: _element3[0],
                icon: _element3[1] == ''
                    ? NewIcons.question
                    // Icons.question_mark
                    // Icons.crop_square_sharp
                    : _element3[1] == 'Flutter'
                        ? _element3[1]
                        : IconData(
                            int.parse(_element3[1].replaceAll('"', '')),
                            fontFamily: _element3[2],
                          ),
              ));
            }
            DateTime _timeLeftTMP = DateTime.parse(_element[6])
                .add(Duration(seconds: int.parse(_element[5])));
            if (_timeLeftTMP.isAfter(DateTime.now())) {
              _childrenMyTasks.add(TaskSquare(
                key: ValueKey(_k++),
                taskId: _element[0],
                taskName: _element[1],
                //_element[2] project id
                projectName: '_projectName',
                projectManager: '@${_element[3]}',
                description: _element[4],
                timeLeft: _timeLeftTMP,
                status: int.parse(_element[7]),
                //_element[8] task date
                //_element[9] bid list
                iconList: _listTaskProgrammingItem,
                removeTask: (String taskId) => null,
                onBidTap: (String taskId) => null,
              ));
            }
          }
          return _childrenMyTasks;
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
    debugPrint('load tasks end!!!');
    debugPrint(
        '=========<<======================================================<<==================================================<<=========');
    return [];
  }

  Future<List<TaskSquare>> _loadMyBids() async {
    final List<TaskSquare> _childrenMyBids = [];
    try {
      debugPrint(
          '=========>>======================================================>>==================================================>>=========');
      debugPrint('load bids');

      var data = {
        'version': globals.version,
        'account_Id': await SessionManager().get('Id'),
      };

      var res = await CallApi()
          .postData(data, '/Bids/Control/(Control)loadMyBids.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == 'Success') {
        if (mounted) {
          _childrenMyBids.clear();

          for (List<dynamic> _element in body[1]) {
            List<TaskProgrammingItem> _listTaskProgrammingItem = [];

            for (List<dynamic> _element3 in _element[9]) {
              _listTaskProgrammingItem.add(TaskProgrammingItem(
                name: _element3[0],
                icon: _element3[1] == ''
                    ? NewIcons.question
                    // Icons.question_mark
                    // Icons.crop_square_sharp
                    : _element3[1] == 'Flutter'
                        ? _element3[1]
                        : IconData(
                            int.parse(_element3[1].replaceAll('"', '')),
                            fontFamily: _element3[2],
                          ),
              ));
            }
            DateTime _timeLeftTMP = DateTime.parse(_element[6])
                .add(Duration(seconds: int.parse(_element[5])));
            if (_timeLeftTMP.isAfter(DateTime.now())) {
              _childrenMyBids.add(TaskSquare(
                key: ValueKey(_k++),
                taskId: _element[0],
                taskName: _element[1],
                //_element[2] project id
                projectName: '_projectName',
                projectManager: '@${_element[3]}',
                description: _element[4],
                timeLeft: DateTime.parse(_element[6])
                    .add(Duration(seconds: int.parse(_element[5]))),
                status: int.parse(_element[7]),
                //_element[8] task date
                //_element[9] bid list
                iconList: _listTaskProgrammingItem,
                removeTask: (String taskId) => null,
                onBidTap: (String taskId) async {
                  await widget.onBid(_childrenMyBids
                      .firstWhere((_element2) => _element2.taskId == taskId));
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
              ));
            }
          }
          return _childrenMyBids;
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
    debugPrint('load bids end!!!');
    debugPrint(
        '=========<<======================================================<<==================================================<<=========');
    return [];
  }

  Future<List<dynamic>> _loadMyWallet() async {
    try {
      debugPrint(
          '=========>>======================================================>>==================================================>>=========');
      debugPrint('load wallet');

      var data = {
        'version': globals.version,
        'account_Id': await SessionManager().get('Id'),
      };

      var res = await CallApi()
          .postData(data, '/Wallet/Control/(Control)loadWallet.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == 'Success') {
        if (mounted) {
          return body;
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
    debugPrint('load wallet end!!!');
    debugPrint(
        '=========<<======================================================<<==================================================<<=========');
    return [];
  }

  Future<List<dynamic>> _loadRanks() async {
    final List<RankItem> _childrenRanks = [];
    try {
      debugPrint(
          '=========>>======================================================>>==================================================>>=========');
      debugPrint('load ranks');

      var data = {
        'version': globals.version,
        'account_Id': await SessionManager().get('Id'),
      };

      var res = await CallApi()
          .postData(data, '/Ranks/Control/(Control)loadRanks.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == 'Success') {
        if (mounted) {
          int _lastKPAmount = 0;
          int _rankIndex = 0;
          List<List<String>> _listTMP = [];

          for (var _e in body[2]) {
            _listTMP.add([_e[0], _e[1]]);
          }
          _listTMP.sort((List<String> a, List<String> b) =>
              int.parse(b[1]) - int.parse(a[1]));
          for (List<String> _element in _listTMP) {
            _childrenRanks.add(
              RankItem(
                rank: int.parse(_element[1]) == _lastKPAmount
                    ? _rankIndex
                    : ++_rankIndex,
                userName: _element[0],
                kwikPointsAmount: _element[1],
              ),
            );
            _lastKPAmount = int.parse(_element[1].toString());
          }
          return [body[1], _childrenRanks];
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
    return [];
  }

  Future<List<NewsContainer>> _loadNews() async {
    try {
      debugPrint(
          '=========>>======================================================>>==================================================>>=========');
      debugPrint('load news');

      var data = {
        'version': globals.version,
        'account_Id': await SessionManager().get('Id'),
      };

      var res =
          await CallApi().postData(data, '/News/Control/(Control)loadNews.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == 'Success') {
        if (mounted) {
          List<Color> _colorList = [
            globals.logoColorPink,
            globals.logoColorBlue
          ];
          int _colorCounter = 0;
          List<NewsContainer> _newsContainerList = [];

          for (var _element in body[1]) {
            _newsContainerList.add(NewsContainer(
                key: ValueKey(_element[0]),
                text: _element[1],
                date: _element[2],
                color: _colorList[(_colorCounter++) % _colorList.length],
                drawerRightSize: _drawerRightSize));
          }
          // _newsContainerList.add(NewsContainer(
          //     text: 'New Courses are available.',
          //     date: '28-05-2022 11:28',
          //     color: _colorList[(_colorCounter++) % _colorList.length],
          //     drawerRightSize: _drawerRightSize));
          // _newsContainerList.add(NewsContainer(
          //     text:
          //     'The app wil be closed from tomorrow \n(22/5/2022 12:30 UTC +2) \nuntil \n(22/5/2022 16:30 UTC +2).',
          //     date: '21-0-2022 18:22',
          //     color: _colorList[(_colorCounter++) % _colorList.length],
          //     drawerRightSize: _drawerRightSize));
          // _newsContainerList.add(NewsContainer(
          //   text: 'New Project is available.',
          //   date: '17-05-2022 07:44',
          //   color: _colorList[(_colorCounter++) % _colorList.length],
          //   drawerRightSize: _drawerRightSize,
          // ));
          return _newsContainerList;
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
    debugPrint('load news end!!!');
    debugPrint(
        '=========<<======================================================<<==================================================<<=========');
    return [];
  }

  Future<List<NewsContainer>> _loadUpdates() async {
    try {
      debugPrint(
          '=========>>======================================================>>==================================================>>=========');
      debugPrint('load news');

      var data = {
        'version': globals.version,
        'account_Id': await SessionManager().get('Id'),
      };

      var res = await CallApi()
          .postData(data, '/Updates/Control/(Control)loadUpdates.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == 'Success') {
        if (mounted) {
          List<Color> _colorList = [
            globals.logoColorPink,
            globals.logoColorBlue
          ];
          int _colorCounter = 0;
          List<NewsContainer> _updatesContainerList = [];

          for (var _element in body[1]) {
            _updatesContainerList.add(NewsContainer(
                key: ValueKey(_element[0]),
                text: _element[1],
                date: _element[2],
                color: _colorList[(_colorCounter++) % _colorList.length],
                drawerRightSize: _drawerRightSize));
          }

          // _updatesContainerList.add(NewsContainer(
          //     text: 'Version 1.0.1 is available.',
          //     date: '07-05-2022 18:58',
          //     color: _colorList[(_colorCounter++) % _colorList.length],
          //     drawerRightSize: _drawerRightSize));
          // _updatesContainerList.add(NewsContainer(
          //     text: 'Version 1.0.0 is available.',
          //     date: '02-05-2022 17:01',
          //     color: _colorList[(_colorCounter++) % _colorList.length],
          //     drawerRightSize: _drawerRightSize));
          return _updatesContainerList;
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
    debugPrint('load news end!!!');
    debugPrint(
        '=========<<======================================================<<==================================================<<=========');
    return [];
  }

  void _isLoadingTrue() {
    setState(() {
      _isLoading = true;
    });
  }

  void _isLoadingFalse() {
    setState(() {
      _isLoading = false;
    });
  }

  Widget _loadingWidget() {
    return SizedBox(
      width: _drawerRightSize,
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: LoadingBouncingGrid.square(
                  borderColor: globals.darkBlue1,
                  borderSize: 3.0,
                  size: 300.0,
                  backgroundColor: globals.darkBlue2,
                  duration: const Duration(milliseconds: 1000),
                ),
              ),
              const SizedBox(height: 8.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: LoadingBouncingGrid.square(
                  borderColor: globals.darkBlue1,
                  borderSize: 3.0,
                  size: 300.0,
                  backgroundColor: globals.darkBlue2,
                  duration: const Duration(milliseconds: 1000),
                ),
              ),
              const SizedBox(height: 8.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: LoadingBouncingGrid.square(
                  borderColor: globals.darkBlue1,
                  borderSize: 3.0,
                  size: 300.0,
                  backgroundColor: globals.darkBlue2,
                  duration: const Duration(milliseconds: 1000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingWidgetWallet() {
    return SizedBox(
      width: _drawerRightSize,
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  Widget _loadingWidgetRank() {
    return SizedBox(
      width: _drawerRightSize,
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  Widget _loadingWidgetNews() {
    return SizedBox(
      width: _drawerRightSize,
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  Widget _loadingWidgetUpdates() {
    return SizedBox(
      width: _drawerRightSize,
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback? onClicked;

  const MenuItem({
    required this.text,
    required this.icon,
    required this.color,
    this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Color color = globals.whiteBlue;//Colors.white;
    Color hoverColor = Colors.transparent.withOpacity(1); //Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

class SearchFieldDrawer extends StatelessWidget {
  const SearchFieldDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = globals.whiteBlue;

    return TextField(
      style: TextStyle(color: color, fontSize: 14),
      cursorColor: globals.logoColorPink,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(
          Icons.search,
          color: color,
          size: 20,
        ),
        filled: true,
        fillColor: globals.darkBlue1,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }
}
