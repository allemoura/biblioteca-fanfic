class ImageData {
  String id;
  String? url;

  ImageData(this.id, this.url);

  String imageToReferance() {
    return "/images_profile/$id";
  }
}
