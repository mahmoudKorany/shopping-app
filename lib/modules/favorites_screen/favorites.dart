import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_cubit.dart';
import 'package:shopping_app/shared_components/colors.dart';
import '../shop_home_layout/cubit/shop_states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        body: ConditionalBuilder(
          condition: ShopHomeCubit.get(context).favoriteModel?['data']['data'].length != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavoriteItem(
              map : ShopHomeCubit.get(context).favoriteModel?['data']['data'][index]['product'] ,
              context : context,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: ShopHomeCubit.get(context).favoriteModel?['data']['data'].length,
          ),
          fallback: (context) =>  const Center(
            child: Text(
              'NO FAVORITES YET !!',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Jannah',
                color: Colors.black
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFavoriteItem({Map<String, dynamic> ?map, required context}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Row(
              children: [
                Image(
                  image: NetworkImage(map?['image']),
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        map?['name'],
                        maxLines: 2,
                        style: const TextStyle(
                          fontFamily: 'jannah',
                          fontSize: 15,
                          height: 1.5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '${map?['price']}',
                            maxLines: 2,
                            style:  TextStyle(
                              color: defaultColor,
                              fontFamily: 'jannah',
                              fontSize: 15,
                              height: 1.5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          if (map?['discount'] != 0)
                            Text(
                              '${map?['old_price']}',
                              maxLines: 2,
                              style:  TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: defaultColor,
                                fontFamily: 'jannah',
                                fontSize: 15,
                                height: 1.5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          const Spacer(),
                          IconButton(
                            padding: const EdgeInsetsDirectional.all(0),
                            onPressed: () {
                              ShopHomeCubit.get(context).changeFavoriteIcon(
                                id: map?['id'],
                              );
                            },
                            icon: Icon(
                              ShopHomeCubit.get(context).isFavorite[map?['id']]! ? Icons.favorite : Icons.favorite_border,
                              color: defaultColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (map?['discount'] != 0)
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
