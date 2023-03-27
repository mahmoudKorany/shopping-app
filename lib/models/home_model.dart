class HomeModel
{
  bool ? status;
  DataHomeModel? data;
  HomeModel.fromJson(Map<String,dynamic>? json)
  {
    status = json?['status'];
    data = DataHomeModel.fromJson(json?['data']);
  }

}

class DataHomeModel
{
  List <Map<String,dynamic>>?  banners = [];
  List <Map<String,dynamic>>? products = [];
  DataHomeModel.fromJson(Map<String,dynamic>? json)
  {
    json?['banners'].forEach((element)
    {
     banners?.add(element);
    });
    json?['products'].forEach((element)
    {
      products?.add(element);
    });
  }
}

class HomeBanners
{
  int ? id;
  String? image;
  HomeBanners.fromJson(Map<String,dynamic>? json)
  {
    id = json?['id'];
    image = json?['image'];
  }


}


class HomeProduct
{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String ? name;
  String? image;
  bool? inFavorite;
  bool? inCart;

  HomeProduct.fromJson(Map<String,dynamic>? json)
  {
   id = json?['id'];
   price = json?['price'];
   image = json?['image'];
   oldPrice = json?['old_price'];
   inFavorite = json?['in_favorites'];
   inCart = json?['in_cart'];
   discount= json?['discount'];
   name = json?['name'];
  }
}