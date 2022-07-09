import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;

class ProjectSquare extends StatefulWidget {
  String projectName;
  String? imgUrl;
  bool isSelected;
  Function onTap;
  Function filterByProjects;

  ProjectSquare({
    Key? key,
    required this.projectName,
    required this.imgUrl,
    this.isSelected = true,
    required this.onTap,
    required this.filterByProjects,
  }) : super(key: key);

  @override
  State<ProjectSquare> createState() => _ProjectSquareState();
}

class _ProjectSquareState extends State<ProjectSquare> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => _onTap(),
      child: Container(
        height: 93,
        width: 170,
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: globals.darkBlue2,
          border: widget.isSelected == true
              ? Border.all(color: globals.logoColorBlue).scale(4.0)
              : Border.all(color: globals.logoColorBlue).scale(2.0),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(22.0)),
                child: widget.imgUrl != null
                    ? Image.network(
                        widget.imgUrl!,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        'Assets/Other/KwikCodeLogo.png',
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              widget.projectName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }

  _onTap() {
    setState(() {
      widget.isSelected = !widget.isSelected;
    });
    widget.filterByProjects();
    // debugPrint(filters.projectSelectedSet.toString());
    // errorPopup(context,'Filter By Project is not available yet.');
    // widget.filterTasks(
    //     _sortStatus, _redRadio, _orangeRadio, _notLanguagesNameList);
  }
}
