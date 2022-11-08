import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/function/database/dbcategory.dart';
import 'package:waiterbird/function/database/dbhelper.dart';
import 'package:waiterbird/function/dio.dart';
import 'package:waiterbird/models/cartmodel.dart';
import 'package:waiterbird/models/categoryModel/categoryModel.dart';
import 'package:waiterbird/models/categoryModel/itemModel.dart';
import 'package:waiterbird/models/categorymodel.dart';
import 'package:waiterbird/models/itemmodel.dart';
import 'package:waiterbird/models/ordermodel.dart';
import 'package:waiterbird/models/waiterbirdmodel.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../constant/Toastmessage/compontents.dart';
import '../function/sharedprefrenc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  bool visibility = true;

  void onvisibilty() {
    visibility = false;
    emit(Visibility());
  }

  void offVisibility() {
    visibility = true;
    emit(UnVisibility());
  }

  bool isDark = false;

  void Darkmode() {
    isDark = true;
    print(isDark);
    emit(DarkmodeState());
  }

  void LightMode() {
    isDark = false;
    print(isDark);
    emit(LighmodeState());
  }

  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController carplatTEC = TextEditingController();
  String? accessToken;
  int? EmployeeID;
  int? StoreID;
  int? CompanyBranchID;

  bool isshow = false;

  void ISShow() {
    isshow = true;
    emit(LighmodeState());
  }

  void Sigin() async {
    emailTEC.text = 'waiter2';
    passwordTEC.text = '123456';
    if (emailTEC.text.isEmpty) {
      print('username is Empty');
      emit(SignINError());
    } else if (passwordTEC.text.isEmpty) {
      print('username is Empty');
      emit(SignINError());
    } else {
      try {
        var dio = Dio();
        Response response = await dio.post(
            'https://tolscafetest-api.birdcloud.qa/Restaurant/User/Login',
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Cookie': 'ASP.NET_SessionId=yvzkd3hr1efbh5pzrkjdxocy'
            }),
            data: {
              "UserName": "${emailTEC.text}",
              "Password": "${passwordTEC.text}"
            });
        if (response.statusCode == 200) {
          if (response.data['Success'] == true) {
            // print(response.data['Data']['Employee']['Stores'][0]['Store']['CompanyBranch']['Company']['ID']);
            EmployeeID = response.data['Data']['User']['Employee']['ID'];
            accessToken = response.data['Data']['AccessToken'];
            StoreID =
            response.data['Data']['Employee']['Stores'][0]['Store']['ID'];
            CompanyBranchID = response.data['Data']['Employee']['Stores'][0]
            ['Store']['CompanyBranch']['Company']['ID'];

            CacheHelper.saveData(key: 'EmployeeID', value: EmployeeID);
            CacheHelper.saveData(key: 'islogin', value: true);
            CacheHelper.saveData(key: 'accessToken', value: accessToken);
            CacheHelper.saveData(key: 'StoreID', value: StoreID);
            CacheHelper.saveData(
                key: 'CompanyBranchID', value: CompanyBranchID);
            emit(SignINSccess());
          } else {
            // print(response.data['Message']);
            emit(SignINError());
          }
        } else {
          emit(SignINError());
        }
      } catch (e) {
        // print(e);
        emit(SignINError());
      }
    }
  }

  Categorymodel categorymodel = Categorymodel();
  List CategotyData = [];

  GetCategory() async {
    // StoreID=CacheHelper.getData(key: 'StoreID');
    accessToken = CacheHelper.getData(key: 'accessToken');
    // print(CompanyBranchID);
    // print(EmployeeID);
    // print(StoreID);
    // print(accessToken);

    var dio = Dio();
    try {
      var responce = await dio.get(
        'https://tolscafetest-api.birdcloud.qa/restaurant/Category/GetList?ApperInFeast=false ',
        options: Options(
            followRedirects: false,
            // will not throw errorss
            validateStatus: (status) => true,
            headers: {
              'Cookie': 'ASP.NET_SessionId=goia3h4zfq4yi0cejwk3zw4j',
              'AccessToken': accessToken,
              'token': accessToken,
              'Accept': 'application/json',
              'Accept-Encoding': 'gzip, deflate, br',
              'Accept-Language':
              'en-EG,en;q=0.9,ar-EG;q=0.8,ar;q=0.7,de-CH;q=0.6,de;q=0.5,en-GB;q=0.4,en-US;q=0.3',
              'CompanyBranchID': '1',
              'Connection': 'keep-alive',
              'Content-Type': 'application/json',
              'EmployeeID': '148',
              'Host': 'tolscafetest-api.birdcloud.qa',
              'Origin': 'https://tolscafetest.birdcloud.qa',
              'Referer': 'https://tolscafetest.birdcloud.qa/',
              'Sec-Fetch-Dest': 'empty',
              'Sec-Fetch-Mode': 'cors',
              'Sec-Fetch-Site': 'same-site',
              'StoreID': '61',
              'FiscalYearID': '60',
              'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36',
              'Language': 'en',
              'sec-ch-ua':
              'Chromium;v=106, Google Chrome;v=106, Not;A=Brand;v=99',
              'sec-ch-ua-mobile': '?0',
              'sec-ch-ua-platform': 'Windows'
            }),
      );
      //print(responce.statusCode);
      //print(responce.data);
      categorymodel = Categorymodel.fromJson(responce.data);
      //print(categorymodel.data![0].id);
      CategotyData = categorymodel.data!;
      emit(GetCategotySucessState());

      return CategotyData;
    } catch (e) {
      // print(e);
      emit(GetCategotyErorrState());
    }
  }/////////////////////////////////////////////////////////
  var image_url='https://www.tastingtable.com/img/gallery/coffee-brands-ranked-from-worst-to-best/l-intro-1645231221.jpg';
  var imagebase64;
  void ConvertImage()async{
    try{
      var imageresponce= await http.get(Uri.parse(image_url));
      imagebase64= base64Encode(imageresponce.bodyBytes);
      print(imagebase64);
      emit(ConvertimageSucessState());
    }catch(e){
      print(e);
    }
  }
  /////////////////////////////////////////
  DBCategory dbCategory =  DBCategory();
  List imageCat=[];
  InsertCategory()async{
    accessToken = CacheHelper.getData(key: 'accessToken');
    var dio = Dio();
    try {
      var responce = await dio.get(
        'https://tolscafetest-api.birdcloud.qa/restaurant/Category/GetList?ApperInFeast=false ',
        options: Options(
            followRedirects: false,
            // will not throw errorss
            validateStatus: (status) => true,
            headers: {
              'StoreID': '61',
              'AccessToken': '${accessToken}',
              'token': '${accessToken}',
              'Content-Type': 'application/json',
              'Cookie': 'ASP.NET_SessionId=uu0bv5jfveqe1315j1t1znbp'
            }),
      );
      categorymodel = Categorymodel.fromJson(responce.data);
      CategotyData = categorymodel.data!;
      emit(GetCategotySucessState());
      for (int c =0; c<categorymodel.data!.length;c++){
        print('assets/images${categorymodel.data![c].image}');
        dbCategory.insert(Categorym(
        id: categorymodel.data![c].id,
        NameArabic: categorymodel.data![c].nameArabic,
        NameEnglish: categorymodel.data![c].nameEnglish,
        Image: 'assets/images${categorymodel.data![c].image}'
      )).then((value){
        // print(imagebase64);
        showToast(text: "Sucess Add", state: ToastState.SUCCESS);
      }).onError((error, stackTrace){
        print('Erorr:${error.toString()}');
        emit(InsertCatdgoryErorr());
        if(error.toString()=='Null check operator used on a null value'){
          showToast(text: 'Please Added Again !', state: ToastState.WARNING);
        }else{showToast(text: 'Already Added !', state: ToastState.ERROR);}
      });
      //

      }
      // return CategotyData;

    } catch (e) {
      // print(e);
      emit(InsertCatdgoryErorr());    }
  }


