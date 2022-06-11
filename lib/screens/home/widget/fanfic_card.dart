import 'package:biblioteca_de_fanfic/data/Fanfic.dart';
import 'package:biblioteca_de_fanfic/models/user_model.dart';
import 'package:biblioteca_de_fanfic/screens/home/home_page_store.dart';
import 'package:biblioteca_de_fanfic/screens/home/widget/options_bottom.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FanficCard extends StatelessWidget {
  final FanficData fanficData;
  final UserModel model;
  final HomePageStore store;
  final Function() onClosing;

  final Function({
    FanficData? fanfic,
  }) showFanficPage;

  const FanficCard({
    Key? key,
    required this.fanficData,
    required this.model,
    required this.store,
    required this.showFanficPage,
    required this.onClosing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Card(
            color: store.corCard(fanficData.concluido!),
            margin: EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: 300.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: fanficData.imagem != ''
                              ? NetworkImage(fanficData.imagem!)
                              : AssetImage("images/book.png") as ImageProvider,
                          fit: BoxFit.contain),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10),
                      child: Text(
                        fanficData.titulo ?? "",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                    padding: EdgeInsets.only(left: 0.0, top: 0.0),
                    child: Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width,
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.6),
                              child: Text(
                                fanficData.descricao ?? "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.grey[800]),
                              ))
                        ]),
                  )))
                ],
              ),
            ),
          )),
      onTap: () {
        _showOptions(context, fanficData, model);
      },
    );
  }

  void _showOptions(
      BuildContext context, FanficData fanficData, UserModel model) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return OptionsBottom(
            onClosing: onClosing,
            onEdit: () {
              Navigator.pop(context);
              showFanficPage(
                fanfic: fanficData,
              );
            },
            onOpen: () {
              final url = fanficData.link?.split("://");
              final uri = Uri(
                scheme: url?[0],
                path: url?[1],
              );
              launchUrl(uri);
              Navigator.pop(context);
            },
            onRemove: () {
              UserModel.of(context).deleteFanfic(fanficData.id!);
              store.removeFanfic(fanficData);
              Navigator.pop(context);
            },
            onVerifiction: () {
              store.removeFanfic(fanficData);
              if (fanficData.concluido == false) {
                fanficData.concluido = true;
              } else {
                fanficData.concluido = false;
              }
              UserModel.of(context)
                  .updateFanfic(fanficData.id, fanficData.fanficToMap());
              store.insertNewFanfic(fanficData);

              Navigator.pop(context);

              store.getFanfics(store.uid, model);
            },
            verifiction: store.verificaConcluida(fanficData.concluido!),
          );
        });
  }
}
