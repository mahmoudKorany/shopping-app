import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_cubit.dart';
import 'package:shopping_app/shared_components/colors.dart';
import '../../remote/local/cache_helper.dart';
import '../../shared_components/components.dart';
import '../shop_home_layout/shop_layout.dart';
import '../shop_login_screen/cubit/shop_login_cubit.dart';
import '../shop_login_screen/cubit/shop_login_states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static var emailController = TextEditingController();
  static var phoneController = TextEditingController();
  static var nameController = TextEditingController();
  static var passwordController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is PostRegisterDataSuccess) {
          if (ShopLoginCubit.get(context).registerModel?['status']) {
            ShopHomeCubit.get(context).getFavoriteData();
            ShopHomeCubit.get(context).getProfileData();
            CacheHelper.saveData(
              key: 'token',
              value: ShopLoginCubit.get(context).registerModel?['data']
                  ['token'],
            ).then((value) {
              navigateAndFinish(
                  context: context, widget: const ShopHomeLayoutScreen());
            });
            showToast(
              msg: ShopLoginCubit.get(context).registerModel?['message'],
              state: MsgState.success,
            );
          } else {
            showToast(
              msg: ShopLoginCubit.get(context).registerModel?['message'],
              state: MsgState.error,
            );
          }
        }
      },
      builder: (context, state) => Expanded(
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                     Text('Register',
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      'Register now to browse our hot offers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: defaultColor.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
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
                      cursorColor: defaultColor,
                      controller: phoneController,
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
                      cursorColor: defaultColor,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email address';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration:  InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          label: Text('Email Address',style: TextStyle(color: defaultColor),),
                          prefixIcon: Icon(Icons.email_outlined,color: defaultColor,)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      cursorColor: defaultColor,
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email address';
                        } else {
                          return null;
                        }
                      },
                      obscureText: ShopLoginCubit.get(context).isObscure,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        label:  Text('Password',style: TextStyle(color: defaultColor),),
                        prefixIcon:  Icon(
                          Icons.lock_outline_rounded,
                          color: defaultColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            ShopLoginCubit.get(context).changeSuffixIcon();
                          },
                          icon: Icon(
                            ShopLoginCubit.get(context).suffixIcon,
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          ShopLoginCubit.get(context).userRegister(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      child: ConditionalBuilder(
                        condition: state is! PostRegisterDataLoading,
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
                              'REGISTER',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator(
                              color: defaultColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
