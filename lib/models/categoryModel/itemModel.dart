class Item{
  final int? id ;
  final int? parent;
  final String? NameArabic;
  final String? NameEnglish;
  final String? Image;
  final int? SizeID;
  final String? SizeNameArabic;
  final String? SizeNameEnglish;
  final double ?SizePrice;
  Item ({
    this.id,
    this.parent,
    this.NameArabic,
    this.NameEnglish,
    this.Image,
    this.SizeID,
    this.SizeNameArabic,
    this.SizeNameEnglish,
    this.SizePrice
  });
  Item.fromMap(Map<dynamic,dynamic>res):
        id=res['id'],
        parent=res['parent'],
        NameArabic=res['NameArabic'],
        NameEnglish=res['NameEnglish'],
        Image=res['Image'],
        SizeID=res['SizeID'],
        SizeNameArabic=res['SizeNameArabic'],
        SizeNameEnglish=res['SizeNameEnglish'],
        SizePrice=res['SizePrice'];
  Map<String,Object?>toMap(){
    return{
      'id':id,
      'parent':parent,
      'NameArabic':NameArabic,
      'NameEnglish':NameEnglish,
      'Image':Image,
      'SizeID':SizeID,
      'SizeNameArabic':SizeNameArabic,
      'SizeNameEnglish':SizeNameEnglish,
      'SizePrice':SizePrice
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
