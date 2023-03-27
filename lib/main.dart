// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/app_cubit/app_cubit.dart';
import 'package:shopping_app/app_cubit/app_states.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_cubit.dart';
import 'package:shopping_app/modules/shop_home_layout/shop_layout.dart';
import 'package:shopping_app/modules/shop_login_screen/cubit/shop_login_cubit.dart';
import 'package:shopping_app/modules/shop_login_screen/shop_login_screen.dart';
import 'package:shopping_app/remote/local/cache_helper.dart';
import 'package:shopping_app/remote/network/dio_helper.dart';
import 'package:shopping_app/styles/themes.dart';
import 'constants/constants.dart';
import 'modules/on_boarding_screen/on_boarding_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = await CacheHelper.getData(key: 'onBoarding');
  token = await CacheHelper.getData(key: 'token');
  Widget widget;
  if(onBoarding != null)
  {
    if(token != null)
    {
      widget = const ShopHomeLayoutScreen();
    }else
    {
      widget = const ShopLoginScreen();
    }
  }else
  {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(
    onBoarding: onBoarding,
    token: token,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  bool? onBoarding;
  String? token;
  Widget widget;
   MyApp({
    super.key,
    required this.onBoarding,
    required this.token,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (context) => ShopHomeCubit()..getHomeData()..getCategoriesData()..getFavoriteData()..getProfileData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: lightMode,
          darkTheme: darkMode,
          home: widget,
        ),
      ),
    );
  }
}
