import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/NewIcons.dart';
import 'package:kwikcode_programmer_side/api/my_session.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/PopUp/errorWarningPopup.dart';
import 'package:kwikcode_programmer_side/widgets/other/MyCustomScrollBehavior.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    _loadIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: globals.darkBlue1, //HexColor('#222222'), //globals.blue1,
        child: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: ListView(
            controller: ScrollController(),
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'Assets/Other/KwikCodeLogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        // const SizedBox(height: 22),
                        const SearchFieldDrawer(),
                        const SizedBox(height: 12),
                        MenuItem(
                          text: 'My Tasks',
                          icon: NewIcons.tasks,
                          color: globals.whiteBlue,
                          onClicked: () => selectedItem(context, 0),
                        ),
                        const SizedBox(height: 5),
                        MenuItem(
                          text: 'My Bids',
                          icon: Icons.timer_outlined,
                          color: globals.whiteBlue,
                          onClicked: () => selectedItem(context, 1),
                        ),
                        const SizedBox(height: 5),
                        MenuItem(
                          text: 'My Wallet',
                          icon: NewIcons.wallet,
                          color: globals.whiteBlue,
                          onClicked: () => selectedItem(context, 2),
                        ),
                        const SizedBox(height: 5),
                        MenuItem(
                          text: 'News',
                          icon: NewIcons.newspaper,
                          color: globals.whiteBlue,
                          onClicked: () => selectedItem(context, 3),
                        ),
                        const SizedBox(height: 5),
                        MenuItem(
                          text: 'Updates',
                          icon: Icons.update,
                          color: globals.whiteBlue,
                          onClicked: () => selectedItem(context, 4),
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: Colors.white70),
                        const SizedBox(height: 8),
                        MenuItem(
                          text: 'Notifications',
                          icon: Icons.notifications_outlined,
                          color: globals.white1,
                          onClicked: () => selectedItem(context, 5),
                        ),
                        MenuItem(
                          text: 'Settings',
                          icon: Icons.settings,
                          color: globals.white1,
                          onClicked: () => selectedItem(context, 6),
                        ),
                        const SizedBox(height: 8),
                        MenuItem(
                          text: 'Logout',
                          icon: Icons.logout,
                          color: globals.red1,
                          onClicked: () => selectedItem(context, 7),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    //Navigator.of(context).pop();
    switch (index) {
      case 0: // My Tasks

        warningPopup(context, 'Coming Soon!!');
        break;
      case 1: // My Bids

        warningPopup(context, 'Coming Soon!!');
        break;
      case 2: // My Wallet

        warningPopup(context, 'Coming Soon!!');
        break;
      case 3: // News

        warningPopup(context, 'Coming Soon!!');
        break;
      case 4: // Updates

        warningPopup(context, 'Coming Soon!!');
        break;
      case 5: // Notifications

        warningPopup(context, 'Coming Soon!!');
        break;
      case 6: // Settings

        warningPopup(context, 'Coming Soon!!');
        break;

      case 7: // Logout
        SessionManager session = SessionManager();
        await session.destroy();

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/LoginPage', (route) => false);

        break;
    }
  }

  Future<void> _loadIsLoggedIn() async {
    SessionManager session = SessionManager();
    if (await session.containsKey('isLoggedIn')) {
      _isLoggedIn = await session.get('isLoggedIn');
      setState(() {
        _isLoggedIn;
      });
    } else {
      setState(() {
        _isLoggedIn = false;
      });
    }
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback? onClicked;

  const MenuItem({
    required this.text,
    required this.icon,
    required this.color,
    this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Color color = globals.whiteBlue;//Colors.white;
    Color hoverColor = Colors.transparent.withOpacity(1); //Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

class SearchFieldDrawer extends StatelessWidget {
  const SearchFieldDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = globals.whiteBlue;

    return TextField(
      style: TextStyle(color: color, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(
          Icons.search,
          color: color,
          size: 20,
        ),
        filled: true,
        fillColor: globals.darkBlue1,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }
}
