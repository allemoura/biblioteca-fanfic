import 'package:cloud_firestore/cloud_firestore.dart';

class FanficData {
  bool? concluido;
  String? id;

  String? titulo;
  String? descricao;

  String? imagem;

  String? link;

  FanficData();

  FanficData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    final data = snapshot.data() as Map;
    titulo = data['titulo'];
    descricao = data['descricao'];
    imagem = data['imagem'];

    concluido = data['concluido'];
    link = data['link'];
  }

  Map<String, dynamic> fanficToMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
      'link': link,
      'concluido': concluido,
    };
  }
}
