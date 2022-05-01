import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/RefreshViewButton.dart';
import 'package:kwikcode_programmer_side/widgets/HomePage/widgetViewButton.dart';

class MyFilter extends StatelessWidget {
  bool isClickedRefresh;
  var loadTasks;

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
                        color: globals.white2,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                WidgetViewButton(
                  text: 'OverView',
                  icon: Icons.view_cozy,
                  colorIcon: globals.white1,
                  colorText: globals.white1,
                  onTap: () => debugPrint('OverView'),
                ),
                const SizedBox(height: 10),
                WidgetViewButton(
                  text: 'Spot',
                  icon: Icons.currency_exchange,
                  colorIcon: globals.white1,
                  colorText: globals.white1,
                  onTap: () => debugPrint('Spot'),
                ),
                const SizedBox(height: 10),
                WidgetViewButton(
                  text: 'Future',
                  icon: Icons.currency_franc,
                  colorIcon: globals.white1,
                  colorText: globals.white1,
                  onTap: () => debugPrint('Future'),
                ),
                const SizedBox(height: 10),
                const Expanded(child: SizedBox()),
                // WidgetViewButton(
                //     text: 'Refresh',
                //     icon: Icons.refresh,
                //     onTap: () => _loadTasks()),
                // const SizedBox(height: 30),
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
                colorIcon: Colors.green.shade700,
                colorText: Colors.green.shade700,
                isClickedRefresh: isClickedRefresh,
                onTap: () => loadTasks()),
          ),
        ),
      ],
    );
  }
}
