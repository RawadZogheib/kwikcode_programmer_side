import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/projectSquare.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';

class RightView extends StatefulWidget {
  List<ProjectSquare> childrenProjectList;
  bool isLoadingProjects;

  RightView({
    Key? key,
    required this.childrenProjectList,
    required this.isLoadingProjects,
  }) : super(key: key);

  @override
  State<RightView> createState() => _RightViewState();
}

class _RightViewState extends State<RightView> {
  @override
  Widget build(BuildContext context) {
    // double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: globals.darkBlue2,
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                // Icon(
                //   Icons.person,
                //   color: globals.whiteBlue,
                // ),
                InkWell(
                  onTap: () => _openDrawerRank(),
                  child: Image.asset(
                    'Assets/Rank/KwikCodeLogoPlatinum.png',
                    height: 54,
                    width: 54,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  'Rawad',
                  style: TextStyle(
                      fontSize: 18,
                      color: globals.white2,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 35),
                Expanded(
                  child: InkWell(
                    onTap: () => Scaffold.of(context).openEndDrawer(),
                    child: Icon(
                      Icons.menu,
                      color: globals.whiteBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 440,//475,
            width: 300,
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              //color: Colors.transparent, //globals.darkBlue2,
              color: globals.darkBlue2,
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 26,
                      color: globals.whiteBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                widget.isLoadingProjects == false
                    ? Expanded(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            //padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                            decoration: const BoxDecoration(
                              //border: Border.all(color: globals.logoColorBlue).scale(2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: ScrollConfiguration(
                              behavior: MyCustomScrollBehavior()
                                  .copyWith(scrollbars: false),
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: widget.childrenProjectList,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          height: 42.0,
                          width: 42.0,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: globals.logoColorPink,
                          ),
                        ),
                      ),
                //const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _openDrawerRank() {
    globals.drawerIsRank = true;
    Scaffold.of(context).openEndDrawer();
  }
}
