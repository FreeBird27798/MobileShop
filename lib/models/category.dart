class Category {
  late int id;
  late String nameEn;
  late String nameAr;
  late String image;
  late int? productsCount;
  late int? subCategoriesCount;
  late String imageUrl;

  
  Category();

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    productsCount = json['products_count'];
    subCategoriesCount = json['sub_categories_count'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['products_count'] = this.productsCount;
    data['sub_categories_count'] = this.subCategoriesCount;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
