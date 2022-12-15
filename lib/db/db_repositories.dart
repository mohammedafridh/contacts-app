import 'package:sqflite/sqflite.dart';
import 'db_connection.dart';

class dbRepository
{
  late dbConnection _dbConnection;

  dbRepository()
  {
    _dbConnection = dbConnection();
  }

  static Database? _database;
  Future<Database?> get database async
  {
    if(_database != null){
      return _database;
    } else{
      _database = await _dbConnection.setDatabase();
      return _database;
    }
  }

  //insert new contact

  insertContact(table,data) async
  {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //read all contacts

  readContact(table) async
  {
    var connection = await database;
    return await connection?.query(table);
  }

  //read a particular contact
  readSingleContact(table,contactId) async
  {
    var connection = await database;
    return await connection?.query(table,where: 'id=?', whereArgs: [contactId]);
  }

  //update contact

  updateContact(table,data) async
  {
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //delete contact

  deleteContact(table,contactId) async
  {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id = $contactId");
  }

}