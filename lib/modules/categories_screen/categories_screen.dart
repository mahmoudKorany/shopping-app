import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_cubit.dart';
import '../../shared_components/colors.dart';
import '../shop_home_layout/cubit/shop_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        body: ConditionalBuilder(
          condition: ShopHomeCubit.get(context).categoriesModel == null,
          builder: (context) => Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
          fallback: (context) => ListView.separated(
            itemBuilder: (context, index) => buildCategoryItem(
                ShopHomeCubit.get(context).categoriesModel?['data']['data']
                [index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: ShopHomeCubit.get(context)
                .categoriesModel?['data']['data']
                .length,
          ),
        ),
      ),
    );
  }

  Widget buildCategoryItem(Map<String, dynamic> model) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model['image']),
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              model['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:  TextStyle(
                fontFamily: 'Jannah',
                color: defaultColor,
                fontSize: 20,
              ),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: defaultColor,
          ),
        ],
      ),
    );
  }
}
