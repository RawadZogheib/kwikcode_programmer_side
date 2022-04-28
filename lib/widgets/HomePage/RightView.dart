import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/projectSquare.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';

class RightView extends StatelessWidget {
  List<ProjectSquare> childrenProjectList;

  RightView({Key? key, required this.childrenProjectList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SizedBox(
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
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: globals.darkBlue2,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
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
                      child: InkWell(
                        onTap: () => Scaffold.of(context).openEndDrawer(),
                        child: Icon(
                          Icons.menu,
                          color: globals.white1,
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
                    Expanded(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
