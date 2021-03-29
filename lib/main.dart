import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => LoginScreen(),
      '/welcome': (context) => WelcomeScreen()
    });
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  double _formProgress = 0;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'vCoin',
            style: Theme.of(context).textTheme.headline4,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _userNameTextController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle:
                      TextStyle(fontSize: 18, color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(children: <Widget>[
              TextFormField(
                controller: _passwordTextController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle:
                      TextStyle(fontSize: 18, color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red)),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: _toggle,
                  ),
                ),
                obscureText: _obscureText,
              ),
            ]),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: _formProgress == 1 ? _showWelcomeScreen : null,
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        _formProgress == 1
                            ? Color(0xffff5f6d)
                            : Colors.grey.shade400,
                        _formProgress == 1
                            ? Color(0xffff5f6d)
                            : Colors.grey.shade400,
                        _formProgress == 1
                            ? Color(0xffffc371)
                            : Colors.grey.shade400,
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                        maxWidth: double.infinity, minHeight: 50),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }

  void _updateFormProgress() {
    var progress = 0.0;
    var controlers = [_userNameTextController, _passwordTextController];

    for (var controller in controlers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controlers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellowAccent,
        title: Text(
          'vCoin',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: null),
          IconButton(icon: Icon(Icons.logout), onPressed: null)
        ],
      ),
      body: Center(
        child: Text(
          'Welcome!',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
