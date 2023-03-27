import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_cubit.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_states.dart';
import 'package:shopping_app/shared_components/colors.dart';

class SettingsScreen extends StatelessWidget
{
  const SettingsScreen({Key? key}) : super(key: key);
  static var emailController = TextEditingController();
  static var phoneController = TextEditingController();
  static var nameController = TextEditingController();
  static var passwordController = TextEditingController();
  static var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        emailController.text =
            ShopHomeCubit.get(context).profileModel?['data']['email'];
        nameController.text =
            ShopHomeCubit.get(context).profileModel?['data']['name'];
        phoneController.text =
            ShopHomeCubit.get(context).profileModel?['data']['phone'];
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if(state is UpdateProfileLoading || state is SignOutLoading)
                      LinearProgressIndicator(
                        color: defaultColor,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: defaultColor,
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your name ';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          label: Text('Name',style: TextStyle(color: defaultColor),),
                          prefixIcon: Icon(Icons.person,color: defaultColor,)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: phoneController,
                      cursorColor: defaultColor,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your phone';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          label: Text('Phone',style: TextStyle(color: defaultColor),),
                          prefixIcon: Icon(Icons.phone,color: defaultColor,)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email address';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: defaultColor,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          label: Text('Email Address',style: TextStyle(color: defaultColor),),
                          prefixIcon: Icon(Icons.email_outlined,color: defaultColor,)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        ShopHomeCubit.get(context).updateProfile(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      },
                      child: ConditionalBuilder(
                        condition: true,
                        builder: (context) => Container(
                          clipBehavior: Clip.antiAlias,
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          ShopHomeCubit.get(context).signOut(context);
                        }
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN OUT',
                            style: TextStyle(
                              color: Colors.white,
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
      },
    );
  }
}
