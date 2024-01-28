import 'package:advanced_flutter/data/network/error_handler.dart';
import 'package:advanced_flutter/data/response/responses.dart';
 
const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000; // 1 MINUTE IN MILLIS

const CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
const CACHE_STORE_DETAILS_INTERVAL = 60 * 1000; // 30s in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
   Future<void> saveHomeToCache(HomeResponse homeResponse);

   void clearCache();

  void removeFromCache(String key);

Future<StoreDetailsResponse>getStoreDetails();
  }

  class LocalDataSourceImplementer implements LocalDataSource {
     Map<String, CachedItem> cacheMap = Map();
  @override
  Future<HomeResponse> getHomeData() {
    CachedItem ?cachedItem=cacheMap[CACHE_HOME_KEY];
   if(cachedItem!=null&&cachedItem.isValid(CACHE_HOME_INTERVAL)){

return cachedItem.data;
   }else{

    throw  ErrorHandler.handle(DataSource.CACHE_ERROR);
   }
     

     
  }
  
  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async{
  cacheMap[CACHE_HOME_KEY]=CachedItem(HomeResponse);
  }
  
  @override
  void clearCache() {
cacheMap.clear();  }
  
  @override
  void removeFromCache(String key) {
 cacheMap.remove(key);
  }
  
  @override
  Future<StoreDetailsResponse> getStoreDetails() {
     CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if (cachedItem != null &&
        cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }
  }

  class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    // expirationTime is 60 secs
    int currentTimeInMillis =
        DateTime.now().millisecondsSinceEpoch; // time now is 1:00:00 pm

    bool isCacheValid = currentTimeInMillis - expirationTime < cacheTime; // cache time was in 12:59:30
    // false if current time > 1:00:30
    // true if current time <1:00:30
    return isCacheValid;
  }



}