part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class Visibility extends AppState{}
class UnVisibility extends AppState{}
class DarkmodeState extends AppState{}
class LighmodeState extends AppState{}


class SignINSccess extends AppState{}
class SignINError extends AppState{}
class HomemainState extends AppState{}

class GetCategotySucessState extends AppState{}
class GetCategotyErorrState extends AppState{}

class GetItemSucessState extends AppState{}
class GetItemErorrState extends AppState{}

class AddItemtostoreSucessState extends AppState{}
class AddItemtostoreErrorState extends AppState{}
class RemoveItemtostoreSucessState extends AppState{}
class RemoveItemtostoreErrorState extends AppState{}


class AddItemtoCartSucessState extends AppState{}
class AddItemtoCartErrorState extends AppState{}

class SetPrefreState extends AppState{}
class GetprefreState extends AppState{}

class AddCounterState extends AppState{}
class RemoveCounterState extends AppState{}

class AddTotalpriceState extends AppState{}
class RemoveTotalpriceState extends AppState{}

class CreateOrderStateSucess extends AppState{}
class CreateOrderStateError extends AppState{}
class GetListOrderStateSucess extends AppState{}
class GetListOrderStateError extends AppState{}





