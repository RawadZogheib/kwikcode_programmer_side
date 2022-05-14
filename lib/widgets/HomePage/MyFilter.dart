import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/RefreshViewButton.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';

class MyFilter extends StatefulWidget {
  bool isClickedRefresh;
  Function(String, bool, bool) filterTasks;
  Function(String, bool, bool) loadTasks;

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
                const SizedBox(height: 30),
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
                const SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    _sortStatus = 'alphaDown';
                    _sortUp();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 50.0),
                      Icon(
                        NewIcons.sort_alpha_down,
                        color: globals.white2,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 20,
                          color: globals.white2,
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
                      const SizedBox(width: 50.0),
                      Icon(
                        NewIcons.sort_alpha_up,
                        color: globals.white2,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 20,
                          color: globals.white2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _sortStatus = 'numDown';
                    _sortUp();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 50.0),
                      Icon(
                        NewIcons.sort_numeric_down,
                        color: globals.white2,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Time Left',
                        style: TextStyle(
                          fontSize: 20,
                          color: globals.white2,
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
                      const SizedBox(width: 50.0),
                      Icon(
                        NewIcons.sort_numeric_up,
                        color: globals.white2,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Time Left',
                        style: TextStyle(
                          fontSize: 20,
                          color: globals.white2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Task Status:',
                    style: TextStyle(
                      fontSize: 20,
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
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: _redRadio == true
                                ? Border.all(color: globals.white2).scale(3)
                                : null,
                          ),
                          child: const SizedBox(
                            height: 18.0,
                            width: 18.0,
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
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            border: _orangeRadio == true
                                ? Border.all(color: globals.white2).scale(3)
                                : null,
                          ),
                          child: const SizedBox(
                            height: 18.0,
                            width: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Languages:',
                    style: TextStyle(
                      fontSize: 20,
                      color: globals.white2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22.0),
                    child: Container(
                      height: 190,
                      width: 250,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.0),
                        border: Border.all(color: globals.white2).scale(1),
                      ),
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior(),
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 8,
                              children: globals.languagesIconsList,
                            ),
                          ),
                        ),
                      ),
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
                onTap: () => widget.loadTasks(_sortStatus, _redRadio, _orangeRadio)),
          ),
        ),
      ],
    );
  }

  _sortUp() {
    widget.filterTasks(_sortStatus, _redRadio, _orangeRadio);
  }
}
