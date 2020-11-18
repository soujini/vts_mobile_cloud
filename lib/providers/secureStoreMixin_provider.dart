import 'package:flutter_secure_storage/flutter_secure_storage.dart';
/*
* Example of a secure store as a Mixin
* Usage:

import '../mixins/secure_store_mixin.dart';

MyClass extends StatelessWidget with SecureStoreMixin {

  exampleSet(){
    setSecureStore('jwt', 'jwt-token-data');
  }

  exampleGet(){
    await  getSecureStore('jwt', (token) { //print(token); });
  }
}

*/

class SecureStoreMixin{

  final secureStore = new FlutterSecureStorage();

  void setSecureStore(String key, String data) async {
    await secureStore.write(key: key, value: data);
  }

  void getSecureStore(String key, Function callback) async {
//    await secureStore.readAll().then(callback);
    await secureStore.read(key: key).then(callback);
  }

}