import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states/theme_states.dart';

class ThemeCubit extends Cubit<ThemeStates>{
  ThemeCubit():super(ThemeInitialState());

  static ThemeCubit get(context){
    return BlocProvider.of(context);
  }
}