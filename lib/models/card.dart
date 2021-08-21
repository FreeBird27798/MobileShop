class MyCard {
  late int id;
  late String type;
  late String holderName;
  late String cardNumber;
  late String expDate;
  late String cvv;
  late int userId;
  late String createdAt;
  late String updatedAt;

  MyCard();

  MyCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    holderName = json['holder_name'];
    cardNumber = json['card_number'];
    expDate = json['exp_date'];
    cvv = json['cvv'].toString();
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['holder_name'] = this.holderName;
    data['card_number'] = this.cardNumber;
    data['exp_date'] = this.expDate;
    data['cvv'] = this.cvv;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
