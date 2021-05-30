import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/components.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ChangeFavoriteSuccessState){
            if(!state.changeFavoritesModel.status){
              showToast(
                color: Colors.red,
                message: '${state.changeFavoritesModel.message}'
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.homeModel != null&& cubit.categoriesModel!=null,
              builder: (context) {
                return Center(
                  child: productsBuilder(cubit.homeModel,cubit.categoriesModel,context),
                );
              },
              fallback: (context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
        });
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data.banners.map((element) {
                return Image(
                  image: NetworkImage(element.image),
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              )),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                ),
                SizedBox(height: 15,),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data.dataModels[index]),
                      separatorBuilder: (context,index)=>SizedBox(width: 10,),
                      itemCount: categoriesModel.data.dataModels.length),
                ),
                SizedBox(height: 40,),
                Text(
                  'New Products',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.teal,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.5,
              children: List.generate(model.data.products.length,
                      (index) =>
                      buildGridProductItem(model.data.products[index],context)),
            ),
          )
        ],
      ),
    );
  }

  Stack buildCategoryItem(DataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
      Container(
      height: 130,
      width: 130,
      child: Image(
          image: NetworkImage(model.image),
          )),
      Container(
        width: 130,
        color: Colors.black.withOpacity(0.7),
        child: Text(
          model.name,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
      ],
    );
  }

  Widget buildGridProductItem(ProductModel model,context) {
    var isFavorite= ShopCubit.get(context).favorites[model.id];
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,
            ),
            model.discount != 0
                ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              color: Colors.red,
              child: Text(
                'Discount',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            )
                : Container(),
          ]),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, height: 1),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 15),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    model.discount != 0
                        ? Text(
                      '${model.price.round() + model.price.round() * 0.1}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough),
                    )
                        : Container(),
                    Spacer(),
                    IconButton(
                      icon: isFavorite? Icon(Icons.favorite):Icon(Icons.favorite_border),
                      onPressed: () {
                        ShopCubit.get(context).changeFavorite(model.id);
                      },
                      iconSize: 17,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
