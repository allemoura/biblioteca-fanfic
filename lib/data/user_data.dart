import 'package:biblioteca_de_fanfic/data/ImageData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? id;
  String? name;
  String? email;
  ImageData? image;

  UserData(
    this.id,
    this.name,
    this.email,
    this.image,
  );

  setName(String newName) {
    name = newName;
  }

  setEmail(String email) {
    email = email;
  }

  setImage(ImageData image) {
    image = image;
  }

  setId(String id) {
    id = id;
  }

  UserData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;

    final data = snapshot.data() as Map;

    name = data['name'];
    email = data['email'];

    final DocumentReference<Map<String, dynamic>> doc = data["image"];

    image = ImageData(doc.id, null);
  }

  Map<String, dynamic> userToMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "image": image?.imageToReferance(),
    };
  }
}
