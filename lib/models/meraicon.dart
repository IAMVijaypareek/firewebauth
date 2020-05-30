class Storess {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;
  int indexx;

  Storess.items(
      {this.itemName,
      this.itemPrice,
      this.itemImage,
      this.itemRating,
      this.indexx});
}

List<Storess> storeItemss = [
  Storess.items(
      indexx: 0,
      itemName: "Carry Bag",
      itemPrice: 249,
      itemImage:
          "images/coronavirus.png",
      itemRating: 0.0),
  Storess.items(
      indexx: 1,
      itemName: "Carry Bag",
      itemPrice: 2499.00,
      itemImage:
          "images/doctor.png",
      itemRating: 0.0),
  Storess.items(
      indexx: 2,
      itemName: "Carry Bag",
      itemPrice: 2500.00,
      itemImage:
           "images/medical-mask.png",
      itemRating: 0.0),
  Storess.items(
      indexx: 3,
      itemName: "D cut Woven Bag",
      itemPrice: 2499.00,
      itemImage:
           "images/shirt.png",
      itemRating: 0.0),
  Storess.items(
      indexx: 4,
      itemName: "D cut Bag",
      itemPrice: 2500.00,
      itemImage:
          "images/tshirt.png",
      itemRating: 0.0),
  Storess.items(
      indexx: 5,
      itemName: "Carry Bag",
      itemPrice: 2499.00,
      itemImage:
          "images/stethoscope.png",
      itemRating: 0.0),
  Storess.items(
      indexx: 6,
      itemName: "D cut Shopping",
      itemPrice: 2500.00,
      itemImage:
          "images/coronavirus.png",
      itemRating: 0.0),
  Storess.items(
      indexx: 7,
      itemName: "Thaili wala",
      itemPrice: 2499.00,
      itemImage:
          "images/coronavirus.png",
      itemRating: 0.0),
];
