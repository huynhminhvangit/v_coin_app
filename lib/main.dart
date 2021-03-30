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
  final _formKey = GlobalKey<FormState>();

  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  if (value.length < 5) {
                    return 'Username must be 6 characters or more';
                  }
                  return null;
                },
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
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  Pattern pattern =
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';

                  RegExp regExp = new RegExp(pattern);
                  if (!regExp.hasMatch(value)) {
                    return 'Password must be 8 characters or more, including numbers, uppercase, lowercase letters, and special characters';
                  }
                  return null;
                },
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
                      borderSide: BorderSide(color: Colors.blue)),
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
                onPressed: _showWelcomeScreen,
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xffff5f6d),
                        Color(0xffff5f6d),
                        Color(0xffffc371),
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
    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
    // Navigator.of(context).pushNamed('/welcome');
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
