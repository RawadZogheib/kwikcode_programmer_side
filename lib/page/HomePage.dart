import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/MiddleView.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/MyFilter.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/RightView.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/projectSquare.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/BidPopup.dart';
import 'package:kwikcode_programmer_side/widgets/other/Flutter%20Logo.dart';
import 'package:kwikcode_programmer_side/widgets/other/myDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation? _animation;
  AnimationController? _animationController;

  List<ProjectSquare> _childrenProjectList = [];
  List<TaskSquare> _childrenTaskList = [];

  bool _isLoadingTasks = true;
  bool _isClickedRefresh = true;

  //Color iconColor = globals.logoColorPink;
  //Color iconColor = globals.logoColorBlue;
  Color iconColor = globals.white1;

  final double _iconSize = 35;

  //BidPopup
  bool _animationIsActive = false;
  TaskSquare _childTaIsActive = TaskSquare(
    key: const ValueKey('null'),
    taskName: 'null',
    projectManager: '@null',
    description: 'null',
    timeLeft: 0,
    iconList: [],
    status: 0,
    removeTask: (ValueKey<String> taskId) => debugPrint('null'),
    onBidTap: (ValueKey<String> taskId) => debugPrint('null'),
  );

  @override
  void initState() {
    // TODO: implement initState
    globals.currentPage = 'HomePage';
    _loadAnimation();
    _loadTasks();
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
                  Transform(
                    transform: Matrix4.translationValues(
                        0.0, _animation?.value * _height, 0.0),
                    child: BidPopup(
                      childTaIsActive: _childTaIsActive,
                      onBackTap: () => _endAnimation(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
          key: const ValueKey('1'),
          taskName: 'Task Name 1',
          projectManager: '@Samir',
          description: 'adsadsad asd  asd as d asd',
          timeLeft: 1000,
          iconList: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: MyFlutterLogo(
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.node,
                // IconData(
                //   int.parse(icon5),
                //   fontFamily: 'NewIcons',
                //   fontPackage: null,
                // ),
                size: _iconSize,
                color: iconColor,
              ),
            ),
          ],
          status: 0,
          removeTask: (ValueKey<String> taskId) => _removeTask(taskId),
          onBidTap: (ValueKey<String> taskId) => _startAnimation(taskId),
        ),
        TaskSquare(
          key: const ValueKey('2'),
          taskName: 'Task Name 2',
          projectManager: '@Samira',
          description: 'adsadsad asd  asd as d asd',
          timeLeft: 100,
          iconList: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: MyFlutterLogo(
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.php,
                size: _iconSize,
                color: iconColor,
              ),
            ),
          ],
          status: 1,
          removeTask: (ValueKey<String> taskId) => _removeTask(taskId),
          onBidTap: (ValueKey<String> taskId) => _startAnimation(taskId),
        ),
        TaskSquare(
          key: const ValueKey('3'),
          taskName: 'Task Name 3',
          projectManager: '@Samira',
          description: 'adsadsad asd  asd as d asd',
          timeLeft: 10000,
          iconList: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.html5,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.css3_alt,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.js,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.php,
                size: _iconSize,
                color: iconColor,
              ),
            ),
          ],
          status: 2,
          removeTask: (ValueKey<String> taskId) => _removeTask(taskId),
          onBidTap: (ValueKey<String> taskId) => _startAnimation(taskId),
        ),
        TaskSquare(
          key: const ValueKey('4'),
          taskName: 'Task Name 4',
          projectManager: '@Samir',
          description: 'adsadsad asd  asd as d asd',
          timeLeft: 5600,
          iconList: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: MyFlutterLogo(
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.php,
                size: _iconSize,
                color: iconColor,
              ),
            ),
          ],
          status: 3,
          removeTask: (ValueKey<String> taskId) => _removeTask(taskId),
          onBidTap: (ValueKey<String> taskId) => _startAnimation(taskId),
        ),
        TaskSquare(
          key: const ValueKey('5'),
          taskName: 'Task Name 5',
          projectManager: '@Samir',
          description: 'adsadsad asd  asd as d asd',
          timeLeft: 3,
          iconList: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: MyFlutterLogo(
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.php,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.js,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.react,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.css3,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.css3_alt,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.html5,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.swift,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.java,
                size: _iconSize,
                color: iconColor,
              ),
            ),
          ],
          status: 4,
          removeTask: (ValueKey<String> taskId) => _removeTask(taskId),
          onBidTap: (ValueKey<String> taskId) => _startAnimation(taskId),
        ),
        TaskSquare(
          key: const ValueKey('6'),
          taskName: 'Task Name 6',
          projectManager: '@Samir',
          description:
              'adsadsad asd   askdjsa jk hjajk jjkoj jkoasj kodjqwskoa jasko jkaskojk kjas okjasko jasko jkoas jokj askoj dkosajko sda okjas jkojas jojas jokasj ko jaskodjkoasj koas dokjas kljasdko j koxj jo ij j ojas jojsad joj iou j  joasjjo joj asj jo sa ioj as j jos as das bnhjsagh  hjnn jhjjis jj j jijo j jojio joij  oijoi jojjjko jk as g hhhji hjih jihjjd io 7uyc enqwmne  cyu8 hhjvbcsdf y678sdyfc7897sx8 7hjkz yy  uiy iou hji hjckj m,nhj h78as asd fd casdf s  f  d cvv v gvcb x gxc   oj kojko jiok  jokj  jdjoj jo jas jojdo u djuo s duioa  ioj oiasd as d asd',
          timeLeft: 86400,
          iconList: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.html5,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.css3_alt,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.js,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.php,
                size: _iconSize,
                color: iconColor,
              ),
            ),
          ],
          status: 5,
          removeTask: (ValueKey<String> taskId) => _removeTask(taskId),
          onBidTap: (ValueKey<String> taskId) => _startAnimation(taskId),
        ),
        TaskSquare(
          key: const ValueKey('7'),
          taskName: 'Task Name 7',
          projectManager: '@Andrea',
          description:
              'adsadsad asd  a fhg f fglk  fghjkljh gsjfh d j  zd f  dsj kjsdhhjk d fh  hjasd h  hjk  hjsdjkl h sdjhkl fhj jksdl jf jksdhj  jk jjk hj jk dfh hjsd f kj hjdsf jklh klfdsjkl j jklxcj jkgsdjgfjikl sdfjkl  sj kj gjk jfjkl  jfjkl jdjk  g j djkl  jjksdfg jfjzdkj  jkdfg jjk jjk  jefsdjkf jjkcv  jjfjk jiojgkj jko j jdf jdfgjk gjket j jkod f jkfsjk  dfjgf jkfdj j ji jk  rj   xh fd   ui fjk j  g iuofgzdu  uio jfjk sd  jkf d   k j jks j sfjkl j jkfjgjk d fjgjkl dfjjk bjsdkj b njdfl jkfj qweopr ewio uriosed  cjn sd as d asd',
          timeLeft: 43000,
          iconList: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: MyFlutterLogo(
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.php,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.js,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.react,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.css3,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.css3_alt,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.html5,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.swift,
                size: _iconSize,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                NewIcons.java,
                size: _iconSize,
                color: iconColor,
              ),
            ),
          ],
          status: -1,
          removeTask: (ValueKey<String> taskId) => _removeTask(taskId),
          onBidTap: (ValueKey<String> taskId) => _startAnimation(taskId),
        ),
      ];
      _isLoadingTasks = false;
      _isClickedRefresh = false;
    });
    // if (_isClickedRefresh == false) {
    //   try {
    //     debugPrint(
    //         '=========>>======================================================>>==================================================>>=========');
    //     setState(() {
    //       _isLoadingTasks = true;
    //       _isClickedRefresh = true;
    //     });
    //     debugPrint('load Crypto');
    //
    //     //globals.myCurrencies = crypto.getStringList('myCurrencies')!;
    //     var res =
    //         await CallApi().getDataAPI('https://kwikcode.net/kwikcodePhp/...');
    //     //print(res.body);
    //     List<dynamic> body = json.decode(res.body);
    //
    //     setState(() {
    //       _isLoadingTasks = false;
    //       _isClickedRefresh = false;
    //     });
    //   } catch (e) {
    //     debugPrint(e.toString());
    //     setState(() {
    //       _isLoadingTasks = true;
    //       _isClickedRefresh = false;
    //     });
    //     errorPopup(context, globals.errorException);
    //   }
    //   debugPrint('load crypto end!!!');
    //   debugPrint(
    //       '=========<<======================================================<<==================================================<<=========');
    // }
  }

  _removeTask(ValueKey<String> taskId) {
    if (mounted) {
      setState(() {
        _childrenTaskList.removeAt(
            _childrenTaskList.indexWhere((element) => element.key == taskId));
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

  _startAnimation(ValueKey<String> taskId) {
    if (_animationIsActive == false) {
      _childTaIsActive = _childrenTaskList[
          _childrenTaskList.indexWhere((element) => element.key == taskId)];
      _animationIsActive = true;
      _animationController!.forward();
    }
  }

  _endAnimation() async {
    if (_animationIsActive == true) {
      _animationIsActive = false;
      _animationController!
          .reverse()
          .then((value) => _childTaIsActive = TaskSquare(
                key: const ValueKey('null'),
                taskName: 'null',
                projectManager: '@null',
                description: 'null',
                timeLeft: 0,
                iconList: [],
                status: 0,
                removeTask: (ValueKey<String> taskId) => debugPrint('null'),
                onBidTap: (ValueKey<String> taskId) => debugPrint('null'),
              ));
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
