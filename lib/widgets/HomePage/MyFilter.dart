import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/RefreshViewButton.dart';

class MyFilter extends StatelessWidget {
  bool isClickedRefresh;
  Function loadTasks;

  MyFilter({
    Key? key,
    required this.isClickedRefresh,
    required this.loadTasks,
  }) : super(key: key);

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
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    'Filters',
                    style: TextStyle(
                        fontSize: 22,
                        color: globals.whiteBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),

                const SizedBox(height: 10),
                const Expanded(child: SizedBox()),
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
                text: 'Refresh',
                icon: NewIcons.sync_alt,
                colorIcon: globals.logoColorPink,
                colorText: globals.logoColorPink,
                isClickedRefresh: isClickedRefresh,
                onTap: () => loadTasks()),
          ),
        ),
      ],
    );
  }
}
