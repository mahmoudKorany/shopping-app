import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_cubit.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_states.dart';
import 'package:shopping_app/shared_components/colors.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        body: ConditionalBuilder(
          condition: ShopHomeCubit.get(context).homeModel != null &&
              ShopHomeCubit.get(context).categoriesModel != null,
          builder: (context) => buildHome(context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHome(context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: listWidget(context),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  viewportFraction: 1,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  ShopHomeCubit.get(context).changeBottomNavBar(1);
                },
                child:  Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontFamily: 'Jannah',
                      color: defaultColor,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 100.0,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => categoriesBuilder(
                      ShopHomeCubit.get(context).categoriesModel?['data']
                          ['data'][index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemCount: ShopHomeCubit.get(context)
                      .categoriesModel?['data']['data']
                      .length,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
               Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: Text(
                  'Products',
                  style: TextStyle(
                    fontFamily: 'Jannah',
                    color: defaultColor,
                    fontSize: 25.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                color: Colors.grey,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.6,
                  children: List.generate(
                    ShopHomeCubit.get(context)
                        .homeModel?['data']['products']
                        .length,
                    (index) {
                      return productItem(
                          index: index,
                          map: ShopHomeCubit.get(context).homeModel,
                          context: context);
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  List<Widget> listWidget(context) {
    List<Widget> x = [];
    for (int index = 0;
        index < ShopHomeCubit.get(context).homeModel?['data']['banners'].length;
        index++) {
      x.add(Image(
        image: NetworkImage(ShopHomeCubit.get(context).homeModel?['data']
            ['banners'][index]['image']),
        fit: BoxFit.fill,
        width: double.infinity,
      ));
    }
    return x;
  }

  Widget categoriesBuilder(Map<String, dynamic> model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model['image']),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            model['name'],
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Jannah',
            ),
          ),
        ),
      ],
    );
  }

  Widget productItem({
    required int index,
    required Map<String, dynamic>? map,
    required context,
  }) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage(map?['data']['products'][index]['image']),
                  height: 200,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  map?['data']['products'][index]['name'],
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: 'jannah',
                    fontSize: 10.0,
                    height: 1.5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      '${map?['data']['products'][index]['price']}',
                      maxLines: 2,
                      style:  TextStyle(
                        color: defaultColor,
                        fontFamily: 'jannah',
                        fontSize: 12,
                        height: 1.5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (map?['data']['products'][index]['discount'] != 0)
                      Text(
                        '${map?['data']['products'][index]['old_price']}',
                        maxLines: 2,
                        style:  TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: defaultColor,
                          fontFamily: 'jannah',
                          fontSize: 12,
                          height: 1.5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      padding: const EdgeInsetsDirectional.all(0),
                      onPressed: () {
                        ShopHomeCubit.get(context).changeFavoriteIcon(
                          id: map?['data']['products'][index]['id'],
                        );
                      },
                      icon: Icon(
                        ShopHomeCubit.get(context).isFavorite[map?['data']['products'][index]['id']]! ? Icons.favorite : Icons.favorite_border,
                        color: defaultColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (map?['data']['products'][index]['discount'] != 0)
              Container(
                padding: const EdgeInsetsDirectional.all(5),
                color: Colors.red,
                child: const Text(
                  'Discount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Jannah',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
