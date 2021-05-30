import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: state is! ChangeGetFavoriteLoadingState ,
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
            builder:(context)=> buildFavoriteItem(cubit.favoritesModel));
      },
    );
  }

  Widget buildFavoriteItem(FavoritesModel model) {
    return ListView.builder(
      itemCount: model.data.data.length,
      itemBuilder: (context,index){
        var currentItem = model.data.data[index].product;
        var currentId = model.data.data[index].id;
        return Container(
          height: 180,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                Image(
                  width: 170.0,height: 170.0,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      currentItem.image),
                ),
                    Container(
                      height: 20,
                      width: 80,
                      color: Colors.red,
                      child: Text('Discount',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                    ),
              ]),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(currentItem.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Spacer(),
                    Row(children: [
                      Text('${currentItem.price}',style:TextStyle(color:Colors.teal,fontSize: 17,fontWeight: FontWeight.bold),),
                      SizedBox(width: 4,),
                      Text('${currentItem.oldPrice}',style:TextStyle(color:Colors.grey,fontSize: 10,fontWeight: FontWeight.bold)),
                      Spacer(),
                      IconButton(icon:ShopCubit.get(context).favorites[currentItem.id]? Icon(Icons.favorite):Icon(Icons.favorite_border), onPressed: (){
                        ShopCubit.get(context).changeFavorite(currentItem.id);
                      }),
                    ],),
                  ],
                ),
              ),
            ],
          ),
        );}
    );
  }
}
