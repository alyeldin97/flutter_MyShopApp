import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/components.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/modules/search_screen.dart';
import 'package:shop_app/shared/cubit/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';
import 'package:shop_app/shared/network/shared_preferneces.dart';

class LayOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state){
        var cubit= ShopCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text('سلة...'),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: (){
              navigateTo(context, SearchScreen());
            })
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index){
            cubit.changeBottom(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
          ],
        ),
      );}
    );
  }
}
