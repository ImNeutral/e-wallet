import 'package:e_wallet/providers/auth_provider.dart';
import 'package:e_wallet/validators/user_validator.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  UserValidator userValidator = UserValidator();
  final _formKey = GlobalKey<FormState>();
  bool isRegistration = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isRegistration) ...[
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                    if (isRegistration) ...[
                      Text(
                        'Registration',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          return userValidator.name(value);
                        },
                      )
                    ],
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                      validator: (value) {
                        return userValidator.email(value);
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        return userValidator.password(value, isRegistration);
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (!isRegistration) ...[
                      RaisedButton(
                        onPressed: () => login(context),
                        child: Text('Login'),
                      ),
                      FlatButton(
                        onPressed: () => {
                          setState(() {
                            isRegistration = true;
                          })
                        },
                        child: Text('Don\'t have an account? Sign Up now!'),
                        textTheme: ButtonTextTheme.primary,
                      )
                    ],
                    if (isRegistration) ...[
                      RaisedButton(
                        onPressed: () => register(context),
                        child: Text('Register'),
                      ),
                      FlatButton(
                        onPressed: () => {
                          setState(() {
                            isRegistration = false;
                          })
                        },
                        child: Text('Already have an account? Log in!'),
                        textTheme: ButtonTextTheme.primary,
                      )
                    ]
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void register(BuildContext context) {
    if (_formKey.currentState.validate()) {
      AuthProvider().register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        context,
      );
    }
  }

  void login(BuildContext context) {
    if (_formKey.currentState.validate()) {
      AuthProvider()
          .login(_emailController.text, _passwordController.text, context);
    }
  }
}
