import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_cubit.dart';
import 'package:shopping_app/modules/shop_login_screen/cubit/shop_login_states.dart';
import 'package:shopping_app/remote/network/dio_helper.dart';
import '../../../constants/constants.dart';
import '../../../remote/local/cache_helper.dart';
import '../../../remote/network/end_points.dart';
import '../../../shared_components/components.dart';
import '../../shop_home_layout/shop_layout.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isObscure = true;
  IconData suffixIcon = Icons.visibility;
  Map<String, dynamic>? loginModel;
  Map<String, dynamic>? registerModel;

  void changeSuffixIcon() {
    if (isObscure) {
      isObscure = !isObscure;
      suffixIcon = Icons.visibility_off;
    } else {
      isObscure = !isObscure;
      suffixIcon = Icons.visibility;
    }
    emit(ChangeSuffixIcon());
  }

  void userLogin({
    required String email,
    required String password,
    required context,
  }) {
    emit(PostDataLoading());
    DioHelper.postData(
            url: LOGIN,
            data: {'email': email, 'password': password},
            lang: 'en').then((value) async
    {
      loginModel = value.data;
      emit(PostDataSuccess(loginModel!));
      if (loginModel?['status'])
      {
        await CacheHelper.saveData(
          key: 'token',
          value: loginModel?['data']['token'],
        ).then((value) async {
          token = await CacheHelper.getData(key: 'token');
        }).then((value) {
          ShopHomeCubit.get(context).getProfileData();
        });
        navigateAndFinish(
            context: context, widget: const ShopHomeLayoutScreen());
        showToast(
          msg: loginModel?['message'],
          state: MsgState.success,
        );
      }else if(loginModel?['status'] == false)
      {
        showToast(
          msg: loginModel?['message'],
          state: MsgState.error,
        );
      }
    }).catchError((error) {
      emit(PostDataError(error: error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    required context,
  }) {
    emit(PostRegisterDataLoading());
    DioHelper.postData(
            url: REGISTER,
            data: {
              'email': email,
              'password': password,
              'name': name,
              'phone': phone,
            },
            lang: 'en')
        .then((value) {
      emit(PostRegisterDataSuccess());
      registerModel = value.data;
      ShopHomeCubit.get(context).getProfileData();
      ShopHomeCubit.get(context).getFavoriteData();
    }).catchError((error) {
      emit(PostRegisterDataError(error: error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
