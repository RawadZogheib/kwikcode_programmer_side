import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/RefreshViewButton.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';
import 'package:kwikcode_programmer_side/widgets/other/programmingItem.dart';

class MyFilter extends StatefulWidget {
  bool isClickedRefresh;
  Function(String, bool, bool, List<String>) filterTasks;
  Function() loadTasks;

  MyFilter({
    Key? key,
    required this.isClickedRefresh,
    required this.filterTasks,
    required this.loadTasks,
  }) : super(key: key);

  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {
  String _sortStatus = 'alphaDown'; // alphaDown alphaUp numDown numUp
  bool _redRadio = true;
  bool _orangeRadio = true;
  final List<String> _notLanguagesNameList = [];

  List<ProgrammingItem> _languagesIconsList = [];

  @override
  void initState() {
    // TODO: implement initState
    _loadIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
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
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 26,
                      color: globals.whiteBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 199,
                  width: 250,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    border: Border.all(color: globals.logoColorBlue).scale(2),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Sort By:',
                        style: TextStyle(
                          fontSize: 22,
                          color: globals.white2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _sortStatus = 'alphaDown';
                          _sortUp();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 68.0),
                            Icon(
                              NewIcons.sort_alpha_down,
                              color: _sortStatus=='alphaDown'?globals.logoColorPink:globals.white1,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 18,
                                color: _sortStatus=='alphaDown'?globals.logoColorPink:globals.white1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _sortStatus = 'alphaUp';
                          _sortUp();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 68.0),
                            Icon(
                              NewIcons.sort_alpha_up,
                              color: _sortStatus=='alphaUp'?globals.logoColorPink:globals.white1,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 18,
                                color: _sortStatus=='alphaUp'?globals.logoColorPink:globals.white1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _sortStatus = 'numDown';
                          _sortUp();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 52.0),
                            Icon(
                              NewIcons.sort_numeric_down,
                              color: _sortStatus=='numDown'?globals.logoColorPink:globals.white1,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Time Left',
                              style: TextStyle(
                                fontSize: 18,
                                color: _sortStatus=='numDown'?globals.logoColorPink:globals.white1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _sortStatus = 'numUp';
                          _sortUp();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 52.0),
                            Icon(
                              NewIcons.sort_numeric_up,
                              color: _sortStatus=='numUp'?globals.logoColorPink:globals.white1,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Time Left',
                              style: TextStyle(
                                fontSize: 18,
                                color: _sortStatus=='numUp'?globals.logoColorPink:globals.white1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                Container(
                  height: 92,
                  width: 250,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    border: Border.all(color: globals.logoColorBlue).scale(2),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Task Status:',
                          style: TextStyle(
                            fontSize: 22,
                            color: globals.white2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 25,
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                _redRadio = !_redRadio;
                                _sortUp();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _redRadio == true
                                      ? Colors.red
                                      : Colors.red.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                  // border: _redRadio == true
                                  //     ? Border.all(color: globals.white2).scale(3)
                                  //     : null,
                                ),
                                child: const SizedBox(
                                  height: 20.0,
                                  width: 20.0,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _orangeRadio = !_orangeRadio;
                                _sortUp();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _orangeRadio == true
                                      ? Colors.orange
                                      : Colors.orange.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                  // border: _orangeRadio == true
                                  //     ? Border.all(color: globals.white2).scale(3)
                                  //     : null,
                                ),
                                child: const SizedBox(
                                  height: 20.0,
                                  width: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 190,
                    width: 250,
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      border: Border.all(color: globals.logoColorBlue).scale(2),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Languages:',
                            style: TextStyle(
                              fontSize: 22,
                              color: globals.white2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22.0),
                            child: ScrollConfiguration(
                              behavior: MyCustomScrollBehavior(),
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: _languagesIconsList,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 60,
          width: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: globals.darkBlue2,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: SizedBox(
            width: 169,
            child: RefreshViewButton(
                text: 'Sync',
                icon: NewIcons.sync_alt,
                colorIcon: globals.logoColorPink,
                colorText: globals.logoColorPink,
                isClickedRefresh: widget.isClickedRefresh,
                onTap: () async {
                  await widget.loadTasks();
                  _sortUp();
                }),
          ),
        ),
      ],
    );
  }

  _sortUp() {
    _notLanguagesNameList.clear();

    for (ProgrammingItem element in _languagesIconsList) {
      if (element.isSelected == false) {
        _notLanguagesNameList.add(element.name);
      }
    }
    widget.filterTasks(
        _sortStatus, _redRadio, _orangeRadio, _notLanguagesNameList);
  }

  void _loadIcons() {
    setState(() {
      _languagesIconsList = [
        ProgrammingItem(
          name: 'Flutter',
          icon: 'Flutter',
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'PHP',
          icon: NewIcons.php,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'React Native',
          icon: NewIcons.react,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'HTML',
          icon: NewIcons.html5,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'CSS',
          icon: NewIcons.css3_alt,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'Java Script',
          icon: NewIcons.js,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'Swift',
          icon: NewIcons.swift,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'Java',
          icon: NewIcons.java,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'Python',
          icon: NewIcons.python,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'Node JS',
          icon: NewIcons.node,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'Unity',
          icon: NewIcons.unity,
          onTap: () => _sortUp(),
        ),
        ProgrammingItem(
          name: 'Other',
          icon: Icons.more_horiz,
          onTap: () => _sortUp(),
        ),
      ];
    });
  }
}
