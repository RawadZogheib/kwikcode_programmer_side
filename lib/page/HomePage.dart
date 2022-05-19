import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/api/my_api.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/MiddleView.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/MyFilter.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/RightView.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/projectSquare.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/BidPopup.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/bid_item.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/errorWarningPopup.dart';
import 'package:kwikcode_programmer_side/widgets/other/myDrawer.dart';
import 'package:kwikcode_programmer_side/widgets/other/programmingItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<BidItem> _bidChildren = [];
  int _k = 0;

  Animation? _animation;
  AnimationController? _animationController;

  List<ProjectSquare> _childrenProjectList = [];

  List<TaskSquare> _childrenTaskList = [];
  List<TaskSquare> _childrenTaskListNoFilter = [];

  bool _isLoadingTasks = false;
  bool _isClickedRefresh = false;

  //Color iconColor = globals.logoColorPink;
  //Color iconColor = globals.logoColorBlue;

  //BidPopup
  bool _animationIsActive = false;
  TaskSquare _childTaskIsActive = TaskSquare(
    key: const ValueKey('null'),
    taskId: 'null',
    taskName: 'null',
    projectManager: '@null',
    description: 'null',
    timeLeft: 0,
    iconList: const [],
    status: 0,
    removeTask: (String taskId) => debugPrint('null'),
    onBidTap: (String taskId) => debugPrint('null'),
  );

  @override
  void initState() {
    // TODO: implement initState
    globals.currentPage = 'HomePage';
    _loadAnimation();
    _loadNewPage();
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
          return WillPopScope(
            onWillPop: () async => _back(),
            child: Scaffold(
              endDrawer: const MyDrawer(),
              backgroundColor: globals.darkBlue1,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      WindowTitleBarBox(
                        child: Row(
                          children: [
                            const SizedBox(width: 5.0),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.asset(
                                'Assets/Other/KwikCodeLogo.png',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                'KwikCode',
                                style: TextStyle(
                                    fontSize: 14, color: globals.white2),
                              ),
                            ),
                            Expanded(child: MoveWindow()),
                            const WindowButtons()
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyFilter(
                              isClickedRefresh: _isClickedRefresh,
                              filterTasks: (String status,
                                      bool redRadio,
                                      bool orangeRadio,
                                      List<String> notLanguagesNameList) =>
                                  _filterTasks(status, redRadio, orangeRadio,
                                      notLanguagesNameList),
                              loadTasks: () => _loadTasks(),
                            ),
                            const SizedBox(width: 10),
                            MiddleView(
                              isLoadingTasks: _isLoadingTasks,
                              childrenTaskList: _childrenTaskList,
                            ),
                            const SizedBox(width: 10),
                            RightView(
                              isLoadingProjects: _isLoadingTasks,
                              childrenProjectList: _childrenProjectList,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        0.0, _animation?.value * _height, 0.0),
                    child: BidPopup(
                      childrenBid: _bidChildren,
                      childTaskIsActive: _childTaskIsActive,
                      onBackTap: () => _endAnimation(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _loadNewPage() async {
    await _loadTasks(); //0
    _filterTasks('alphaDown', true, true, []);
  }

  Future<void> _loadTasks() async {
    if (_isClickedRefresh == false) {
      try {
        debugPrint(
            '=========>>======================================================>>==================================================>>=========');

        if (mounted) {
          setState(() {
            _isLoadingTasks = true;
            _isClickedRefresh = true;
          });
        }
        debugPrint('load tasks');
        var res =
            await CallApi().getData('/Tasks/Control/(Control)loadTasks.php');
        print(res.body);
        List<dynamic> body = json.decode(res.body);

        if (body[0] == 'Success') {
          if (mounted) {
            setState(() {
              _isLoadingTasks = false;
              _isClickedRefresh = false;
            });
          }
        } else if (body[0] == "errorVersion") {
          errorPopup(context, globals.errorVersion);
        } else if (body[0] == "errorToken") {
          errorPopup(context, globals.errorToken);
        } else if (body[0] == "error4") {
          warningPopup(context, globals.warning7);
        } else if (body[0] == "error7") {
          warningPopup(context, globals.warning7);
        } else {
          if (mounted) {
            setState(() {
              _isLoadingTasks = true;
              _isClickedRefresh = false;
            });
          }
          errorPopup(context, globals.errorElse);
        }
      } catch (e) {
        debugPrint(e.toString());
        if (mounted) {
          setState(() {
            _isLoadingTasks = true;
            _isClickedRefresh = false;
          });
        }
        errorPopup(context, globals.errorException);
      }

      if (mounted) {
        setState(() {
          _isLoadingTasks = false;
          _isClickedRefresh = false;
        });
      }
      debugPrint('load tasks end!!!');
      debugPrint(
          '=========<<======================================================<<==================================================<<=========');
    }

    _childrenProjectList = [
      ProjectSquare(
        name: 'Project 1',
        imgUrl: null,
        onTap: () => debugPrint('Project 1'),
      ),
      ProjectSquare(
        name: 'Project 2',
        imgUrl: 'https://picsum.photos/100/100/?2',
        onTap: () => debugPrint('Project 2'),
      ),
      ProjectSquare(
        name: 'Project 3',
        imgUrl: null,
        onTap: () => debugPrint('Project 3'),
      ),
    ];
    _childrenTaskListNoFilter = [
      TaskSquare(
        key: const ValueKey('1'),
        taskId: '1',
        taskName: 'Task Name 1',
        projectManager: '@Samir',
        description: 'adsadsad asd  asd as d asd',
        timeLeft: 1000,
        iconList: [
          TaskProgrammingItem(name: 'Flutter', icon: 'Flutter'),
          TaskProgrammingItem(name: 'Node JS', icon: NewIcons.node),
        ],
        status: 0,
        removeTask: (String taskId) => _removeTask(taskId),
        onBidTap: (String taskId) => _startAnimation(taskId),
      ),
      TaskSquare(
        key: const ValueKey('2'),
        taskId: '2',
        taskName: 'Task Name 2',
        projectManager: '@Samira',
        description: 'adsadsad asd  asd as d asd',
        timeLeft: 100,
        iconList: [
          TaskProgrammingItem(name: 'Flutter', icon: 'Flutter'),
          TaskProgrammingItem(name: 'PHP', icon: NewIcons.php),
        ],
        status: 1,
        removeTask: (String taskId) => _removeTask(taskId),
        onBidTap: (String taskId) => _startAnimation(taskId),
      ),
      TaskSquare(
        key: const ValueKey('3'),
        taskId: '3',
        taskName: 'Task Name 3',
        projectManager: '@Samira',
        description: 'adsadsad asd  asd as d asd',
        timeLeft: 10000,
        iconList: [
          TaskProgrammingItem(name: 'HTML', icon: NewIcons.html5),
          TaskProgrammingItem(name: 'CSS', icon: NewIcons.css3_alt),
          TaskProgrammingItem(name: 'Java Script', icon: NewIcons.js),
          TaskProgrammingItem(name: 'PHP', icon: NewIcons.php),
        ],
        status: 0,
        removeTask: (String taskId) => _removeTask(taskId),
        onBidTap: (String taskId) => _startAnimation(taskId),
      ),
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
        status: 1,
        removeTask: (String taskId) => _removeTask(taskId),
        onBidTap: (String taskId) => _startAnimation(taskId),
      ),
      TaskSquare(
        key: const ValueKey('5'),
        taskId: '5',
        taskName: 'Task Name 5',
        projectManager: '@Samir',
        description: 'adsadsad asd  asd as d asd',
        timeLeft: 3,
        iconList: [
          TaskProgrammingItem(name: 'Flutter', icon: 'Flutter'),
          TaskProgrammingItem(name: 'PHP', icon: NewIcons.php),
          TaskProgrammingItem(name: 'Java Script', icon: NewIcons.js),
          TaskProgrammingItem(name: 'React Native', icon: NewIcons.react),
          TaskProgrammingItem(name: 'Unity', icon: NewIcons.unity),
          TaskProgrammingItem(name: 'CSS', icon: NewIcons.css3_alt),
          TaskProgrammingItem(name: 'HTML', icon: NewIcons.html5),
          TaskProgrammingItem(name: 'Swift', icon: NewIcons.swift),
          TaskProgrammingItem(name: 'Java', icon: NewIcons.java),
        ],
        status: 1,
        removeTask: (String taskId) => _removeTask(taskId),
        onBidTap: (String taskId) => _startAnimation(taskId),
      ),
      TaskSquare(
        key: const ValueKey('6'),
        taskId: '6',
        taskName: 'Task Name 6',
        projectManager: '@Samir',
        description:
            'adsadsad asd   askdjsa jk hjajk jjkoj jkoasj kodjqwskoa jasko jkaskojk kjas okjasko jasko jkoas jokj askoj dkosajko sda okjas jkojas jojas jokasj ko jaskodjkoasj koas dokjas kljasdko j koxj jo ij j ojas jojsad joj iou j  joasjjo joj asj jo sa ioj as j jos as das bnhjsagh  hjnn jhjjis jj j jijo j jojio joij  oijoi jojjjko jk as g hhhji hjih jihjjd io 7uyc enqwmne  cyu8 hhjvbcsdf y678sdyfc7897sx8 7hjkz yy  uiy iou hji hjckj m,nhj h78as asd fd casdf s  f  d cvv v gvcb x gxc   oj kojko jiok  jokj  jdjoj jo jas jojdo u djuo s duioa  ioj oiasd as d asd',
        timeLeft: 86400,
        iconList: [
          TaskProgrammingItem(name: 'HTML', icon: NewIcons.html5),
          TaskProgrammingItem(name: 'CSS', icon: NewIcons.css3_alt),
          TaskProgrammingItem(name: 'Java Script', icon: NewIcons.js),
          TaskProgrammingItem(name: 'PHP', icon: NewIcons.php),
        ],
        status: 0,
        removeTask: (String taskId) => _removeTask(taskId),
        onBidTap: (String taskId) => _startAnimation(taskId),
      ),
      TaskSquare(
        key: const ValueKey('7'),
        taskId: '7',
        taskName: 'Task Name 7',
        projectManager: '@Andrea',
        description:
            'adsadsad asd  a fhg f fglk  fghjkljh gsjfh d j  zd f  dsj kjsdhhjk d fh  hjasd h  hjk  hjsdjkl h sdjhkl fhj jksdl jf jksdhj  jk jjk hj jk dfh hjsd f kj hjdsf jklh klfdsjkl j jklxcj jkgsdjgfjikl sdfjkl  sj kj gjk jfjkl  jfjkl jdjk  g j djkl  jjksdfg jfjzdkj  jkdfg jjk jjk  jefsdjkf jjkcv  jjfjk jiojgkj jko j jdf jdfgjk gjket j jkod f jkfsjk  dfjgf jkfdj j ji jk  rj   xh fd   ui fjk j  g iuofgzdu  uio jfjk sd  jkf d   k j jks j sfjkl j jkfjgjk d fjgjkl dfjjk bjsdkj b njdfl jkfj qweopr ewio uriosed  cjn sd as d asd',
        timeLeft: 43000,
        iconList: [
          TaskProgrammingItem(name: 'Flutter', icon: 'Flutter'),
          TaskProgrammingItem(name: 'PHP', icon: NewIcons.php),
          TaskProgrammingItem(name: 'Java Script', icon: NewIcons.js),
          TaskProgrammingItem(name: 'React Native', icon: NewIcons.react),
          TaskProgrammingItem(name: 'CSS', icon: NewIcons.css3_alt),
          TaskProgrammingItem(name: 'Unity', icon: NewIcons.unity),
          TaskProgrammingItem(name: 'HTML', icon: NewIcons.html5),
          TaskProgrammingItem(name: 'Swift', icon: NewIcons.swift),
          TaskProgrammingItem(name: 'Java', icon: NewIcons.java),
        ],
        status: 1,
        removeTask: (String taskId) => _removeTask(taskId),
        onBidTap: (String taskId) => _startAnimation(taskId),
      ),
    ];

  }

  void _removeTask(String taskId) {
    if (mounted) {
      setState(() {
        // _childrenTaskList.removeAt(_childrenTaskList
        //     .indexWhere((element) => element.taskId == taskId));
        _childrenTaskListNoFilter
            .removeWhere((element) => element.taskId == taskId);
        _childrenTaskList.removeWhere((element) => element.taskId == taskId);
      });
    }
  }

  void _loadAnimation() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
  }

  Future<void> _startAnimation(String taskId) async {
    if (_animationIsActive == false) {
      await _loadBid();
      _childTaskIsActive = _childrenTaskListNoFilter[_childrenTaskListNoFilter
          .indexWhere((element) => element.taskId == taskId)];
      _animationIsActive = true;
      _animationController!.forward();
    }
  }

  Future<void> _endAnimation() async {
    if (_animationIsActive == true) {
      _animationIsActive = false;
      _animationController!
          .reverse()
          .then((value) => _childTaskIsActive = TaskSquare(
                key: const ValueKey('null'),
                taskId: 'null',
                taskName: 'null',
                projectManager: '@null',
                description: 'null',
                timeLeft: 0,
                iconList: const [],
                status: 0,
                removeTask: (String taskId) => debugPrint('null'),
                onBidTap: (String taskId) => debugPrint('null'),
              ));
      globals.isLoadingBid = false;
    }
  }

  void _filterTasks(String status, bool redRadio, bool orangeRadio,
      List<String> notLanguagesNameList) {
    /// alphaUp alphaDown numUp numDown
    //debugPrint(status);
    _childrenTaskList.clear();
    for (TaskSquare element in _childrenTaskListNoFilter) {
      _childrenTaskList.add(element);
    }

    ///Sort
    switch (status) {
      case 'alphaDown':
        // A -> Z
        _childrenTaskList.sort(
            (TaskSquare a, TaskSquare b) => a.taskName.compareTo(b.taskName));

        break;
      case 'alphaUp':
        // Z -> A
        _childrenTaskList.sort(
            (TaskSquare a, TaskSquare b) => b.taskName.compareTo(a.taskName));
        break;
      case 'numDown':
        // 1 -> 9
        _childrenTaskList
            .sort((TaskSquare a, TaskSquare b) => a.timeLeft - b.timeLeft);
        break;
      case 'numUp':
        // 9 -> 1
        _childrenTaskList
            .sort((TaskSquare a, TaskSquare b) => b.timeLeft - a.timeLeft);
        break;
    }

    ///Check Task Status
    if (redRadio == true && orangeRadio == true) {
      // _childrenTaskList = _childrenTaskListNoFilter;
    } else if (redRadio == true && orangeRadio == false) {
      _childrenTaskList = _childrenTaskListNoFilter
          .where((element) => element.status == 0)
          .toList();
    } else if (redRadio == false && orangeRadio == true) {
      _childrenTaskList = _childrenTaskListNoFilter
          .where((element) => element.status == 1)
          .toList();
    } else if (redRadio == false && orangeRadio == false) {
      _childrenTaskList.clear();
    }
    // if (redRadio == true) {
    //   for (TaskSquare element in _childrenTaskList) {
    //     if (element.status == 0) {
    //       element.isVisible = true;
    //     }
    //   }
    // } else {
    //   for (TaskSquare element in _childrenTaskList) {
    //     if (element.status == 0) {
    //       element.isVisible = false;
    //     }
    //   }
    // }
    //
    // if (orangeRadio == true) {
    //   for (TaskSquare element in _childrenTaskList) {
    //     if (element.status == 1) {
    //       element.isVisible = true;
    //     }
    //   }
    // } else {
    //   for (TaskSquare element in _childrenTaskList) {
    //     if (element.status == 1) {
    //       element.isVisible = false;
    //     }
    //   }
    // }

    ///Check Task Languages
    List<TaskSquare> toRemove = [];
    for (String lang in notLanguagesNameList) {
      for (TaskSquare element in _childrenTaskListNoFilter) {
        for (TaskProgrammingItem iconItem in element.iconList) {
          if (iconItem.name == lang) {
            if (_childrenTaskList.contains(element)) {
              toRemove.add(element);
            }
          }
          // if (iconItem.name == lang) {
          //   element.isVisible = false;
          //   continue;
          // }
        }
      }
    }
    _childrenTaskList.removeWhere((e) => toRemove.contains(e));

    ///SetState
    setState(() {
      _childrenTaskList;
    });
  }

  Future<void> _loadBid() async {
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Load Bid');

    List<BidItem> _bidChildrenTMP = [];
    _bidChildrenTMP.add(BidItem(
      bidName: 'Rawad',
      kwikPointsAmount: 1700,
      color: globals.white2,
    ));
    _bidChildrenTMP.add(BidItem(
      bidName: (_k++).toString(),
      kwikPointsAmount: 2300,
      color: globals.white2,
    ));
    _bidChildrenTMP.add(BidItem(
      bidName: (_k++).toString(),
      kwikPointsAmount: 1300,
      color: globals.white2,
    ));
    _bidChildrenTMP.add(BidItem(
      bidName: (_k++).toString(),
      kwikPointsAmount: 1600,
      color: globals.white2,
    ));
    _bidChildrenTMP.add(BidItem(
      bidName: (_k++).toString(),
      kwikPointsAmount: 2100,
      color: globals.white2,
    ));
    _bidChildrenTMP.add(BidItem(
      bidName: (_k++).toString(),
      kwikPointsAmount: 1800,
      color: globals.white2,
    ));
    _bidChildrenTMP.add(BidItem(
      bidName: (_k++).toString(),
      kwikPointsAmount: 1300,
      color: globals.white2,
    ));
    _bidChildrenTMP.sort(
        (BidItem a, BidItem b) => b.kwikPointsAmount - a.kwikPointsAmount);
    _bidChildrenTMP[0].color = globals.gold;
    _bidChildren = _bidChildrenTMP;
  }

  _back() {
    debugPrint('No back available.');
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: globals.white1,
    mouseOver: globals.white2,
    mouseDown: globals.white2,
    iconMouseOver: globals.white1,
    iconMouseDown: globals.white1);

final closeButtonColors = WindowButtonColors(
    iconNormal: Colors.red,
    mouseOver: Colors.red,
    mouseDown: Colors.red,
    iconMouseOver: globals.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(
          colors: closeButtonColors,
          onPressed: () => _onClose(),
        ),
      ],
    );
  }

  _onClose() {
    debugPrint('bye');
    appWindow.close();
  }
}
