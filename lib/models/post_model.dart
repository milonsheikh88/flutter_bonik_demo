
class PostModel {
  int id;
   String title;
   String days;
   String cat;
   String gen;
   int qty;
   int price;
   int moq;
   double scolor;
   double ecolor;
   String size;
   String photo;

  PostModel({
    this.id,
    this.title,
    this.days,
    this.cat,
    this.gen,
    this.qty,
    this.price,
    this.moq,
    this.scolor,
    this.ecolor,
    this.size,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'days': days,
      'cat': cat,
      'gen': gen,
      'qty': qty,
      'price': price,
      'moq': moq,
      'scolor': scolor,
      'ecolor': ecolor,
      'size': size,
      'photo': photo,
    };
  }

  PostModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        days = res["days"],
        cat = res["cat"],
        gen = res["gen"],
        qty = res["qty"],
        price = res["price"],
        moq = res["moq"],
        scolor = res["scolor"],
        ecolor = res["ecolor"],
        size = res["size"],
        photo = res["photo"];
}