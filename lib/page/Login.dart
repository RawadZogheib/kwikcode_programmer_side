import 'dart:convert';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/api/my_api.dart';
import 'package:kwikcode_programmer_side/api/my_session.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:kwikcode_programmer_side/widgets/PopUp/errorAlertDialog.dart';
import 'package:kwikcode_programmer_side/widgets/PopUp/errorWarningPopup.dart';
import 'package:kwikcode_programmer_side/widgets/button/myButton.dart';

// import 'package:kwikcode_programmer_side/widgets/code/codeDialogLogin.dart';
// import 'package:kwikcode_programmer_side/widgets/other/errorAlertDialog.dart';
import 'package:kwikcode_programmer_side/widgets/textInput/myErrorText.dart';
import 'package:kwikcode_programmer_side/widgets/textInput/myTextInput.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _userNameLogin;
  String? _passwordLogin;

  Color _colUserName = globals.white; //email
  Color _colUserName_1 = globals.logoColorPink;

  Color _colPass = globals.white; //password
  Color _colPass_1 = globals.logoColorPink;

  String _errTxtUsername = ''; //email error
  Color _colErrTxtUsername = globals.transparent;
  String _errTxtPass = ''; //password error
  Color _colErrTxtPass = globals.transparent;
  String _errTxt = ''; //else error
  Color _colErrTxt = globals.transparent;

  bool _isClicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_oneClick = 0;
    globals.currentPage = "Login";
    _clearLogin();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => _back(),
      child: Scaffold(
        backgroundColor: globals.darkBlue1,
        body: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  const SizedBox(width: 5.0),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset(
                      'Assets/Other/KwikCodeLogo.png',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'KwikCode',
                      style: TextStyle(fontSize: 14, color: globals.white2),
                    ),
                  ),
                  Expanded(child: MoveWindow()),
                  const WindowButtons()
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: 600,
                  width: 480,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: globals.darkBlue2,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'Assets/Other/KwikCodeLogo.png',
                        height: 215,
                        width: 215,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 40.0, color: globals.whiteBlue),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0,
                              bottom: 8.0),
                          child: SizedBox(
                            width: 400,
                            height: 55,
                            child: MyTextInput(
                                textString: "Enter Your UserName",
                                labelText: 'Enter Your UserName',
                                colBlue: _colUserName,
                                colBlue_1: _colUserName_1,
                                textInputAction: TextInputAction.next,
                                spaceAllowed: false,
                                obscure: false,
                                onChange: (value) {
                                  _userNameLogin = value;
                                }),
                          )),
                      myErrorText(
                          errorText: _errTxtUsername,
                          color: _colErrTxtUsername),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0),
                        child: SizedBox(
                          width: 400,
                          height: 55,
                          child: MyTextInput(
                            textString: "Enter Your Password",
                            labelText: 'Enter Your Password',
                            colBlue: _colPass,
                            colBlue_1: _colPass_1,
                            maxLines: 1,
                            textInputAction: TextInputAction.none,
                            spaceAllowed: false,
                            obscure: true,
                            onChange: (value) {
                              _passwordLogin = value;
                              //print(globals.Login);
                            },
                          ),
                        ),
                      ),
                      myErrorText(
                          errorText: _errTxtPass, color: _colErrTxtPass),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: btn(btnText: "Submit"),
                          onTap: () {
                            try {
                              if (_isClicked == false) {
                                _loginCtrl();
                              }
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ErrorAlertDialog(
                                          message: globals.errorException));
                            }
                          },
                        ),
                      ),
                      myErrorText(errorText: _errTxt, color: _colErrTxt),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  _loginCtrl() async {
    _isClicked = true;
    bool isEmpty = false;

    _errTxtUsername = '';
    _colErrTxtUsername = globals.transparent;
    _errTxtPass = '';
    _colErrTxtPass = globals.transparent;
    _errTxt = '';
    _colErrTxt = globals.transparent;

    if (_userNameLogin != null && _userNameLogin != '') {
      if (mounted) {
        setState(() {
          _colUserName = globals.white;
          _colUserName_1 = globals.logoColorPink;
        });
      }
    } else {
      isEmpty = true;
      if (mounted) {
        setState(() {
          _colUserName = Colors.red.shade50;
          _colUserName_1 = Colors.red.shade900;
          _errTxtUsername = globals.warning7;
          _colErrTxtUsername = globals.red_1;
          warningPopup(context, globals.warning7);
        });
      }
    }

    if (_passwordLogin != null && _passwordLogin != '') {
      if (mounted) {
        setState(() {
          _colPass = globals.white;
          _colPass_1 = globals.logoColorPink;
        });
      }
    } else {
      isEmpty = true;
      if (mounted) {
        setState(() {
          _colPass = Colors.red.shade50;
          _colPass_1 = Colors.red.shade900;
          _errTxtPass = globals.warning7;
          _colErrTxtPass = globals.red_1;
          warningPopup(context, globals.warning7);
        });
      }
    }

    if (isEmpty == false) {
      await _verifc();
    }
    _isClicked = false;
  }

  _verifc() async {
    _errTxt = '';

    final ipv4 = 'await Ipify.ipv4()';
    debugPrint(ipv4); // 98.207.254.136
    debugPrint(globals.version);
    debugPrint(_userNameLogin);
    debugPrint(_passwordLogin);

    try {
      var data = {
        'version': globals.version,
        'userName': _userNameLogin,
        'password': _passwordLogin,
        'ip': ipv4,
      };

      var res =
          await CallApi().postData(data, '/Login/Control/(Control)Login.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == "success") {
        await SessionManager().set('token', body[1]);
        await SessionManager().set('Id', body[2][0]);
        await SessionManager().set('fName', body[2][1]);
        await SessionManager().set('lName', body[2][2]);
        await SessionManager().set('email', body[2][3]);
        await SessionManager().set('userName', _userNameLogin);
        await SessionManager().set('phoneNumber', body[2][4]);
        await SessionManager().set('gender', body[2][5]);
        await SessionManager().set('dateOfBirth', body[2][6]);
        await SessionManager().set('ip', ipv4);
        await SessionManager().set('myKwikPoints',1420);
        await SessionManager().set('isLoggedIn', true);
        //print(await session.get('isLoggedIn'));
        Navigator.pushNamedAndRemoveUntil(
            context, '/HomePage', (route) => false);
      } else if (body[0] == "errorVersion") {
        if (mounted) {
          setState(() {
            _errTxt = "Your version: " +
                globals.version +
                "\n" +
                globals.errorVersion;
            _colErrTxt = globals.red_1;
            errorPopup(context, globals.errorVersion);
          });
        }
      } else if (body[0] == "error8") {
        _colUserName = Colors.red.shade50;
        _colUserName_1 = Colors.red.shade900;
        _colPass = Colors.red.shade50;
        _colPass_1 = Colors.red.shade900;
        if (mounted) {
          setState(() {
            _errTxt = globals.warning8;
            _colErrTxt = globals.red_1;
            warningPopup(context, globals.warning8);
          });
        }
      } else if (body[0] == "error4") {
        setState(() {
          _errTxt = globals.error4;
          _colErrTxt = globals.red_1;
        });
        warningPopup(context, globals.error4);
      } else if (body[0] == "error13") {
        setState(() {
          _errTxt = globals.error13;
          _colErrTxt = globals.red_1;
        });
        errorPopup(context, globals.error13);
      } else {
        if (mounted) {
          setState(() {
            _errTxt = globals.errorElse;
            _colErrTxt = globals.red_1;
            errorPopup(context, globals.errorElse);
          });
        }
      }
    } catch (e) {
      _isClicked = false;
      debugPrint(e.toString());
      if (mounted) {
        setState(() {
          _errTxt = globals.errorException;
          _colErrTxt = globals.red_1;
          errorPopup(context, globals.errorException);
        });
      }
    }
  }

  _back() {
    exit(0);
  }

  _clearLogin() {
    _userNameLogin = null;
    _passwordLogin = null;
  }

  _nullLogin() {
    if (mounted) {
      setState(() {
        _clearLogin();

        _errTxtUsername = '';
        _errTxtPass = '';
        _errTxt = '';
        _colUserName = globals.white; //email
        _colUserName_1 = globals.logoColorPink;
        _colPass = globals.white; //password
        _colPass_1 = globals.logoColorPink;
      });
    }
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: globals.white1,
    mouseOver: globals.white2,
    mouseDown: globals.white2,
    iconMouseOver: globals.white1,
    iconMouseDown: globals.white1);

final closeButtonColors = WindowButtonColors(
    iconNormal: Colors.red,
    mouseOver: Colors.red,
    mouseDown: Colors.red,
    iconMouseOver: globals.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(
          colors: closeButtonColors,
          onPressed: () => _onClose(),
        ),
      ],
    );
  }

  _onClose() {
    debugPrint('bye');
    appWindow.close();
  }
}
