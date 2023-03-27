import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_cubit.dart';
import 'package:shopping_app/shared_components/colors.dart';
import '../shop_home_layout/cubit/shop_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static var searchController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  cursorColor: defaultColor,
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter text';
                    } else {
                      return null;
                    }
                  },
                  onFieldSubmitted: (value) {
                    ShopHomeCubit.get(context).getSearchData(
                      search: value,
                    );
                  },
                  onChanged: (value) {
                    ShopHomeCubit.get(context).getSearchData(
                      search: value,
                    );
                  },
                  decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      label: Text('Search',style: TextStyle(color: defaultColor),),
                      prefixIcon: Icon(Icons.email_outlined,color: defaultColor,)),
                ),
                const SizedBox(
                  height: 10,
                ),
                if(state is GetSearchDataLoading)
                   LinearProgressIndicator(
                    color: defaultColor,
                  ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: ShopHomeCubit.get(context).searchModel?['data']['data'].length != null,
                    builder: (context)=> ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildSearchItem(
                          ShopHomeCubit.get(context).searchModel?['data']
                          ['data'][index],
                          context),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: ShopHomeCubit.get(context)
                          .searchModel?['data']['data']
                          .length,
                    ),
                    fallback: (context) => Center(
                      child: Text(
                        'NO SEARCH YET !!' ,
                        style: TextStyle(
                          color: defaultColor,
                          fontFamily: 'Jannah',
                          fontSize: 20,
                        ),

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchItem(Map<String, dynamic>? model, context) {
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
                  image: NetworkImage(model?['image']),
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
                        model?['name'],
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
                            '${model?['price']}',
                            maxLines: 2,
                            style:TextStyle(
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
                          const Spacer(),
                          IconButton(
                            padding: const EdgeInsetsDirectional.all(0),
                            onPressed: () {
                              ShopHomeCubit.get(context).changeFavoriteIcon(
                                id: model?['id'],
                              );
                            },
                            icon: Icon(
                              ShopHomeCubit.get(context)
                                      .isFavorite[model?['id']]!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
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
          ],
        ),
      ),
    );
  }
}
