class Category{
   final int? id ;
   final String? NameArabic;
   final String? NameEnglish;
   final String? Image;
   Category ({
   this.id,
   this.NameArabic,
   this.NameEnglish,
   this.Image
    });
   Category.fromMap(Map<dynamic,dynamic>res):
         id=res['id'],
          NameArabic=res['NameArabic'],
         NameEnglish=res['NameEnglish'],
         Image=res['Image'];
   Map<String,Object?>toMap(){
     return{
       'id':id,
       'NameArabic':NameArabic,
       'NameEnglish':NameEnglish,
       'Image':Image,
     };
   }
}