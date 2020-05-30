class Store {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;
  int indexx;

  Store.items(
      {this.itemName,
      this.itemPrice,
      this.itemImage,
      this.itemRating,
      this.indexx});
}

List<Store> storeItems = [
  Store.items(
      indexx: 0,
      itemName: "Carry Bag",
      itemPrice: 249,
      itemImage:
          "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1566405728-berluti-1566405720.jpg",
      itemRating: 0.0),
  Store.items(
      indexx: 1,
      itemName: "Carry Bag",
      itemPrice: 2499.00,
      itemImage:
          "https://images.bewakoof.com/original/jet-black-full-sleeve-t-shirt-men-s-plain-full-sleeve-t-shirts-1094-1583727923.jpg",
      itemRating: 0.0),
  Store.items(
      indexx: 2,
      itemName: "Carry Bag",
      itemPrice: 2500.00,
      itemImage:
          "https://5.imimg.com/data5/PP/ZG/NE/SELLER-81094103/lldpe-printed-bags-500x500.jpg",
      itemRating: 0.0),
  Store.items(
      indexx: 3,
      itemName: "D cut Woven Bag",
      itemPrice: 2499.00,
      itemImage:
          "https://5.imimg.com/data5/PP/ZG/NE/SELLER-81094103/lldpe-printed-bags-500x500.jpg",
      itemRating: 0.0),
  Store.items(
      indexx: 4,
      itemName: "D cut Bag",
      itemPrice: 2500.00,
      itemImage:
          "https://5.imimg.com/data5/PP/ZG/NE/SELLER-81094103/lldpe-printed-bags-500x500.jpg",
      itemRating: 0.0),
  Store.items(
      indexx: 5,
      itemName: "Carry Bag",
      itemPrice: 2499.00,
      itemImage:
          "https://5.imimg.com/data5/PP/ZG/NE/SELLER-81094103/lldpe-printed-bags-500x500.jpg",
      itemRating: 0.0),
  Store.items(
      indexx: 6,
      itemName: "D cut Shopping",
      itemPrice: 2500.00,
      itemImage:
          "https://5.imimg.com/data5/PP/ZG/NE/SELLER-81094103/lldpe-printed-bags-500x500.jpg",
      itemRating: 0.0),
  Store.items(
      indexx: 7,
      itemName: "Thaili wala",
      itemPrice: 2499.00,
      itemImage:
          "https://5.imimg.com/data5/PP/ZG/NE/SELLER-81094103/lldpe-printed-bags-500x500.jpg",
      itemRating: 0.0),
];
