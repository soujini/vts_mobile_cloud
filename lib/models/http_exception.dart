class HttpException extends Object implements Exception{ //Forced to implement all classes exception has
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    return message;
    //return super.toString(); //Instance of HttpException
  }
}