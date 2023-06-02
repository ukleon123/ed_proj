import 'dart:convert';
import 'package:crypton/crypton.dart';
import 'package:ed_proj/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logger = Logger();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.asset("asset/logo/login_logo.png"), loginForm()],
    );
  }

  Container loginForm() {
    TextEditingController idController = TextEditingController();
    TextEditingController pwController = TextEditingController();

    return Container(
        width: MediaQuery.of(context).size.width / 1.8,
        height: MediaQuery.of(context).size.height / 4,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                field('ID', idController),
                const SizedBox(
                  height: 10,
                ),
                field('PW', pwController),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () async {
                      String id = idController.text;
                      String pw = pwController.text;
                      Map<String, dynamic> result = await login(id, pw);

                      if (result != null) {
                        await FirebaseAuth.instance.signInAnonymously();
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => MainPage(userId: result['userId'], userData: result)));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                  child: Container(
                                      width: 300,
                                      height: 100,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                        Text("개인번호 혹은 비밀번호를 확인해주세요"),
                                            TextButton(onPressed: () {
                                              Navigator.pop(context);
                                            }, child: Text("확인"))
                                      ])
                                  )
                              );
                            });
                      }
                    },
                    child: const Text("로그인",
                        style: TextStyle(
                            color: Color(0xff77212c),
                            fontSize: (17),
                            fontWeight: FontWeight.w600)))
              ],
            )));
  }

  Widget field(String fieldName, TextEditingController controller) {
    bool type;
    if (fieldName == 'ID') {
      type = false;
    } else {
      type = true;
    }
    return TextFormField(
        controller: controller,
        obscureText: type,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          fillColor: Colors.grey,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(90)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2.0),
              borderRadius: BorderRadius.circular(90)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          hintText: fieldName,
        ));
  }

  Future? login(String id, String pw) async {
    Session session = Session();
    session.headers['host'] = "klas.kw.ac.kr";
    session.headers['X-Requested-With'] = "XMLHttpRequest";
    session.headers['Content-Type'] = "application/json";
    Map<dynamic, dynamic> response = await session.post(
        "https://klas.kw.ac.kr/usr/cmn/login/LoginSecurity.do", null);

    String pubKey = response['publicKey'];
    RSAPublicKey key = RSAPublicKey.fromString(pubKey);
    Map<String, dynamic> data = {
      "loginToken":
          key.encrypt("{\"loginId\": \"$id\", \"loginPwd\": \"$pw\"}"),
      "redirectUrl": "",
      "redirectTabUrl": ""
    };
    var result = await session.post(
        "https://klas.kw.ac.kr/usr/cmn/login/LoginConfirm.do", data);
    logger.w(result);
    String userId = result['response']['userId'].substring(0, 10);
    if (result['response'] != null) {
      result = await session.post(
          "https://klas.kw.ac.kr/std/cmn/frame/StdHome.do",
          {"searchYearhakgi": null});
    } else {
      return null;
    }
    result['userId'] = userId;
    return result;
  }
}

class Session {
  final logger = Logger();

  final JsonDecoder _decoder = const JsonDecoder();
  final JsonEncoder _encoder = const JsonEncoder();

  Map<String, String> headers = {};
  Map<String, String> cookies = {};

  void _updateCookie(http.Response response) {
    String? allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }
      headers['cookie'] = _generateCookieHeader();
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.isNotEmpty) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;

        cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.isNotEmpty) {
        cookie += ";";
      }
      cookie += "$key=${cookies[key]!}";
    }

    return cookie;
  }

  Future<dynamic> get(String url) {
    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, body) {
    return http
        .post(Uri.parse(url), body: _encoder.convert(body), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}
