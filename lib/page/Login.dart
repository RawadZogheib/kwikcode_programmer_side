
import 'dart:convert';
import 'dart:io';
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
import 'package:dart_ipify/dart_ipify.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String? _userNameLogin;
  String? _passwordLogin;

  Color _colUserName = globals.blue; //email
  Color _colUserName_1 = globals.blue_1;
  Color _colUserName_2 = globals.blue_2;

  Color _colPass = globals.blue; //password
  Color _colPass_1 = globals.blue_1;
  Color _colPass_2 = globals.blue_2;

  String _errTxtUsername = ''; //email error
  Color _colErrTxtUsername = globals.transparent;
  String _errTxtPass = ''; //password error
  Color _colErrTxtPass = globals.transparent;
  String _errTxt = ''; //else error
  Color _colErrTxt = globals.transparent;

  var _oneClick = 0;

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
    return WillPopScope(
      onWillPop: () async => _back(),
      child: Scaffold(
        backgroundColor: globals.whiteBlue,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Center(
              child: Container(
                width: 500,
                height: 670,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 5,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/HomePage', (route) => false);
                        },
                      ),
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 40.0, color: Colors.black),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                top: 18.0,
                                right: MediaQuery.of(context).size.width * 0.05,
                                bottom: 8.0),
                            child: SizedBox(
                              width: 400,
                              height: 55,
                              child: MyTextInput(
                                  textString: "Enter Your UserName",
                                  labelText: 'Enter Your UserName',
                                  colBlue: _colUserName,
                                  colBlue_1: _colUserName_1,
                                  colBlue_2: _colUserName_2,
                                  textInputAction: TextInputAction.next,
                                  spaceAllowed: false,
                                  obscure: false,
                                  onChange: (value) {
                                    _userNameLogin = value;
                                  }),
                            )),
                        myErrorText(
                            errorText: _errTxtUsername, color: _colErrTxtUsername),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              top: 8.0,
                              right: MediaQuery.of(context).size.width * 0.05,
                              bottom: 8.0),
                          child: SizedBox(
                            width: 500,
                            height: 50,
                            child: MyTextInput(
                              textString: "Enter Your Password",
                              labelText: 'Enter Your Password',
                              colBlue: _colPass,
                              colBlue_1: _colPass_1,
                              colBlue_2: _colPass_2,
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
                          padding: const EdgeInsets.all(28.0),
                          child: InkWell(
                            child: btn(btnText: "Submit"),
                            onTap: () {
                              try {
                                if (_oneClick == 0) {
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginCtrl() async {
    _oneClick = 1;
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
          _colUserName = Colors.blue.shade50;
          _colUserName_1 = Colors.blue.shade900;
          _colUserName_2 = Colors.blue.shade900.withOpacity(0.5);
        });
      }
    } else {
      isEmpty = true;
      if (mounted) {
        setState(() {
          _colUserName = Colors.red.shade50;
          _colUserName_1 = Colors.red.shade900;
          _colUserName_2 = Colors.red.shade900.withOpacity(0.5);
          _errTxtUsername = globals.warning7;
          _colErrTxtUsername = globals.red_1;
          warningPopup(context, globals.warning7);
        });
      }
    }

    if (_passwordLogin != null && _passwordLogin != '') {
      if (mounted) {
        setState(() {
          _colPass = Colors.blue.shade50;
          _colPass_1 = Colors.blue.shade900;
          _colPass_2 = Colors.blue.shade900.withOpacity(0.5);
        });
      }
    } else {
      isEmpty = true;
      if (mounted) {
        setState(() {
          _colPass = Colors.red.shade50;
          _colPass_1 = Colors.red.shade900;
          _colPass_2 = Colors.red.shade900.withOpacity(0.5);
          _errTxtPass = globals.warning7;
          _colErrTxtPass = globals.red_1;
          warningPopup(context, globals.warning7);
        });
      }
    }

    if (isEmpty == false) {
      await _verifc();
    } else {
      //do nothing
    }
    _oneClick = 0;
  }

  _verifc() async {
    _errTxt = '';

    final ipv4 = await Ipify.ipv4();
    print(ipv4); // 98.207.254.136
    print(globals.version);
    print(_userNameLogin);
    print(_passwordLogin);

    try {
      var data = {
        'version': globals.version,
        'userName': _userNameLogin,
        'password': _passwordLogin,
        'ip' : await ipv4,
      };

      var res =
          await CallApi().postData(data, '/Login/Control/(Control)Login.php');
      debugPrint(res.body);
      List<dynamic> body = json.decode(res.body);

      if (body[0] == "success") {

          SessionManager session = SessionManager();
          await session.set('token', body[1]);
          await session.set('Id', body[2][0]);
          await session.set('fName', body[2][1]);
          await session.set('lName', body[2][2]);
          await session.set('email', body[2][3]);
          await session.set('userName', _userNameLogin);
          await session.set('phoneNumber', body[2][4]);
          await session.set('gender', body[2][5]);
          await session.set('dateOfBirth', body[2][6]);
          await session.set('ip', ipv4);
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
        _colUserName_2 = Colors.red.shade900.withOpacity(0.5);
        _colPass = Colors.red.shade50;
        _colPass_1 = Colors.red.shade900;
        _colPass_2 = Colors.red.shade900.withOpacity(0.5);
        if (mounted) {
          setState(() {
            _errTxt = globals.warning8;
            _colErrTxt = globals.red_1;
            warningPopup(context, globals.warning8);
          });
        }
      } else if(body[0] == "error4"){
        warningPopup(context, globals.error4);
      }else {
        if (mounted) {
          setState(() {
            _errTxt = globals.errorElse;
            _colErrTxt = globals.red_1;
            errorPopup(context, globals.errorElse);
          });
        }
      }
    } catch (e) {
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

  _clearLogin(){
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
        _colUserName = globals.blue; //email
        _colUserName_1 = globals.blue_1;
        _colUserName_2 = globals.blue_2;
        _colPass = globals.blue; //password
        _colPass_1 = globals.blue_1;
        _colPass_2 = globals.blue_2;
      });
    }
  }

}
