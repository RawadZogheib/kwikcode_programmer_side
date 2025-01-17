import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/api/my_session.dart';
import 'package:http/http.dart' as http;
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;


class CallApi{
  final String _url = globals.myIP;

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken() ;
    debugPrint(fullUrl);
    return await http.post(   //post request
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }
  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    debugPrint(fullUrl);
    return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }

  getDataAPI(apiUrl) async {
    return await http.get(
        Uri.parse(apiUrl),
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',

  };

  _getToken() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token');
    // return '?token=$token';
    var token = await SessionManager().get('token');
    return '?token=$token';
  }


  getArticles(apiUrl) async {

  }
  getPublicData(apiUrl) async {

  }

}