class Product {
  String name;
  String imageLink;
  String price;

  Product({required this.name, required this.imageLink, required this.price});
  get toJson => {'name': name, 'imageLink': imageLink, 'price': price};
  String get getName => name;
  String get getImageLink => imageLink;
  String get getPrice => price;

  set setName(String newName) {
    name = newName;
  }

  set setImageLink(String newImageLink) {
    imageLink = newImageLink;
  }

  set setPrice(String newPrice) {
    price = newPrice;
  }
}
