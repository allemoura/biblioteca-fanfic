import 'package:biblioteca_de_fanfic/models/user_model.dart';
import 'package:biblioteca_de_fanfic/screens/home/home_page.dart';
import 'package:biblioteca_de_fanfic/screens/reset_screen.dart';
import 'package:biblioteca_de_fanfic/utils/button_style_custtom.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PerfilTab extends StatefulWidget {
  @override
  _PerfilTabState createState() => _PerfilTabState();
}

class _PerfilTabState extends State<PerfilTab> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _nameController.text = UserModel.of(context).userData!.name!;
    _emailController.text = UserModel.of(context).userData!.email!;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Nome",
              ),
              validator: (text) {
                if (text!.isEmpty) return "Nome inválido!";
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Seu E-mail",
              ),
              validator: (text) {
                if (text!.isEmpty) return "E-mail inválido!";
              },
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: ElevatedButton(
                child: Text(
                  "Alterar Cadastro",
                  style: TextStyle(fontSize: 18.0),
                ),
                style: ButtonStyleCustom().call(
                  Colors.white,
                  Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_emailController.text !=
                        UserModel.of(context).userData!.email) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResetScreen(
                              _emailController.text, _nameController.text)));
                    } else {
                      if (_nameController.text !=
                          UserModel.of(context).userData!.name!) {
                        if (_nameController.text !=
                            UserModel.of(context).userData!.name!) {
                          UserModel.of(context)
                              .userData
                              ?.setName(_nameController.text);
                        }

                        UserModel.of(context).updateUserLocal();
                        Future.delayed(
                          Duration(seconds: 1),
                          () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                        );
                        showColoredToast('Seu perfil foi atualizado!');
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showColoredToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
    );
  }

  void onSuccess() {
    showDialog(
        context: context,
        builder: (context) {
          Widget okButton = TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ok',
                style: TextStyle(color: Colors.white),
              ));

          AlertDialog alert = AlertDialog(
            content: Text(
              'Usuário atualizado com sucesso!!',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              okButton,
            ],
          );

          return alert;
        });
  }

  void onFail() {
    showDialog(
        context: context,
        builder: (context) {
          Widget okButton = TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ok',
                style: TextStyle(color: Colors.white),
              ));

          AlertDialog alert = AlertDialog(
            content: Text(
              'Falha ao atualizar usuário, tente novamente!!',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              okButton,
            ],
          );
          return alert;
        });
  }
}
