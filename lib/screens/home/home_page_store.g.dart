// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageStore on _HomePageStoreBase, Store {
  late final _$fanficsAtom =
      Atom(name: '_HomePageStoreBase.fanfics', context: context);

  @override
  List<FanficData> get fanfics {
    _$fanficsAtom.reportRead();
    return super.fanfics;
  }

  @override
  set fanfics(List<FanficData> value) {
    _$fanficsAtom.reportWrite(value, super.fanfics, () {
      super.fanfics = value;
    });
  }

  late final _$fanficsFilterAtom =
      Atom(name: '_HomePageStoreBase.fanficsFilter', context: context);

  @override
  List<FanficData> get fanficsFilter {
    _$fanficsFilterAtom.reportRead();
    return super.fanficsFilter;
  }

  @override
  set fanficsFilter(List<FanficData> value) {
    _$fanficsFilterAtom.reportWrite(value, super.fanficsFilter, () {
      super.fanficsFilter = value;
    });
  }

  late final _$estadoAtom =
      Atom(name: '_HomePageStoreBase.estado', context: context);

  @override
  String get estado {
    _$estadoAtom.reportRead();
    return super.estado;
  }

  @override
  set estado(String value) {
    _$estadoAtom.reportWrite(value, super.estado, () {
      super.estado = value;
    });
  }

  late final _$saudacaoAtom =
      Atom(name: '_HomePageStoreBase.saudacao', context: context);

  @override
  String get saudacao {
    _$saudacaoAtom.reportRead();
    return super.saudacao;
  }

  @override
  set saudacao(String value) {
    _$saudacaoAtom.reportWrite(value, super.saudacao, () {
      super.saudacao = value;
    });
  }

  late final _$uidAtom = Atom(name: '_HomePageStoreBase.uid', context: context);

  @override
  String? get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String? value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  late final _$inicioAtom =
      Atom(name: '_HomePageStoreBase.inicio', context: context);

  @override
  bool get inicio {
    _$inicioAtom.reportRead();
    return super.inicio;
  }

  @override
  set inicio(bool value) {
    _$inicioAtom.reportWrite(value, super.inicio, () {
      super.inicio = value;
    });
  }

  late final _$_HomePageStoreBaseActionController =
      ActionController(name: '_HomePageStoreBase', context: context);

  @override
  void removeFanfic(FanficData fanfic) {
    final _$actionInfo = _$_HomePageStoreBaseActionController.startAction(
        name: '_HomePageStoreBase.removeFanfic');
    try {
      return super.removeFanfic(fanfic);
    } finally {
      _$_HomePageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void insertNewFanfic(FanficData fanfic) {
    final _$actionInfo = _$_HomePageStoreBaseActionController.startAction(
        name: '_HomePageStoreBase.insertNewFanfic');
    try {
      return super.insertNewFanfic(fanfic);
    } finally {
      _$_HomePageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fanfics: ${fanfics},
fanficsFilter: ${fanficsFilter},
estado: ${estado},
saudacao: ${saudacao},
uid: ${uid},
inicio: ${inicio}
    ''';
  }
}
