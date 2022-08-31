class FoxbitAssets{
  static String _path = './assets/images/';
  static String _ext = ".png";

  String getAssetWithId(int id){
    return _path + '$id' + _ext;
  }
}