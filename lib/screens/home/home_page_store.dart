import 'package:biblioteca_de_fanfic/data/Fanfic.dart';
import 'package:biblioteca_de_fanfic/models/user_model.dart';
import 'package:biblioteca_de_fanfic/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:biblioteca_de_fanfic/utils/utils.dart';

part 'home_page_store.g.dart';

class HomePageStore = _HomePageStoreBase with _$HomePageStore;

abstract class _HomePageStoreBase with Store {
  @observable
  List<FanficData> fanfics = [];
  @observable
  List<FanficData> fanficsFilter = [];
  @observable
  String estado = 'Entrar';
  @observable
  String saudacao = ' ';
  @observable
  String? uid;
  @observable
  bool inicio = false;

  void onInit(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      estado = 'Sair';
      //uid = UserModel.of(context).firebaseUser.uid;
    }
    if (UserModel.of(context).isLoggedIn()) {
      if (UserModel.of(context).userData?.name == null) {
        saudacao = " ";
      } else {
        saudacao = "Olá, ${UserModel.of(context).userData!.name}";
      }
    } else {
      saudacao = "Olá, bem vindo!";
    }
  }

  void filterFanfics(String filter) {
    fanficsFilter = fanfics
        .where(
          (fanfic) =>
              Utils().replaceValue(fanfic.titulo!.toLowerCase()).contains(
                    filter,
                  ),
        )
        .toList();
  }

  void startGetFanfics(UserModel model) {
    if (model.isLoggedIn()) {
      if (!inicio) {
        uid = model.getUserUid();
        getFanfics(uid, model);
        inicio = true;
      }
    }
  }

  @action
  void removeFanfic(FanficData fanfic) {
    fanfics.remove(fanfic);
    fanficsFilter.remove(fanfic);
  }

  void getFanfics(String? uid, UserModel model) async {
    List<FanficData> f = [];
    await model.getAllFanfics().then((value) {
      int i = 0;
      final documents = value.docs;
      while (i < documents.length) {
        FanficData data = FanficData.fromDocument(documents[i]);

        f.add(data);
        i++;
      }
    });

    fanfics = f;
    fanficsFilter = f;
  }

  void orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        fanficsFilter.sort((a, b) {
          return a.titulo!.toLowerCase().compareTo(b.titulo!.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        fanficsFilter.sort((a, b) {
          return b.titulo!.toLowerCase().compareTo(a.titulo!.toLowerCase());
        });
        break;
      case OrderOptions.onderconbai:
        fanficsFilter.sort((a, b) {
          if (a.concluido! && b.concluido == false)
            return 1;
          else if (a.concluido != false && b.concluido!)
            return -1;
          else
            return 0;
        });
        break;
      case OrderOptions.orderconsim:
        fanficsFilter.sort((a, b) {
          if (a.concluido == false && b.concluido!)
            return 1;
          else if (a.concluido! && b.concluido == false)
            return -1;
          else
            return 0;
        });
        break;
    }
  }

  String verificaConcluida(bool concluido) {
    if (!concluido) {
      return "Concluida";
    } else {
      return "Desmarcar";
    }
  }

  Color corCard(bool concluido) {
    if (concluido) {
      return Colors.greenAccent;
    } else {
      return Color.fromARGB(255, 249, 249, 249);
    }
  }

  @action
  void insertNewFanfic(FanficData fanfic) {
    fanfics.add(fanfic);
    fanficsFilter.add(fanfic);
  }
}
