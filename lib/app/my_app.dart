
import 'package:ai_chatbot/config/binding_routing/app_pages.dart';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';
import 'package:toast/toast.dart';

//ignore:must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // For Firebase uncomment
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  var country = storageBox.read(StorageConstants.langCountry) ?? 'US'; // 'US'
  var lang = storageBox.read(StorageConstants.langCode) ?? 'en'; // 'French'

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    // storageBox.erase();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build- MyApp');
    ToastContext().init(context);
    return AppAnnotatedRegionWidget(
      child: GetMaterialApp(
        translations: LocalizationModel(),
        fallbackLocale: Locale(country.toString(), lang.toString()),
        useInheritedMediaQuery: false,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initialRoute,
        title: 'Casacut',
        getPages: AppPages.routes,
        // home: LoginScreen(),
      ),
    );

    //   FutureBuilder(
    //     future: _initialization,
    //     builder: (context, snapShot) {
    //   if (snapShot.connectionState == ConnectionState.done) {
    //     return ;
    //   }
    //   if (snapShot.hasError) {
    //     return const Center(
    //       child: Text('facing . hasError'),
    //     );
    //   }
    //   if (snapShot.connectionState == ConnectionState.waiting) {
    //     return Center(
    //         child: customLoader(
    //       AppColors.PRIMARY_COLOR,
    //     ));
    //   }
    //   return Container();
    // });
  }
}

// - Keyboard hide by tapping
class AppAnnotatedRegionWidget extends StatelessWidget {
  const AppAnnotatedRegionWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
          systemNavigationBarContrastEnforced: true,
        ),
        child: child,
      ),
    );
  }
}
