import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
} 

abstract class NetworkInfoImpl implements NetworkInfo{
InternetConnectionChecker internetConnectionChecker;

NetworkInfoImpl(this.internetConnectionChecker);

Future<bool>get isConnected => internetConnectionChecker.hasConnection;


}