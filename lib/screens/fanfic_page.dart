import 'package:biblioteca_de_fanfic/data/Fanfic.dart';
import 'package:biblioteca_de_fanfic/models/user_model.dart';
import 'package:biblioteca_de_fanfic/screens/home/home_page.dart';
import 'package:biblioteca_de_fanfic/widgets/custom_dialog.dart';

import 'package:flutter/material.dart';

class FanficPage extends StatefulWidget {
  final FanficData? fanfic;

  FanficPage({required this.fanfic});

  @override
  _FanficPageState createState() => _FanficPageState();
}

class _FanficPageState extends State<FanficPage> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _linkController = TextEditingController();

  final _tituloFocus = FocusNode();

  String? _imageController;
  bool _userEdited = false;
  bool haveImage = false;
  bool iniciado = false;
  @override
  void initState() {
    super.initState();

    if (widget.fanfic != null) {
      iniciado = true;

      _tituloController.text = widget.fanfic!.titulo!;
      _descricaoController.text = widget.fanfic!.descricao!;
      _linkController.text = widget.fanfic!.link!;
      if (widget.fanfic!.imagem != '') {
        _imageController = widget.fanfic!.imagem;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              (iniciado ? widget.fanfic!.titulo : "Nova Fanfic")!,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () async {
              if (_tituloController.text != null &&
                  _tituloController.text.isNotEmpty) {
                Map<String, dynamic> data = {
                  "titulo": _tituloController.text,
                  "descricao": _descricaoController.text,
                  "link": _linkController.text,
                  "concluido": iniciado ? widget.fanfic!.concluido : false,
                  "imagem": _imageController ?? "",
                };

                if (iniciado) {
                  UserModel.of(context).updateFanfic(
                    widget.fanfic!.id,
                    data,
                  );
                } else {
                  UserModel.of(context).createFanfic(data);
                }

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              } else {
                FocusScope.of(context).requestFocus(_tituloFocus);
              }
            },
            child: Icon(Icons.save),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 300.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: haveImage
                              ? NetworkImage(_imageController!)
                              : widget.fanfic?.imagem != null
                                  ? NetworkImage(widget.fanfic!.imagem!)
                                  : AssetImage("images/book.png")
                                      as ImageProvider,
                          fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            label: 'Digite a url da capa...',
                            onChanged: (String value) {
                              setState(() {
                                _imageController = value;
                              });
                            },
                            onPressed: () {
                              setState(() {
                                haveImage = _imageController != null;
                              });

                              Navigator.pop(context);
                            },
                            textButton: 'SALVAR',
                          );
                        });
                  },
                ),
                TextField(
                  controller: _tituloController,
                  focusNode: _tituloFocus,
                  decoration: InputDecoration(labelText: "Titulo"),
                ),
                TextField(
                  maxLines: 8,
                  controller: _descricaoController,
                  decoration: InputDecoration(labelText: "Descricao"),
                  keyboardType: TextInputType.multiline,
                ),
                TextField(
                  controller: _linkController,
                  decoration: InputDecoration(labelText: "Link"),
                  keyboardType: TextInputType.url,
                ),
              ]))),
      onWillPop: _requestPop,
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
