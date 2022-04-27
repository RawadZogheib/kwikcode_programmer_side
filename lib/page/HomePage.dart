import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:kwikcode_programmer_side/api/my_api.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/PopUp/errorWarningPopup.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';
import 'package:kwikcode_programmer_side/widgets/other/projectSquare.dart';
import 'package:kwikcode_programmer_side/widgets/other/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/other/widgetViewButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoadingTasks = true;
  bool _clickedRefresh = true;
  final InfiniteScrollController _infiniteController =
      InfiniteScrollController(initialScrollOffset: 0.0);
  int _i = 0;

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
        //endDrawer: const MyDrawer(),
        backgroundColor: globals.darkBlue1,
        body: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'MyWallet',
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
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: globals.darkBlue2,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Center(
                          child: Text(
                            'Filters',
                            style: TextStyle(
                                fontSize: 22,
                                color: globals.white2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 40),
                        WidgetViewButton(
                          text: 'OverView',
                          icon: Icons.view_cozy,
                          onTap: () => debugPrint('OverView'),
                        ),
                        const SizedBox(height: 10),
                        WidgetViewButton(
                          text: 'Spot',
                          icon: Icons.currency_exchange,
                          onTap: () => debugPrint('Spot'),
                        ),
                        const SizedBox(height: 10),
                        WidgetViewButton(
                          text: 'Future',
                          icon: Icons.currency_franc,
                          onTap: () => debugPrint('Future'),
                        ),
                        const SizedBox(height: 10),
                        const Expanded(child: SizedBox()),
                        WidgetViewButton(
                            text: 'Refresh',
                            icon: Icons.refresh,
                            onTap: () => _loadTasks()),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'Projects',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: globals.white2,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                const SizedBox(height: 25),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ProjectSquare(
                                            name: 'All',
                                            imgUrl:
                                                'https://picsum.photos/100/100/?all',
                                            onTap: () => debugPrint('All'),
                                          ),
                                          ProjectSquare(
                                            name: 'Project 1',
                                            imgUrl:
                                                'https://picsum.photos/100/100/?1',
                                            onTap: () =>
                                                debugPrint('Project 1'),
                                          ),
                                          ProjectSquare(
                                            name: 'Project 2',
                                            imgUrl:
                                                'https://picsum.photos/100/100/?2',
                                            onTap: () =>
                                                debugPrint('Project 2'),
                                          ),
                                          ProjectSquare(
                                            name: 'Project 3',
                                            imgUrl:
                                                'https://picsum.photos/100/100/?3',
                                            onTap: () =>
                                                debugPrint('Project 3'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            _isLoadingTasks == false
                                ? Expanded(
                                    child: ScrollConfiguration(
                                      behavior: MyCustomScrollBehavior(),
                                      child: SingleChildScrollView(
                                        controller: ScrollController(),
                                        child: Wrap(
                                          alignment: WrapAlignment.start,
                                          children: [
                                            TaskSquare(
                                              taskName: 'Task Name 1',
                                              projectManager: '@Samir',
                                              description:
                                                  'adsadsad asd  asd as d asd',
                                              imgUrl:
                                                  'https://picsum.photos/100/100/?1',
                                            ),
                                            TaskSquare(
                                              taskName: 'Task Name 2',
                                              projectManager: '@Samir',
                                              description:
                                                  'adsadsad asd  asd as d asd',
                                              imgUrl:
                                                  'https://picsum.photos/100/100/?2',
                                            ),
                                            TaskSquare(
                                              taskName: 'Task Name 3',
                                              projectManager: '@Samir',
                                              description:
                                                  'adsadsad asd  asd as d asd',
                                              imgUrl:
                                                  'https://picsum.photos/100/100/?3',
                                            ),
                                            TaskSquare(
                                              taskName: 'Task Name 4',
                                              projectManager: '@Samir',
                                              description:
                                                  'adsadsad asd  asd as d asd',
                                              imgUrl:
                                                  'https://picsum.photos/100/100/?4',
                                            ),
                                            TaskSquare(
                                              taskName: 'Task Name 4',
                                              projectManager: '@Samir',
                                              description:
                                                  'adsadsad asd  asd as d asd',
                                              imgUrl:
                                                  'https://picsum.photos/100/100/?4',
                                            ),
                                            TaskSquare(
                                              taskName: 'Task Name 5',
                                              projectManager: '@Samir',
                                              description:
                                                  'adsadsad asd  asd as d asd',
                                              imgUrl:
                                                  'https://picsum.photos/100/100/?5',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: 20),
                          ],
                        )),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 300,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 300,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: globals.darkBlue2,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 40),
                                  Icon(
                                    Icons.person,
                                    color: globals.white1,
                                  ),
                                  const SizedBox(width: 25),
                                  Text(
                                    'Rawad',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: globals.white1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: globals.white1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: _height * .8,
                                width: 300,
                                margin: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: globals.darkBlue2,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                ),
                                child: Container()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _updatePaletteGenerator() async {
  //   for (int i = 0; i < globals.myCurrencies.length; i++) {
  //     // debugPrint(globals.allCurrencies[globals.allCurrenciesSymbol
  //     //     .indexOf(globals.myCurrencies[i])]['image']);
  //     final paletteGenerator = await PaletteGenerator.fromImageProvider(
  //         NetworkImage(globals.allCurrencies[globals.allCurrenciesSymbol
  //             .indexOf(globals.myCurrencies[i])]['image']),
  //         size: const Size(200, 100));
  //     // debugPrint(paletteGenerator.dominantColor.toString());
  //     globals.paletteColor
  //         .add(paletteGenerator.dominantColor ?? PaletteColor(Colors.grey, 2));
  //   }
  // }

  _loadTasks() async {
    setState(() {
      _isLoadingTasks = false;
      _clickedRefresh = false;
    });
    return;
    if (_clickedRefresh == false) {
      try {
        debugPrint(
            '=========>>======================================================>>==================================================>>=========');
        setState(() {
          _isLoadingTasks = true;
          _clickedRefresh = true;
        });
        debugPrint('load Crypto');

        //globals.myCurrencies = crypto.getStringList('myCurrencies')!;
        var res =
            await CallApi().getDataAPI('https://kwikcode.net/kwikcodePhp/...');
        //print(res.body);
        List<dynamic> body = json.decode(res.body);

        setState(() {
          _isLoadingTasks = false;
          _clickedRefresh = false;
        });
      } catch (e) {
        debugPrint(e.toString());
        setState(() {
          _isLoadingTasks = true;
          _clickedRefresh = false;
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
