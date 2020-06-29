import 'dart:async';
import 'package:soledesign/models/Business.dart';
import 'package:soledesign/Favourite/favBusinessRepo.dart';

class FavBusinessBloc {
  //Favourite Article Repository Class Instance
  final _businessRepository = FavBusinessRepository();

  final _businessController = StreamController<List<Business>>.broadcast();

  Stream<List<Business>> get businesses => _businessController.stream;

  FavBusinessBloc() {
    getFavBusinesses();
  }

  Future<List<Business>> getFavBusinesses({String query, int page}) async {
    final List<Business> businesses =
        await _businessRepository.getFavBusinesses(query: query, page: page);
    _businessController.sink.add(businesses);
    return businesses;
  }

  getFavBusiness(int id) async {
    final Business business = await _businessRepository.getFavBusiness(id);
    return business;
  }

  addFavBusiness(Business business) async {
    await _businessRepository.insertFavBusiness(business);
    getFavBusinesses();
  }

  deleteFavBusinessById(int id) async {
    _businessRepository.deleteFavBusinessById(id);
    getFavBusinesses();
  }

  dispose() {
    _businessController.close();
  }
}
