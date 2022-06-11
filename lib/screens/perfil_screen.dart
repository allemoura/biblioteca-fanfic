import 'package:biblioteca_de_fanfic/tabs/perfil_tab.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meu Perfil"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: PerfilTab());
  }
}