///////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////

  ItemModel itemModel = ItemModel();
  List itemData = [];
  List cardSizes = [];
  List price = [];
  String? responceData;

  GetItem(String categoryId) async {
    accessToken = CacheHelper.getData(key: 'accessToken');
    var dio = Dio();
    try {
      var responce = await dio.get(
        'https://tolscafetest-api.birdcloud.qa/restaurant/Item/GetAllItemsByCategoryID?id=$categoryId',
        options: Options(
            followRedirects: false,
            // will not throw errorss
            validateStatus: (status) => true,
            headers: {
              'StoreID': '61',
              'AccessToken': '${accessToken}',
              'token': '${accessToken}',
              'Content-Type': 'application/json',
              'Cookie': 'ASP.NET_SessionId=uu0bv5jfveqe1315j1t1znbp'
            }),
      );
      // print(responce.statusCode);
      // print(responce.data);
      itemModel= ItemModel.fromJson(responce.data);
      // print(itemModel.message);
      responceData = jsonEncode(responce.data);
      CacheHelper.saveData(key: 'responceData', value: "${responceData}");
      itemData = responce.data['Data']!;
      for (int data = 0; data < itemData.length; data++) {
        cardSizes = itemData[data]['CardSizes'];
        for (int card = 0; card < cardSizes.length; card++) {
          price = cardSizes[card]['Price'];
        }
      }
      emit(GetItemSucessState());
      return responce.data;
    } catch (e) {
      // print(e);
      emit(GetItemSucessState());
    }
  }
