import 'package:biblioteca_de_fanfic/data/user_data.dart';
import 'package:biblioteca_de_fanfic/models/user_model.dart';
import 'package:biblioteca_de_fanfic/screens/home/home_page.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

class ResetScreen extends StatefulWidget {
  final String novoEmail;
  final String novoNome;

  ResetScreen(
    this.novoEmail,
    this.novoNome,
  );

  @override
  _ResetScreenState createState() => _ResetScreenState(
        novoEmail,
        novoNome,
      );
}

class _ResetScreenState extends State<ResetScreen> {
  final String novoEmail;
  final String novoNome;

  _ResetScreenState(
    this.novoEmail,
    this.novoNome,
  );

  final _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool logado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoding) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Form(
                  key: _formKey,
                  child: ListView(
                      padding: EdgeInsets.all(16.0),
                      children: <Widget>[
                        TextFormField(
                          controller: _senhaController,
                          decoration: InputDecoration(
                            hintText: "Senha",
                          ),
                          obscureText: true,
                          validator: (text) {
                            if (text!.isEmpty || text.length < 8)
                              return "Senha inválida!";
                          },
                        ),
                        SizedBox(height: 16.0),
                        SizedBox(
                          height: 44.0,
                          child: RaisedButton(
                            child: Text(
                              "Confirmar",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                model.signIn(
                                  email: model.userData!.email!,
                                  pass: _senhaController.text,
                                  onFail: _onFail,
                                  onSuccess: _onSuccess,
                                );
                              }
                            },
                          ),
                        ),
                      ]));
            }
          },
        ));
  }

  void _onSuccessModificado() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _onSuccess() {
    UserData? userData = UserModel.of(context).userData;

    userData?.setEmail(novoEmail);
    userData?.setName(novoNome);

    UserModel.of(context).updateEmail(novoEmail);
    UserModel.of(context).updateUser(
        userData: userData!,
        onSuccess: _onSuccessModificado,
        onFail: _onFailModificado);
  }

  void _onFail() {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("Sua senha esta errada, tente novamente!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  void _onFailModificado() {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("Ops, algo deu errdo, tente novamente!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
