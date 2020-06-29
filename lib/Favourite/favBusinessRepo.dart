import 'package:soledesign/models/Business.dart';
import 'favBusinessDao.dart';

class FavBusinessRepository {
  //Favorite Article Respository where we create Database.
  final favBusinessDao = FavBusinessDao();
//Getting All the favourite Articles in the database
  Future getFavBusinesses({String query, int page}) =>
      favBusinessDao.getFavBusinesses(query: query, page: page);
//Get a Specific favorite Article
  Future getFavBusiness(int id) => favBusinessDao.getFavBusiness(id);
//Inserting the Article in the favourite database
  Future insertFavBusiness(Business business) =>
      favBusinessDao.createFavBusiness(business);
//Delete the Favourite Article By ID
  Future deleteFavBusinessById(int id) => favBusinessDao.deleteFavBusiness(id);
}
