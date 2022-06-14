import 'package:basic_utils/basic_utils.dart';
import 'package:encrypt/encrypt.dart';

class Encrypt{

  static const String publicKey = 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDSovT1rrwzrGoMCFb6z8e+5lzVdAD5o8krGIwdfxrVE2OnMijUZdkQk7etPJvZ2JOVXghthAGUUJkDUE8n2ZMNFKPjMrQJI49ewVzqWOKOvgU6Iu60Sn0xpeietP1wWXBkszdV1WfNBJUo2hhPDnIPMGzzdfLW5rMu+tczeUriJQIDAQAB';

  static String addWrap(String content){
    String str = content.substring(0,content.length);
    for(int i= 64;i<content.length;i+=64){
      if(content.substring(i,i+1) != "\n"){
        str = StringUtils.addCharAtPosition(str, "\n", i);
        i++;
      }
    }
    return str;
  }

  static String publicKeyString(){
    return "-----BEGIN PUBLIC KEY-----\n"+addWrap(publicKey)+"\n-----END PUBLIC KEY-----";
  }

  static encryption(String content) async{
    final parser = RSAKeyParser();
    var key = publicKeyString();
    RSAPublicKey publicKey = parser.parse(key) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(content).base64;
  }
}