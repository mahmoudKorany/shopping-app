import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/shop_login_screen/cubit/shop_login_cubit.dart';
import 'package:shopping_app/modules/shop_login_screen/cubit/shop_login_states.dart';
import 'package:shopping_app/shared_components/colors.dart';
import 'package:shopping_app/shared_components/components.dart';
import '../register_screen/register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {},
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                          color: defaultColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login now to browse our hot offers',
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
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email address';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        label: Text(
                          'Email Address',
                          style: TextStyle(color: defaultColor),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: defaultColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      cursorColor: defaultColor,
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          ShopLoginCubit.get(context).userLogin(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text);
                        }
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
                          onPressed: ()
                          {
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
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          ShopLoginCubit.get(context).userLogin(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      child: ConditionalBuilder(
                        condition: state is! PostDataLoading,
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
                              'LOGIN',
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                         Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: defaultColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            navigateTo(
                                context: context,
                                widget: const RegisterScreen());
                          },
                          child:  Text(
                            'Register now',
                            style: TextStyle(
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
