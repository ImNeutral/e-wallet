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
  bool isLoading = false;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
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
                        controller: _firstNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'First Name'),
                        validator: (value) {
                          return userValidator.firstName(value);
                        },
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Last Name'),
                        validator: (value) {
                          return userValidator.lastName(value);
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
                        }),
                    if (isRegistration) ...[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          return userValidator.confirmPassword(
                              value, _passwordController.text);
                        },
                      ),
                    ],
                    SizedBox(
                      height: 12,
                    ),
                    if (!isLoading && !isRegistration) ...[
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
                    if (!isLoading && isRegistration) ...[
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
                    ],
                    if (isLoading) ...[CircularProgressIndicator()]
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void register(BuildContext context) {
    if (_formKey.currentState.validate()) {
      setIsLoading(true);
      AuthProvider()
          .register(
            _firstNameController.text,
            _lastNameController.text,
            _emailController.text,
            _passwordController.text,
            context,
          )
          .whenComplete(() => setIsLoading(false));
    }
  }

  void login(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setIsLoading(true);
      AuthProvider()
          .login(_emailController.text, _passwordController.text, context)
          .whenComplete(() => setIsLoading(false));
    }
  }

  void setIsLoading(bool _isLoading) {
    if (mounted) {
      setState(() {
        isLoading = _isLoading;
      });
    }
  }
}
