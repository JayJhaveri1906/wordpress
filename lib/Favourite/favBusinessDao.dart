import 'dart:async';
import 'package:soledesign/models/Business.dart';
import 'favBusinessDb.dart';

class FavBusinessDao {
  //FavArticleDatabaseProvider make a favourite.db database create if the no db is present in the app
  //If present get the Intial DB.
  //Calling Simple constructor
  final dbProvider = FavBusinessDatabaseProvider.dbProvider;
//Funtion for Adding the favourite Article in the OS Directory System.
  Future<int> createFavBusiness(Business business) async {
    //
    final db = await dbProvider.database;
//
    var result = await db.insert(favTableBusiness, business.toDatabaseJson());
    return result;
  }

//Getting the Favorite Articles from the Database which is created by sqllite and pathProvider.
  Future<List<Business>> getFavBusinesses(
      {List<String> columns, String query, int page}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(
          favTableBusiness,
          columns: columns,
          where: 'name LIKE ?',
          whereArgs: ["%$query%"],
        );
    } else {
      result = await db.query(favTableBusiness, columns: columns);
    }

    List<Business> articles = result.isNotEmpty
        ? result.map((item) => Business.fromDatabaseJson(item)).toList()
        : [];
    return articles;
  }

//Get or Read Favorite Article Singular
  Future<Business> getFavBusiness(int id) async {
    final db = await dbProvider.database;
    List<Map> maps =
        await db.query(favTableBusiness, where: 'id = ?', whereArgs: [id]);
    Business article =
        maps.length > 0 ? Business.fromDatabaseJson(maps.first) : null;
    return article;
  }

//Delete the Favourite Article.
  Future<int> deleteFavBusiness(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(favTableBusiness, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
