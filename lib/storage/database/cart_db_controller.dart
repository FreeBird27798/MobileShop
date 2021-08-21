import 'package:connect_store/api/api_settings.dart';
import 'package:connect_store/models/cart.dart';
import 'package:sqflite/sqflite.dart';

import 'db_operations.dart';
import 'db_provider.dart';

class CartDbController extends DbOperations<Cart> {
  Database _database;
  CartDbController() : _database = DBProvider().database;

  @override
  Future<int> create(Cart cartItem) async {
    return await _database.insert(ApiSettings.CART, cartItem.toMap());
  }

  @override
  Future<bool> delete(int id) async{
    int countOfDeletedRows = await _database.delete(ApiSettings.CART, where: 'id = ?', whereArgs: [id]);
    return countOfDeletedRows != 0;
  }

  @override
  Future<List<Cart>> read() async{
    var rowsMaps = await _database.query(ApiSettings.CART);
    if(rowsMaps.isNotEmpty){
    return rowsMaps.map((rowMap) => Cart.fromMap(rowMap)).toList();
    }
    return [];
  }

  @override
  Future<Cart?> show(int id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Cart data) {
    throw UnimplementedError();
  }

  Future<bool> deleteAllItem()async {
    int countOfDeletedRows = await _database.delete(ApiSettings.CART);
    return countOfDeletedRows != 0;
  }

}