/////////////////////////////////////
 List categoryid=[155,160,164,165,166,162,172,168,169];

insertItem()async{
  accessToken = CacheHelper.getData(key: 'accessToken');
  var dio = Dio();
  for(int ci=0;ci<categoryid.length;ci++){
    // print(categoryid[ci]);
    try {
      var responce = await dio.get(
        'https://tolscafetest-api.birdcloud.qa/restaurant/Item/GetAllItemsByCategoryID?id=${categoryid[ci]}',
        options: Options(
            followRedirects: false,
            // will not throw errorss
            validateStatus: (status) => true,
            headers: {
              'StoreID': '61',
              'AccessToken': '${accessToken}',
              'token': '${accessToken}',
              'Content-Type': 'application/json',
              'Cookie': 'ASP.NET_SessionId=uu0bv5jfveqe1315j1t1znbp'
            }),
      );
      // print(responce.statusCode);
      // print(responce.data);
      itemModel= ItemModel.fromJson(responce.data);
      for(int it=0; it<itemModel.data!.length; it++){
        // print(itemModel.data![it].image);
        dbCategory.insertItem(Item(
          id: itemModel.data![it].id,
          parent: itemModel.data![it].categoryId,
          NameArabic:itemModel.data![it].nameArabic,
          NameEnglish: itemModel.data![it].nameEnglish,
          Image: 'assets/images${itemModel.data![it].image}',
          SizeID: itemModel.data![it].cardSizes![0].id,
          SizeNameArabic: itemModel.data![it].cardSizes![0].size!.nameArabic,
          SizeNameEnglish: itemModel.data![it].cardSizes![0].size!.nameEnglish,
          SizePrice: itemModel.data![it].cardSizes![0].price,
        )).then((value){
          showToast(text: "Sucess Add", state: ToastState.SUCCESS);
        }).onError((error, stackTrace){
          print('Erorr:${error.toString()}');
          emit(InsertCatdgoryErorr());
          if(error.toString()=='Null check operator used on a null value'){
            showToast(text: 'Please Added Again !', state: ToastState.WARNING);
          }else{showToast(text: 'Already Added !', state: ToastState.ERROR);}
        });
      }
      emit(GetItemSucessState());
      return responce.data;
    } catch (e) {
      // print(e);
      emit(GetItemSucessState());
    }
  }
}
//////////////////////////////////////////////
  late Future<List<Categorym>> tcategoty;
  Future<List<Categorym>> get categorym => tcategoty;
  Future<List<Categorym>> getCategoryData()async{
    tcategoty = dbCategory.getCategoryList();
    emit(GetCategorySucessState());
    return tcategoty;
  }
