import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/projectSquare.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';

class RightView extends StatelessWidget {
  List<ProjectSquare> childrenProjectList;
  bool isLoadingProjects;

  RightView({
    Key? key,
    required this.childrenProjectList,
    required this.isLoadingProjects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
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
                Image.asset(
                  'Assets/Rank/KwikCodeLogoPlatinum.png',
                  height: 54,
                  width: 54,
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
            height: _height * .8,
            width: 300,
            decoration: const BoxDecoration(
              color: Colors.transparent, //globals.darkBlue2,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 25),
                isLoadingProjects == false
                    ? Expanded(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
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
                                  children: childrenProjectList,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
