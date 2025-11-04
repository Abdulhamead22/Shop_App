import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache_helper.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_cubit.dart';
import 'package:flutter_application_1/layout/shop_App/cubit/shop_state.dart';
import 'package:flutter_application_1/layout/shop_App/dio/dio_helper.dart';
import 'package:flutter_application_1/layout/shop_App/modules/login/shop_login_screen.dart';
import 'package:flutter_application_1/layout/shop_App/modules/onBoarding/onboarding_screen.dart';
import 'package:flutter_application_1/layout/shop_App/shop_layout.dart';
import 'package:flutter_application_1/style/theam.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
systemOverlayStyle: SystemUiOverlayStyle(
  statusBarColor: Colors.red,//للتغير لون الخط الي فوق الي بظهر فيه ايقونات النت والساعة
    statusBarIconBrightness: Brightness.light,//لتغير لون الايقونات حسب المود ابيض او اسود
),
WidgetsFlutterBinding.ensureInitialized(): هادا بتضمنلي انو كل async حيتنفذ
 */
//
  String? isToken;
void main() async {
WidgetsFlutterBinding.ensureInitialized();

  DioHelperShop.init();
  await CacheHelper.init();

  Widget? pageStart;
  bool? isDark = CacheHelper.getData(key: "isDark");
 bool? isBoarding = CacheHelper.getData(key: "onBoarding");
  isToken = CacheHelper.getData(key: "token");
  if (isBoarding != null) {
    if (isToken != null) {
      pageStart = const ShopLayout();
    } else {
      pageStart = const LoginScreen();
    }
  } else {
    pageStart = const OnboardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startpage: pageStart,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startpage;
  const MyApp({this.isDark,required this.startpage,  super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoriseData()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
          listener: (BuildContext context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ligthTheam,
              darkTheme: darkTheam,
              // themeMode: NewsCubit.get(context).isDark
              //     ? ThemeMode.dark
              //     : ThemeMode.light,
              themeMode: ThemeMode.light,
             home: startpage,

            );
          }),
    );
  }
}
