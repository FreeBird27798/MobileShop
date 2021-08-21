class SliderImage {
  late int id;
  late String url;
  late String imageUrl;

  SliderImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
