class Item{
  final int? id ;
  final int? parent;
  final String? NameArabic;
  final String? NameEnglish;
  final String? Image;
  Item ({
    this.id,
    this.parent,
    this.NameArabic,
    this.NameEnglish,
    this.Image
  });
  Item.fromMap(Map<dynamic,dynamic>res):
        id=res['id'],
        parent=res['parent'],
        NameArabic=res['NameArabic'],
        NameEnglish=res['NameEnglish'],
        Image=res['Image'];
  Map<String,Object?>toMap(){
    return{
      'id':id,
      'parent':parent,
      'NameArabic':NameArabic,
      'NameEnglish':NameEnglish,
      'Image':Image,
    };
  }
}

class ItemSize{
  final int? id ;
  final int? parent;
  final String? NameArabic;
  final String? NameEnglish;
  final double? price;
  ItemSize ({
    this.id,
    this.parent,
    this.NameArabic,
    this.NameEnglish,
    this.price
  });
  ItemSize.fromMap(Map<dynamic,dynamic>res):
        id=res['id'],
        parent=res['parent'],
        NameArabic=res['NameArabic'],
        NameEnglish=res['NameEnglish'],
        price=res['price'];
  Map<String,Object?>toMap(){
    return{
      'id':id,
      'parent':parent,
      'NameArabic':NameArabic,
      'NameEnglish':NameEnglish,
      'Image':price,
    };
  }
}
