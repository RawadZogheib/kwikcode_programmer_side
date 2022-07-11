import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/api/my_api.dart';
import 'package:kwikcode_programmer_side/api/my_session.dart';
import 'package:kwikcode_programmer_side/globals/filters.dart' as filters;
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
  int _l = 0;

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
    projectName: '',
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
              endDrawer: MyDrawer(onBid: (taskSquare) => _startAnimation2(taskSquare)),
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
                              filterTasks: () => _filterTasks(),
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
    _filterTasks();
  }

  Future<void> _loadTasks() async {
    if (_isClickedRefresh == false) {
      // try {
      debugPrint(
          '=========>>======================================================>>==================================================>>=========');

      if (mounted) {
        setState(() {
          _isLoadingTasks = true;
          _isClickedRefresh = true;
        });
      }
      debugPrint('load tasks');

      var data = {
        'version': globals.version,
        'account_Id': await SessionManager().get('Id'),
      };

      var res = await CallApi()
          .postData(data, '/Tasks/Control/(Control)loadTasks.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == 'Success') {
        if (mounted) {
          setState(() {
            _isLoadingTasks = false;
            _isClickedRefresh = false;
            _childrenTaskListNoFilter.clear();
            _childrenProjectList.clear();

            for (List<dynamic> _element in body[1]) {
              String _projectName = '';
              // String _projectMangerName = '';
              List<TaskProgrammingItem> _listTaskProgrammingItem = [];
              for (List<dynamic> _element2 in body[2]) {
                if (_element2[0] == _element[2]) {
                  _projectName = _element2[1];
                  // _projectMangerName = _element2[2];
                }
              }
              for (List<dynamic> _element3 in _element[8]) {
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
              _childrenTaskListNoFilter.add(TaskSquare(
                key: ValueKey(_k++),
                taskId: _element[0],
                taskName: _element[1],
                //_element[2] project id
                projectName: _projectName,
                projectManager: '@${_element[3]}',
                description: _element[4],
                timeLeft: int.parse(_element[5]),
                status: int.parse(_element[6]),
                //_element[7] task date
                //_element[8] bid list
                iconList: _listTaskProgrammingItem,
                removeTask: (String taskId) => _removeTask(taskId),
                onBidTap: (String taskId) => _startAnimation(taskId),
              ));
            }

            for (List<dynamic> _element3 in body[2]) {
              _childrenProjectList.add(ProjectSquare(
                key: ValueKey(_element3[0]),
                projectName: _element3[1],
                //_element3[2] project manager name
                //_element3[3] project date
                isSelected: true,
                imgUrl: null,
                //todo get image
                onTap: () => debugPrint('Project 1'),
                filterByProjects: () => _filterByProjects(_childrenProjectList),
              ));
              filters.projectSelectedSet.add(_element3[1]);
            }
          });
        }
      } else if (body[0] == "errorVersion") {
        errorPopup(context, globals.errorVersion);
      } else if (body[0] == "errorToken") {
        errorPopup(context, globals.errorToken);
      } else if (body[0] == "error4") {
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
      // } catch (e) {
      //   debugPrint(e.toString());
      //   if (mounted) {
      //     setState(() {
      //       _isLoadingTasks = true;
      //       _isClickedRefresh = false;
      //     });
      //   }
      //   errorPopup(context, globals.errorException);
      // }

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
      if(await _loadBid(taskId) == false){
        globals.isLoadingBid = false;
        return;
      }
      _childTaskIsActive = _childrenTaskListNoFilter[_childrenTaskListNoFilter
          .indexWhere((element) => element.taskId == taskId)];
      _animationIsActive = true;
      _animationController!.forward();
    }
  }

  Future<void> _startAnimation2(TaskSquare taskSquare) async {
    if (_animationIsActive == false) {
      if(await _loadBid(taskSquare.taskId) == false){
        globals.isLoadingBid = false;
        return;
      }
      _childTaskIsActive = taskSquare;
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
                projectName: '',
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

  void _filterTasks() {
    /// alphaUp alphaDown numUp numDown
    //debugPrint(status);
    _childrenTaskList.clear();

    ///Check Task Status
    if (filters.redRadio == false && filters.orangeRadio == false) {
      // _childrenTaskList.clear();
      ///SetState
      setState(() {
        _childrenTaskList;
      });
      return;
    }

    ///Check Task Languages
    for (TaskSquare _element in _childrenTaskListNoFilter) {
      if (!filters.projectSelectedSet.contains(_element.projectName)) {
        _childrenTaskList.add(TaskSquare(
          key: ValueKey(_k++),
          taskId: _element.taskId,
          taskName: _element.taskName,
          isVisible: false,
          projectName: _element.projectName,
          projectManager: _element.projectManager,
          description: _element.description,
          timeLeft: _element.timeLeft,
          status: _element.status,
          iconList: _element.iconList,
          removeTask: _element.removeTask,
          onBidTap: _element.onBidTap,
        ));
        continue;
      }

      if (filters.redRadio == true && filters.orangeRadio == false) {
        if (_element.status != 0) {
          _childrenTaskList.add(TaskSquare(
            key: ValueKey(_k++),
            taskId: _element.taskId,
            taskName: _element.taskName,
            isVisible: false,
            projectName: _element.projectName,
            projectManager: _element.projectManager,
            description: _element.description,
            timeLeft: _element.timeLeft,
            status: _element.status,
            iconList: _element.iconList,
            removeTask: _element.removeTask,
            onBidTap: _element.onBidTap,
          ));
          continue;
        }
      } else if (filters.redRadio == false && filters.orangeRadio == true) {
        if (_element.status != 1) {
          _childrenTaskList.add(TaskSquare(
            key: ValueKey(_k++),
            taskId: _element.taskId,
            taskName: _element.taskName,
            isVisible: false,
            projectName: _element.projectName,
            projectManager: _element.projectManager,
            description: _element.description,
            timeLeft: _element.timeLeft,
            status: _element.status,
            iconList: _element.iconList,
            removeTask: _element.removeTask,
            onBidTap: _element.onBidTap,
          ));
          continue;
        }
      }

      if (filters.notLanguagesNameList.isNotEmpty) {
        Set<String> _set1 = {};
        Set<String> _set2 = {};
        for (TaskProgrammingItem _e in _element.iconList) {
          _set1.add(_e.name);
        }
        for (ProgrammingItem _f in filters.languagesIconsList) {
          _set2.add(_f.name);
        }
        if (filters.notLanguagesNameList.contains('Other')) {
          if (!_set2.containsAll(_set1) || _set1.isEmpty) {
            _childrenTaskList.add(TaskSquare(
              key: ValueKey(_k++),
              taskId: _element.taskId,
              taskName: _element.taskName,
              isVisible: false,
              projectName: _element.projectName,
              projectManager: _element.projectManager,
              description: _element.description,
              timeLeft: _element.timeLeft,
              status: _element.status,
              iconList: _element.iconList,
              removeTask: _element.removeTask,
              onBidTap: _element.onBidTap,
            ));
            continue;
          }
        }
        if (_set1
            .intersection(filters.notLanguagesNameList.toSet())
            .isNotEmpty) {
          _childrenTaskList.add(TaskSquare(
            key: ValueKey(_k++),
            taskId: _element.taskId,
            taskName: _element.taskName,
            isVisible: false,
            projectName: _element.projectName,
            projectManager: _element.projectManager,
            description: _element.description,
            timeLeft: _element.timeLeft,
            status: _element.status,
            iconList: _element.iconList,
            removeTask: _element.removeTask,
            onBidTap: _element.onBidTap,
          ));
          continue;
        }
      }
      _childrenTaskList.add(TaskSquare(
        key: ValueKey(_k++),
        taskId: _element.taskId,
        taskName: _element.taskName,
        isVisible: true,
        projectName: _element.projectName,
        projectManager: _element.projectManager,
        description: _element.description,
        timeLeft: _element.timeLeft,
        status: _element.status,
        iconList: _element.iconList,
        removeTask: _element.removeTask,
        onBidTap: _element.onBidTap,
      ));
    }

    ///Sort
    switch (filters.sortStatus) {
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

    ///SetState
    setState(() {
      _childrenTaskList;
    });
  }

  Future<bool> _loadBid(String taskId) async {
    // await Future.delayed(const Duration(seconds: 2));
    try {
      List<BidItem> _bidChildrenTMP = [];
      debugPrint(
          '=========>>======================================================>>==================================================>>=========');
      debugPrint('load Bid');
      var data = {
        'version': globals.version,
        'account_Id': await SessionManager().get('Id'),
        'task_Id': taskId,
      };

      var res = await CallApi()
          .postData(data, '/Bids/Control/(Control)loadAllBids.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == 'Success') {
        if (mounted) {

          for (List<dynamic> _element in body[1]) {
            int _amount = 0;
            try{
              _amount = int.parse(_element[1]);
            }catch(e){
              _amount = 0;
              debugPrint('The amount on KwikPoints is empty.');
            }
            _bidChildrenTMP.add(BidItem(
              bidName: _element[0],
              kwikPointsAmount: _amount,
              // bid  date: _element[2],
              color: globals.white2,
            ));
          }

          _bidChildrenTMP.sort(
                  (BidItem a, BidItem b) => b.kwikPointsAmount - a.kwikPointsAmount);
          _bidChildrenTMP[0].color = globals.gold;

          setState((){
            _bidChildren = _bidChildrenTMP;
          });
        }
        return true;
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
    debugPrint('load bid end!!!');
    debugPrint(
        '=========<<======================================================<<==================================================<<=========');

    return false;
  }

  void _filterByProjects(List<ProjectSquare> childrenProjectList) {
    for (var _element in childrenProjectList) {
      _element.isSelected == true
          ? filters.projectSelectedSet.add(_element.projectName)
          : filters.projectSelectedSet.remove(_element.projectName);
    }
    _filterTasks();
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
