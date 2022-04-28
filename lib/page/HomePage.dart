import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/api/my_api.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/MiddleView.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/MyFilter.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/RightView.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/projectSquare.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/errorWarningPopup.dart';
import 'package:kwikcode_programmer_side/widgets/other/myDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProjectSquare> _childrenProjectList = [];
  List<TaskSquare> _childrenTaskList = [];

  bool _isLoadingTasks = true;
  bool _isClickedRefresh = true;

  @override
  void initState() {
    // TODO: implement initState
    globals.currentPage = 'HomePage';
    _loadTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => _back(),
      child: Scaffold(
        endDrawer: const MyDrawer(),
        backgroundColor: globals.darkBlue1,
        body: Column(
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
                      style: TextStyle(fontSize: 14, color: globals.white2),
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
                      loadTasks: () => _loadTasks()),
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
      ),
    );
  }

  _loadTasks() async {
    setState(() {
      _isLoadingTasks = true;
      _isClickedRefresh = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _childrenProjectList = [
        ProjectSquare(
          name: 'All',
          imgUrl: 'https://picsum.photos/100/100/?all',
          onTap: () => debugPrint('All'),
        ),
        ProjectSquare(
          name: 'Project 1',
          imgUrl: 'https://picsum.photos/100/100/?1',
          onTap: () => debugPrint('Project 1'),
        ),
        ProjectSquare(
          name: 'Project 2',
          imgUrl: 'https://picsum.photos/100/100/?2',
          onTap: () => debugPrint('Project 2'),
        ),
        ProjectSquare(
          name: 'Project 3',
          imgUrl: 'https://picsum.photos/100/100/?3',
          onTap: () => debugPrint('Project 3'),
        ),
      ];
      _childrenTaskList = [
        TaskSquare(
          taskName: 'Task Name 1',
          projectManager: '@Samir',
          description: 'adsadsad asd  asd as d asd',
          imgUrl: 'https://picsum.photos/100/100/?1',
        ),
        TaskSquare(
          taskName: 'Task Name 2',
          projectManager: '@Samir',
          description: 'adsadsad asd  asd as d asd',
          imgUrl: 'https://picsum.photos/100/100/?2',
        ),
        TaskSquare(
          taskName: 'Task Name 3',
          projectManager: '@Samir',
          description: 'adsadsad asd  asd as d asd',
          imgUrl: 'https://picsum.photos/100/100/?3',
        ),
        TaskSquare(
          taskName: 'Task Name 4',
          projectManager: '@Samir',
          description: 'adsadsad asd  asd as d asd',
          imgUrl: 'https://picsum.photos/100/100/?4',
        ),
        TaskSquare(
          taskName: 'Task Name 4',
          projectManager: '@Samir',
          description: 'adsadsad asd  asd as d asd',
          imgUrl: 'https://picsum.photos/100/100/?4',
        ),
        TaskSquare(
          taskName: 'Task Name 5',
          projectManager: '@Samir',
          description: 'adsadsad asd  asd as d asd',
          imgUrl: 'https://picsum.photos/100/100/?5',
        ),
      ];
      _isLoadingTasks = false;
      _isClickedRefresh = false;
    });
    return;
    if (_isClickedRefresh == false) {
      try {
        debugPrint(
            '=========>>======================================================>>==================================================>>=========');
        setState(() {
          _isLoadingTasks = true;
          _isClickedRefresh = true;
        });
        debugPrint('load Crypto');

        //globals.myCurrencies = crypto.getStringList('myCurrencies')!;
        var res =
            await CallApi().getDataAPI('https://kwikcode.net/kwikcodePhp/...');
        //print(res.body);
        List<dynamic> body = json.decode(res.body);

        setState(() {
          _isLoadingTasks = false;
          _isClickedRefresh = false;
        });
      } catch (e) {
        debugPrint(e.toString());
        setState(() {
          _isLoadingTasks = true;
          _isClickedRefresh = false;
        });
        errorPopup(context, globals.errorException);
      }
      debugPrint('load crypto end!!!');
      debugPrint(
          '=========<<======================================================<<==================================================<<=========');
    }
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
