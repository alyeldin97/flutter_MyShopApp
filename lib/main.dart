import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/modules/on_boarding.dart';
import 'package:shop_app/shared/cubit/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/cubit/theme_cubit.dart';
import 'package:shop_app/shared/cubit/states/theme_states.dart';
import 'package:shop_app/shared/dio_helper.dart';
import 'package:shop_app/shared/network/shared_preferneces.dart';
import 'package:shop_app/shared/styles/styles.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'bloc_observer.dart';
import 'models/components.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.Init();
  await CacheHelper.init();
  Widget startScreen;
  bool onBoarding =CacheHelper.getData('onBoarding');

  /// WARNING CHANGE THIS IN LOG IN SCREEN BECAUSE IT ONLY RUNS HERE ONCE AND EVEN IF IT'S REMOVED IT'S NOT REMOVED IN RUNTIME

  token = CacheHelper.getData('token');

  /// WARNING CHANGE THIS IN LOG IN SCREEN BECAUSE IT ONLY RUNS HERE ONCE AND EVEN IF IT'S REMOVED IT'S NOT REMOVED IN RUNTIME



  if(onBoarding!= null){
    if(token!=null){
      startScreen=LayOutScreen();
    }else{
      startScreen=LoginScreen();
    }
  }else{
    startScreen=OnBoardingScreen();
  }


  runApp(MyApp(startScreen: startScreen,));
}

class MyApp extends StatelessWidget {

  Widget startScreen;
  MyApp({this.startScreen});
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData()),
        BlocProvider(create: (context)=> ThemeCubit()),

      ],
      child: BlocConsumer<ThemeCubit,ThemeStates>(
        listener: (context,state){},
        builder:(context,state
        ) {return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop App',
          home: startScreen,
          theme: lightTheme,
          darkTheme: darkTheme,

        );}
      ),
    );
  }
}
