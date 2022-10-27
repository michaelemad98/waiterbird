
import 'package:flutter/cupertino.dart';
import '../function/sharedprefrenc.dart';


class CartProvider with ChangeNotifier{
  int _counter= 0;
  int get counter => _counter;
  double _totalPrice = 0.0 ;
  double get totalPrice => _totalPrice;

  void _setPrefItems()async{
    CacheHelper.saveData(key: 'cart_item', value: _counter);
    CacheHelper.saveData(key: 'total_price', value: _totalPrice);
    notifyListeners();
  }
  void _getPrefItems()async{
    _counter= CacheHelper.getData(key: 'cart_item')??0 ;
    _totalPrice=CacheHelper.getData(key: 'total_price')??0.0 ;
    notifyListeners();
  }
  void AddCounter(){
    _counter++;
    _setPrefItems();
    notifyListeners();
  }
  void RemoveCounter(){
    _counter--;
    _setPrefItems();
    notifyListeners();
  }
  int getCounter(){
    _getPrefItems();
    return _counter;
  }
  void AddTotalprice(double producPrice){
    _totalPrice = _totalPrice + producPrice;
    _setPrefItems();
    notifyListeners();
  }
  void RemoveTotalprice(double producPrice){
    _totalPrice = _totalPrice - producPrice;
    _setPrefItems();
    notifyListeners();
  }
  double getTotalPrice(){
    _getPrefItems();
    return _totalPrice;
  }

}