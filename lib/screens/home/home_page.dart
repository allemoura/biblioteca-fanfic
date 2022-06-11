import 'package:biblioteca_de_fanfic/data/Fanfic.dart';
import 'package:biblioteca_de_fanfic/models/user_model.dart';
import 'package:biblioteca_de_fanfic/screens/fanfic_page.dart';
import 'package:biblioteca_de_fanfic/screens/home/home_page_store.dart';
import 'package:biblioteca_de_fanfic/screens/home/widget/fanfic_card.dart';
import 'package:biblioteca_de_fanfic/screens/home/widget/order_filter.dart';
import 'package:biblioteca_de_fanfic/screens/login_screen.dart';
import 'package:biblioteca_de_fanfic/screens/perfil_screen.dart';
import 'package:biblioteca_de_fanfic/widgets/image_circle.dart';
import 'package:biblioteca_de_fanfic/widgets/searcher_bar.dart';
import 'package:biblioteca_de_fanfic/widgets/top_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:scoped_model/scoped_model.dart';

enum OrderOptions { orderaz, orderza, orderconsim, onderconbai }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? width;
  double? tamanho;
  final HomePageStore store = HomePageStore();

  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store.onInit(context);

    width = MediaQuery.of(context).size.width;
    tamanho = MediaQuery.of(context).size.height * 0.15;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
          title: Padding(
            padding: EdgeInsets.only(left: 5),
            child: SearcherBar(
              onFilter: store.filterFanfics,
            ),
          ),
          actions: [
            OrderFilter(
              onSelected: store.orderList,
            )
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (UserModel.of(context).isLoggedIn()) {
              _showFanficPage();
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: body());
  }

  onChanged() {
    setState(() {});
  }

  Widget body() {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (model.isLoding) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      } else {
        store.startGetFanfics(model);

        return Observer(builder: (context) {
          return Stack(children: <Widget>[
            SafeArea(
                child: TopContainer(
              height: tamanho,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            child: ImageCircle(
                              image: "images/perfil.png",
                            ),
                            onTap: model.isLoggedIn()
                                ? () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PerfilScreen()));
                                  }
                                : null,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  store.saudacao,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  child: Text(
                                    store.estado,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (UserModel.of(context).isLoggedIn()) {
                                    UserModel.of(context).signOut();
                                    store.estado = 'Entrar';
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  }
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            )),
            model.isLoggedIn()
                ? Observer(
                    builder: (context) => Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.2),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding:
                              EdgeInsets.only(top: 10, left: 10.0, right: 10.0),
                          itemCount: store.fanficsFilter.length,
                          itemBuilder: (context, index) {
                            return FanficCard(
                              onClosing: onChanged,
                              fanficData: store.fanficsFilter[index],
                              model: model,
                              store: store,
                              showFanficPage: _showFanficPage,
                            );
                          },
                        )))
                : Container()
          ]);
        });
      }
    });
  }

  void _showFanficPage({
    FanficData? fanfic,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FanficPage(
          fanfic: fanfic,
        ),
      ),
    );
  }
}