/////////////////////////////////////////////
  late Future<List<Item>> titem;
  Future<List<Item>> get itemm => titem;
  Future<Future<List<Item>>> getItemData()async{
    titem = dbCategory.getItemList();

    emit(GetCategorySucessState());
    return titem;
  }
  ///////////////////////////////////
  String image = '';
  String nameEng = '';
  List size = [];
  var prise;
  int? itemid;

  GetDetils(var id) async {
    responceData = CacheHelper.getData(key: 'responceData');
    // print(responceData);
    var bodydata = jsonDecode(responceData!);
    itemData = bodydata['Data'];
    //print(itemData);
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + id);

    final namingEnglish =
    itemData.where((data) => data['ID'] == int.parse('$id'));
    namingEnglish.forEach((element) {
      image = element['Image'];
      nameEng = element['NameEnglish'];
      itemid = element['ID'];
      size = element['CardSizes'];
      for (int i = 0; i < size.length; i++) {
        prise = jsonEncode(size[i]['Price']);
      }
      // print(image);
      // print(nameEng);
      // print(itemid);
      // print(size);
      // print(prise);
    });
    emit(GetItemSucessState());
  }

  ////////////////////////////////////
  int item = 1;

  int itemprice = 30;
  double? finalprice;
  double? doubleNum;

  void AddItem() {
    item++;
    print(prise);
    doubleNum = double.parse(prise);
    finalprice = item * doubleNum!;

    emit(AddItemtostoreSucessState());
  }

  void RemoveItem() {
    if (item == 0 || item == 1) {
      itemprice = 30;
      item = 1;
    } else {
      item--;
      finalprice = item * doubleNum!;
    }

    emit(RemoveItemtostoreSucessState());
  }

  int tcounter = 0;

  int get counter => tcounter;
  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  void _setPrefItems() async {
    CacheHelper.saveData(key: 'cart_item', value: tcounter);
    CacheHelper.saveData(key: 'total_price', value: _totalPrice);
    emit(SetPrefreState());
  }

  void _getPrefItems() async {
    tcounter = CacheHelper.getData(key: 'cart_item') ?? 0;
    _totalPrice = CacheHelper.getData(key: 'total_price') ?? 0.0;
    emit(GetprefreState());
  }

  void AddCounter() {
    tcounter++;
    _setPrefItems();
    emit(AddCounterState());
  }

  void RemoveCounter() {
    tcounter--;
    _setPrefItems();
    emit(RemoveCounterState());
  }
  void DeleteCounter(){
    tcounter=0;
    _setPrefItems();
    emit(DeleteCounterState());
  }

  int getCounter() {
    _getPrefItems();
    return tcounter;
  }

  void AddTotalprice(double producPrice) {
    print(tcounter);
    _totalPrice = _totalPrice + producPrice;
    _setPrefItems();
    emit(AddTotalpriceState());
  }

  void RemoveTotalprice(double producPrice) {
    print(tcounter);
    _totalPrice = _totalPrice - producPrice;
    _setPrefItems();
    emit(RemoveTotalpriceState());
  }
  int qty=0;
  void DeleteTotalprice(double producPrice) {
    print(tcounter);
    _totalPrice = _totalPrice - (producPrice * qty);
    _setPrefItems();
    emit(RemoveTotalpriceState());
  }

  double getTotalPrice() {
    _getPrefItems();
    if (_totalPrice < 0) {
      _totalPrice = 0.0;
      return _totalPrice;
    } else {
      return _totalPrice;
    }
  }

  DBHelper db = DBHelper();
  late Future<List<Cart>> tcart;

  Future<List<Cart>> get cart => tcart;

  Future<List<Cart>> getData() {
    tcart = db.getCartList();
    emit(AddItemtoCartSucessState());
    return tcart;
  }

  void CreateOrder(var type) async {
    accessToken = CacheHelper.getData(key: 'accessToken');
    List orders = await getData() ;
    List ?items;
    List CardSizes=[];
    for(int o=0;o<orders.length;o++){
      // print(orders[o].productName);
      items=[{
        "ID": o,
        "OrderID": o,
        "CardSizeID": orders[o].productId,
        "Price":orders[o].initialPrice,
        "TotalValue": orders[o].initialPrice,
        "NetValue": orders[o].initialPrice,
        "DiscountValue": 0,
        "DiscountRate": 0,
        "AdditionsPrice": 0,
        "QTY": orders[o].quantity,
        "Remarks": "",
        "OrderItemExcludedOptions": null,
        "OrderItemAdditions": null
      }];
      CardSizes.addAll(items);
    }
    // print(CardSizes);
    // /*
    var headers = {
      'StoreID': '61',
      'AccessToken': '${accessToken}',
      'token': '${accessToken}',
      'Content-Type': 'application/json',
      'Cookie': 'ASP.NET_SessionId=uu0bv5jfveqe1315j1t1znbp'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://tolscafetest-api.birdcloud.qa/restaurant/Order/Post?DoNotCare=false'));
    request.body = json.encode({
      "ID": 0,
      "SyncID": "",
      "OrderTypeID":"${type}" ,
      "Code": null,
      "CustomerID": null,
      "StoreID": 61,
      "Label": null,
      "BigTotal": _totalPrice,
      "SmallTotal": 0,
      "DeliveryValue": 0,
      "DiscountRate": 0,
      "DiscountValue": 0,
      "Tax": 0,
      "NetValue": _totalPrice,
      "CashAmount": 0,
      "CreditCardAmount": 0,
      "Notes": null,
      "TableID": 0,
      "CarNumber": carplatTEC.text,
      "IsGift": false,
      "ReciveTime": null,
      "AddressID": 0,
      "TalabatID": 0,
      "TalabatNumber": null,
      "TalabatCustomerMobile": null,
      "Remarks": "",
      "MealID": 0,
      "CustomerSubscriptionID": 0,
      "CardSizes":CardSizes,
      "CancelledDate": null,
      "CancelledByID": null,
      "ApproveCancelledDate": null,
      "ApproveCancelledByID": null,
      "CancelledReason": null,
      "ApproveCancelledReason": null
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      emit(CreateOrderStateSucess());
    } else {
      print(response.reasonPhrase);
      emit(CreateOrderStateError());
    }
    // */
  }

  Ordermodel ordermodel = Ordermodel();
  List orderDatalistnumber = [];
  List ordersDetails = [];
  String? responceOrder;

  GetListOrder() async {
    orderDatalistnumber.clear();
    ordersDetails.clear();
    accessToken = CacheHelper.getData(key: 'accessToken');
    var headers = {
      'StoreID': '61',
      'AccessToken': '${accessToken}',
      'token': '${accessToken}',
      'Content-Type': 'application/json',
      'Cookie': 'ASP.NET_SessionId=uu0bv5jfveqe1315j1t1znbp'
    };
    var dio = Dio();
    var response = await dio.get(
      'https://tolscafetest-api.birdcloud.qa/restaurant/Car/GetList',
      options: Options(
          followRedirects: false,
          // will not throw errorss
          validateStatus: (status) => true,
          headers: headers),
    );
    if (response.statusCode == 200) {
      // print(response.data);
      responceOrder = jsonEncode(response.data);
      CacheHelper.saveData(key: 'responceOrder', value: "${responceOrder}");
      ordermodel = Ordermodel.fromMap(response.data);
      // print(ordermodel.data![0].orders![0].code);

      ordermodel.data!.map((e) {
        orderDatalistnumber.add(e.number);
        e.orders!.map((elment) {
          ordersDetails.add(elment.code);
        }).toList();
      }).toList();
      // print(orderDatalistnumber);
      // print(ordersDetails);
    }
  }

  List orderdeilslist = [];
  List orderdeilslistcode = [];
  List orderdeilslistid = [];

  GetOrderDetils(var num) async {
    print('hi');
    responceOrder = CacheHelper.getData(key: 'responceOrder');
    var bodyData = jsonDecode('${responceOrder}');
    //print(bodyData);
    ordermodel = Ordermodel.fromMap(bodyData);
    final orderdeils = ordermodel.data!.where((element) {
      return element.number == num;
    });
    orderdeils.forEach((element) {
      orderdeilslist = element.orders!;
    });
    orderdeilslistcode.clear();
    orderdeilslistid.clear();
    orderdeilslist.map((e) {
      orderdeilslistcode.add(e.code);
      orderdeilslistid.add(e.id);
    }).toList();
    print(orderdeilslistcode);
    print(orderdeilslistid);
  }

  String OrderTypeNameEnglish= '';
  String Date= '';
  List OrderItemsPrice=[];
  List OrderItemsQTY=[];
  List OrderItemsTotalValue=[];
  List OrderItemsNameArabic=[];
  GetOrderDetiales(var id) async {
    accessToken = CacheHelper.getData(key: 'accessToken');
    var headers = {
      'StoreID': '61',
      'AccessToken': '${accessToken}',
      'token': '${accessToken}',
      'Content-Type': 'application/json',
      'Cookie': 'ASP.NET_SessionId=uu0bv5jfveqe1315j1t1znbp',
      'language':'en'
    };
    var dio = Dio();
    var response = await dio.get(
        'https://tolscafetest-api.birdcloud.qa/restaurant/Order/Get?id=${id}',
        options: Options(
            followRedirects: false,
            // will not throw errorss
            validateStatus: (status) => true,
            headers: headers));
    if(response.statusCode==200){
      print(response.data);
      OrderTypeNameEnglish = response.data['Data']['OrderTypeNameEnglish'];
      Date=response.data['Data']['Date'];
      response.data['Data']['OrderItems'].map((e){
        OrderItemsPrice.add(e['Price']);
        OrderItemsQTY.add(e['QTY']);
        OrderItemsTotalValue.add(e['TotalValue']);
        OrderItemsNameArabic.add(e['Name']);
      }).toList();
      emit(GetListOrderStateSucess());
    }
  }
}
