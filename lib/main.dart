import 'package:ai_chatbot/utils/app_imports/app_imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'app/my_app.dart';

final storageBox = GetStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  // Hive.registerAdapter(NotesModelAdapter());
  // await Hive.openBox<NotesModel>('notes');
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyD2kxfwXr4jufZcvc92h7qdOaDKNlj1sO0',
          appId: '1:674647031682:android:46f2e7ad0c096050e5599b',
          messagingSenderId: 'messagingSenderId',
          projectId: 'chatbot-e395b'));
  await GetStorage.init();
  // checkInternetConnection();
  // initMessaging();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: ChatPage(),
//     );
//   }
// }
