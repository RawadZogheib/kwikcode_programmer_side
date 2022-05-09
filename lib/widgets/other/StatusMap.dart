import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/HomePage/taskSquare.dart';
import 'package:kwikcode_programmer_side/widgets/other/Flutter%20Logo.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class StatusMap extends StatelessWidget {
  const StatusMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _value = 2;

    const double _value1 = 0.4;
    const double _value2 = 0.8;
    const double _value3 = 0.6;
    const double _value4 = 0.9;
    const double _value5 = 0.3;
    const double _value6 = 0.7;

    Color iconColor = globals.white1;
    const double _iconSize = 35;

    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Text(
              'Task status Path',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: globals.white2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: 2,
                    valueColor: const AlwaysStoppedAnimation(Colors.red),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.red,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                    center: Icon(
                      NewIcons.circle,
                      size: 18.0,
                      color: Colors.transparent.withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: 2,
                    valueColor: const AlwaysStoppedAnimation(Colors.orange),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.orange,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                    center: Icon(
                      NewIcons.circle,
                      size: 18.0,
                      color: Colors.transparent.withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: 0.28,
                    valueColor: const AlwaysStoppedAnimation(Colors.blue),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.blue,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                    center: const Icon(
                      NewIcons.circle,
                      size: 18.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: -1,
                    valueColor: const AlwaysStoppedAnimation(Colors.orange),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.orange,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                    center: const Icon(
                      Icons.warning,
                      size: 18.0,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: -1,
                    valueColor: const AlwaysStoppedAnimation(Colors.green),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.green,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                    center: const Icon(
                      NewIcons.circle,
                      size: 18.0,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: -1,
                    valueColor: const AlwaysStoppedAnimation(Colors.red),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.red,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                    center: const Icon(
                      Icons.warning,
                      size: 18.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            ///
            TaskSquare(
              taskName: 'Any Task',
              projectManager: 'Unknown',
              description:
                  'Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description Some description ',
              timeLeft: 6000,
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
              status: 0,
              animate: true,
              disableToolTip: true,
              removeTask: () => debugPrint('test1'),
              onBidTap: () => debugPrint('test1'),
            ),
            const SizedBox(height: 40),

            /// red
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: _value1,
                    valueColor: const AlwaysStoppedAnimation(Colors.red),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.red,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                  ),
                ),
                const SizedBox(width: 5),
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(
                    NewIcons.circle,
                    size: 18.0,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Red Circle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: globals.white2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'In project management, a task is an activity that needs to be accomplished within a defined period of time or by a deadline to work towards work-related goals. It is a small essential piece of a job that serves as a means to differentiate various components of a project. A task can be broken down into assignments which should also have a defined start and end date or a deadline for completion. One or more assignments on a task puts the task under execution. Completion of all assignments on a specific task normally renders the task completed. Tasks can be linked together to create dependencies.Tasks completion generally requires the coordination of others. Coordinated human interaction takes on the role of combining the integration of time, energy, effort, ability, and resources of multiple individuals to meet a common goal. Coordination can also be thought of as the critical mechanism that links or ties together the efforts on the singular level to that of the larger task being completed by multiple members. Coordination allows for the successful completion of the otherwise larger tasks that one might encounter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: globals.white1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// orangeCircle
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: _value2,
                    valueColor: const AlwaysStoppedAnimation(Colors.orange),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.orange,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                  ),
                ),
                const SizedBox(width: 5),
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(
                    NewIcons.circle,
                    size: 18.0,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Orange Circle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: globals.white2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'In project management, a task is an activity that needs to be accomplished within a defined period of time or by a deadline to work towards work-related goals. It is a small essential piece of a job that serves as a means to differentiate various components of a project. A task can be broken down into assignments which should also have a defined start and end date or a deadline for completion. One or more assignments on a task puts the task under execution. Completion of all assignments on a specific task normally renders the task completed. Tasks can be linked together to create dependencies.Tasks completion generally requires the coordination of others. Coordinated human interaction takes on the role of combining the integration of time, energy, effort, ability, and resources of multiple individuals to meet a common goal. Coordination can also be thought of as the critical mechanism that links or ties together the efforts on the singular level to that of the larger task being completed by multiple members. Coordination allows for the successful completion of the otherwise larger tasks that one might encounter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: globals.white1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// blue
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: _value3,
                    valueColor: const AlwaysStoppedAnimation(Colors.blue),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.blue,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                  ),
                ),
                const SizedBox(width: 5),
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(
                    NewIcons.circle,
                    size: 18.0,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Blue Circle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: globals.white2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'In project management, a task is an activity that needs to be accomplished within a defined period of time or by a deadline to work towards work-related goals. It is a small essential piece of a job that serves as a means to differentiate various components of a project. A task can be broken down into assignments which should also have a defined start and end date or a deadline for completion. One or more assignments on a task puts the task under execution. Completion of all assignments on a specific task normally renders the task completed. Tasks can be linked together to create dependencies.Tasks completion generally requires the coordination of others. Coordinated human interaction takes on the role of combining the integration of time, energy, effort, ability, and resources of multiple individuals to meet a common goal. Coordination can also be thought of as the critical mechanism that links or ties together the efforts on the singular level to that of the larger task being completed by multiple members. Coordination allows for the successful completion of the otherwise larger tasks that one might encounter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: globals.white1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// orangeWarning
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: _value4,
                    valueColor: const AlwaysStoppedAnimation(Colors.orange),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.orange,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                  ),
                ),
                const SizedBox(width: 5),
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(
                    Icons.warning,
                    size: 18.0,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Orange Warning',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: globals.white2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'In project management, a task is an activity that needs to be accomplished within a defined period of time or by a deadline to work towards work-related goals. It is a small essential piece of a job that serves as a means to differentiate various components of a project. A task can be broken down into assignments which should also have a defined start and end date or a deadline for completion. One or more assignments on a task puts the task under execution. Completion of all assignments on a specific task normally renders the task completed. Tasks can be linked together to create dependencies.Tasks completion generally requires the coordination of others. Coordinated human interaction takes on the role of combining the integration of time, energy, effort, ability, and resources of multiple individuals to meet a common goal. Coordination can also be thought of as the critical mechanism that links or ties together the efforts on the singular level to that of the larger task being completed by multiple members. Coordination allows for the successful completion of the otherwise larger tasks that one might encounter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: globals.white1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// greenCircle
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: _value5,
                    valueColor: const AlwaysStoppedAnimation(Colors.green),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.green,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                  ),
                ),
                const SizedBox(width: 5),
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(
                    NewIcons.circle,
                    size: 18.0,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Green Circle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: globals.white2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'In project management, a task is an activity that needs to be accomplished within a defined period of time or by a deadline to work towards work-related goals. It is a small essential piece of a job that serves as a means to differentiate various components of a project. A task can be broken down into assignments which should also have a defined start and end date or a deadline for completion. One or more assignments on a task puts the task under execution. Completion of all assignments on a specific task normally renders the task completed. Tasks can be linked together to create dependencies.Tasks completion generally requires the coordination of others. Coordinated human interaction takes on the role of combining the integration of time, energy, effort, ability, and resources of multiple individuals to meet a common goal. Coordination can also be thought of as the critical mechanism that links or ties together the efforts on the singular level to that of the larger task being completed by multiple members. Coordination allows for the successful completion of the otherwise larger tasks that one might encounter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: globals.white1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// redWarning
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 100,
                  child: LiquidLinearProgressIndicator(
                    value: _value6,
                    valueColor: const AlwaysStoppedAnimation(Colors.red),
                    backgroundColor: globals.whiteBlue,
                    borderColor: Colors.red,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis.horizontal,
                  ),
                ),
                const SizedBox(width: 5),
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(
                    Icons.warning,
                    size: 18.0,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Red Warning',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: globals.white2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'In project management, a task is an activity that needs to be accomplished within a defined period of time or by a deadline to work towards work-related goals. It is a small essential piece of a job that serves as a means to differentiate various components of a project. A task can be broken down into assignments which should also have a defined start and end date or a deadline for completion. One or more assignments on a task puts the task under execution. Completion of all assignments on a specific task normally renders the task completed. Tasks can be linked together to create dependencies.Tasks completion generally requires the coordination of others. Coordinated human interaction takes on the role of combining the integration of time, energy, effort, ability, and resources of multiple individuals to meet a common goal. Coordination can also be thought of as the critical mechanism that links or ties together the efforts on the singular level to that of the larger task being completed by multiple members. Coordination allows for the successful completion of the otherwise larger tasks that one might encounter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: globals.white1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
