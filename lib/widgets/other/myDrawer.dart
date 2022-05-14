import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/api/my_session.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/errorWarningPopup.dart';
import 'package:kwikcode_programmer_side/widgets/other/Flutter%20Logo.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';
import 'package:kwikcode_programmer_side/widgets/other/NewsContainer.dart';
import 'package:kwikcode_programmer_side/widgets/other/StatusMap.dart';
import 'package:kwikcode_programmer_side/widgets/other/StrikeThroughWidget2.dart';
import 'package:kwikcode_programmer_side/widgets/other/programmingItem.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  bool _isLoggedIn = false;

  String _statut = '-9999';

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
    _loadIsLoggedIn();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
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
                                          text: 'Chat',
                                          icon: NewIcons.comments,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 3),
                                        ),
                                        const SizedBox(height: 5),
                                        MenuItem(
                                          text: 'News',
                                          icon: NewIcons.newspaper,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 4),
                                        ),
                                        const SizedBox(height: 5),
                                        MenuItem(
                                          text: 'Updates',
                                          icon: Icons.update,
                                          color: globals.whiteBlue,
                                          onClicked: () =>
                                              selectedItem(context, 5),
                                        ),
                                        const SizedBox(height: 8),
                                        const Divider(color: Colors.white70),
                                        const SizedBox(height: 8),
                                        MenuItem(
                                          text: 'Notifications',
                                          icon: Icons.notifications_outlined,
                                          color: globals.white1,
                                          onClicked: () =>
                                              selectedItem(context, 6),
                                        ),
                                        MenuItem(
                                          text: 'Settings',
                                          icon: NewIcons.cogs,
                                          color: globals.white1,
                                          onClicked: () =>
                                              selectedItem(context, 7),
                                        ),
                                        MenuItem(
                                          text: 'About',
                                          icon: Icons.info,
                                          color: globals.white1,
                                          onClicked: () =>
                                              selectedItem(context, 8),
                                        ),
                                        const SizedBox(height: 8),
                                        MenuItem(
                                          text: 'Logout',
                                          icon: Icons.logout,
                                          color: globals.red1,
                                          onClicked: () =>
                                              selectedItem(context, 9),
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
                      _statut != '-9999'
                          ? const VerticalDivider(color: Colors.white70)
                          : const SizedBox(),
                      _statut != '-9999'
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
                                          onTap: () => _onBackTap(),
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: globals.white2,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _statut,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  color: globals.white2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 40),
                                            ],
                                          ),
                                        ),
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
                      _statut != '-9999'
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
    //Navigator.of(context).pop();
    switch (index) {
      case 0: // My Tasks
        _case0();
        break;
      case 1: // My Bids
        _case1();
        break;
      case 2: // My Wallet
        _case2();
        break;
      case 3: // Chat
        _case3();
        break;
      case 4: // News
        _case4();
        break;
      case 5: // Updates
        _case5();
        break;
      case 6: // Notifications
        _case6();
        break;
      case 7: // Settings
        _case7();
        break;
      case 8: // About
        _case8();
        break;
      case 9: // Logout
        _case9();
        break;
    }
  }

  Future<void> _case0() async {
    if (_statut != 'My Tasks') {
      debugPrint('My Tasks');
      if (_statut != '-9999') {
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
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(children: <Widget>[
                TaskSquare(
                  key: const ValueKey('4'),
                  taskId: '4',
                  taskName: 'Task Name 4',
                  projectManager: '@Samir',
                  description: 'adsadsad asd  asd as d asd',
                  timeLeft: 5600,
                  iconList: [
                    TaskProgrammingItem(name: 'Flutter', icon: 'Flutter'),
                    TaskProgrammingItem(name: 'PHP', icon: NewIcons.php),
                  ],
                  status: 2,
                  removeTask: (String taskId) =>
                      debugPrint(taskId),
                  onBidTap: (String taskId) =>
                      debugPrint(taskId),
                ),
              ]),
            ),
          ),
        );
      });
      _statut = 'My Tasks';
    }
  }

  Future<void> _case1() async {
    if (_statut != 'My Bids') {
      debugPrint('My Bids');
      if (_statut != '-9999') {
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
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(children: <Widget>[
                TaskSquare(
                  key: const ValueKey('3'),
                  taskId: '3',
                  taskName: 'Task Name 3',
                  projectManager: '@Samir',
                  description: 'adsadsad asd  asd as d asd',
                  timeLeft: 5600,
                  iconList: [
                    TaskProgrammingItem(name: 'Flutter', icon: 'Flutter'),
                    TaskProgrammingItem(name: 'PHP', icon: NewIcons.php),
                  ],
                  status: 1,
                  removeTask: (String taskId) =>
                      debugPrint(taskId),
                  onBidTap: (String taskId) =>
                      debugPrint(taskId),
                ),
              ]),
            ),
          ),
        );
      });
      _statut = 'My Bids';
    }
  }

  Future<void> _case2() async {
    if (_statut != 'My Wallet') {
      debugPrint('My Wallet');
      if (_statut != '-9999') {
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
        _currentWidget = Container(
          width: _drawerRightSize - 20,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: globals.logoColorPink),
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
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
                        '\$ 1200',
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
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
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
                            ' 1200',
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
      });
      _statut = 'My Wallet';
    }
  }

  Future<void> _case3() async {
    if (_statut != 'Chat') {
      debugPrint('Chat');
      if (_statut != '-9999') {
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
      _statut = 'Chat';
    }
    Navigator.of(context).pop();
    warningPopup(context, 'Coming Soon!!');
  }

  Future<void> _case4() async {
    if (_statut != 'News') {
      List<Color> _colorList = [globals.logoColorPink, globals.logoColorBlue];
      int _colorCounter = 0;
      List<NewsContainer> _newsContainerList = [];

      ///New to Old//////////////////////////////////
      _newsContainerList.add(NewsContainer(
          text: 'New Courses are available.',
          date: '28-05-2022 11:28',
          color: _colorList[(_colorCounter++) % _colorList.length],
          drawerRightSize: _drawerRightSize));
      _newsContainerList.add(NewsContainer(
          text:
              'The app wil be closed from tomorrow \n(22/5/2022 12:30 UTC +2) \nuntil \n(22/5/2022 16:30 UTC +2).',
          date: '21-0-2022 18:22',
          color: _colorList[(_colorCounter++) % _colorList.length],
          drawerRightSize: _drawerRightSize));
      _newsContainerList.add(NewsContainer(
        text: 'New Project is available.',
        date: '17-05-2022 07:44',
        color: _colorList[(_colorCounter++) % _colorList.length],
        drawerRightSize: _drawerRightSize,
      ));

      /// ///////////////////////////////////////////
      debugPrint('News');
      if (_statut != '-9999') {
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
        _currentWidget = Container(
          width: _drawerRightSize - 20,
          margin: const EdgeInsets.all(8.0),
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: _newsContainerList,
              ),
            ),
          ),
        );
      });
      _statut = 'News';
    }
  }

  Future<void> _case5() async {
    if (_statut != 'Updates') {
      List<Color> _colorList = [globals.logoColorPink, globals.logoColorBlue];
      int _colorCounter = 0;
      List<NewsContainer> _updatesContainerList = [];

      ///New to Old//////////////////////////////////
      _updatesContainerList.add(NewsContainer(
          text: 'Version 1.0.1 is available.',
          date: '07-05-2022 18:58',
          color: _colorList[(_colorCounter++) % _colorList.length],
          drawerRightSize: _drawerRightSize));
      _updatesContainerList.add(NewsContainer(
          text: 'Version 1.0.0 is available.',
          date: '02-05-2022 17:01',
          color: _colorList[(_colorCounter++) % _colorList.length],
          drawerRightSize: _drawerRightSize));

      /// ///////////////////////////////////////////
      debugPrint('Updates');
      if (_statut != '-9999') {
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
        _currentWidget = Container(
          width: _drawerRightSize - 20,
          margin: const EdgeInsets.all(8.0),
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: _updatesContainerList,
              ),
            ),
          ),
        );
      });
      _statut = 'Updates';
    }
  }

  Future<void> _case6() async {
    if (_statut != 'Notifications') {
      debugPrint('Notifications');
      if (_statut != '-9999') {
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
      _statut = 'Notifications';
    }
    Navigator.of(context).pop();
    warningPopup(context, 'Coming Soon!!');
  }

  Future<void> _case7() async {
    if (_statut != 'Settings') {
      debugPrint('Settings');
      if (_statut != '-9999') {
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
      _statut = 'Settings';
    }
    Navigator.of(context).pop();
    warningPopup(context, 'Coming Soon!!');
  }

  Future<void> _case8() async {
    if (_statut != 'About') {
      debugPrint('About');
      if (_statut != '-9999') {
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
      _statut = 'About';
    }
  }

  Future<void> _case9() async {
    Navigator.of(context).pop();
    await SessionManager().destroy();

    Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
  }

  Future<void> _loadIsLoggedIn() async {
    if (await SessionManager().containsKey('isLoggedIn')) {
      _isLoggedIn = await SessionManager().get('isLoggedIn');
      setState(() {
        _isLoggedIn;
      });
    } else {
      setState(() {
        _isLoggedIn = false;
      });
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
          _statut = '-9999';
          _currentWidget = const SizedBox();
        }));
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
