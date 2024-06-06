import 'package:get/get.dart';

class LocalizationModel extends Translations {


  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'login': "Login in English"

        },




    /// French or other Languages Strings
        'fr_FR': {
          'login': "login in French",

        }
      };
}
