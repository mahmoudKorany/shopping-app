import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/categories_screen/categories_screen.dart';
import 'package:shopping_app/modules/favorites_screen/favorites.dart';
import 'package:shopping_app/modules/home_screen/home_screen.dart';
import 'package:shopping_app/modules/settings_screen/settings_screen.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_states.dart';
import 'package:shopping_app/remote/network/dio_helper.dart';
import 'package:shopping_app/shared_components/components.dart';
import '../../../constants/constants.dart';
import '../../../remote/local/cache_helper.dart';
import '../../../remote/network/end_points.dart';
import '../../shop_login_screen/shop_login_screen.dart';

class ShopHomeCubit extends Cubit<ShopHomeStates> {
  ShopHomeCubit() : super(ShopHomeInitialState());

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  Map<String, dynamic>? homeModel;
  Map<String, dynamic>? categoriesModel;
  IconData favIcon = Icons.favorite_border;
  bool isFav = false;
  Map<int, bool> isFavorite = {};
  List<Widget> shopScreens =
  [
    const ShopHomeScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];

  void changeFavoriteIcon({
    required int id,
  }) {
    isFavorite[id] = !isFavorite[id]!;
    emit(HomeChangeFavoriteIcon());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': id},
      token: token,
      lang: 'en',
    ).then((value) {
      getFavoriteData();
      emit(HomeChangeFavoriteSuccess());
      if (!value.data['status']) {
        isFavorite[id] = !isFavorite[id]!;
      }
      showToast(msg: value.data?['message'], state: MsgState.success);
    }).catchError((error) {
      isFavorite[id] = !isFavorite[id]!;
      emit(HomeChangeFavoriteError());
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(HomeChangeBottomNavBarState());
  }

  void getHomeData() {
    emit(GetHomeDataLoading());
    DioHelper.getData(url: HOME, token: token, lang: 'en').then((value) {
      emit(GetHomeDataSuccess());
      homeModel = value.data;
      homeModel?['data']['products'].forEach((element) {
        isFavorite.addAll({element['id']: element['in_favorites']});
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetHomeDataError());
    });
  }

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, lang: 'en').then((value) {
      emit(GetCategoriesDataSuccess());
      categoriesModel = value.data;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetCategoriesDataError());
    });
  }

  Map<String, dynamic>? favoriteModel;

  void getFavoriteData() {
    emit(GetFavoriteDataLoading());
    DioHelper.getData(url: FAVORITES, token: token, lang: 'en').then((value) {
      emit(GetFavoriteDataSuccess());
      favoriteModel = value.data;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetFavoriteDataError());
    });
  }
  Map<String, dynamic>? signOutData;
  void signOut(context) {
    emit(SignOutLoading());
    DioHelper.postData(url: LOG_OUT, data: {}, token: token, lang: 'en')
        .then((value)
    {
      signOutData = value.data;
      showToast(msg: signOutData?['message'], state:MsgState.success );
      CacheHelper.removeData(key: 'token').then((value) 
      {
        emit(SignOutSuccess());
        navigateAndFinish(context: context, widget: const ShopLoginScreen());
      });
    });
  }

  Map<String, dynamic>? profileModel;

  void getProfileData() {
    emit(GetProfileHomeDataLoading());
    DioHelper.getData(url: PROFILE, token: token, lang: 'en').then((value) {
      emit(GetProfileHomeDataSuccess());
      profileModel = value.data;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetProfileHomeDataError());
    });
  }

  Map<String, dynamic>? updateModel;
  void updateProfile({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(UpdateProfileLoading());
    DioHelper.puttData(
      url: UPDATE_PROFILE,
      data:
      {
        'name' : name,
        'phone' : phone,
        'email' : email,
      },
      token: token,
      lang: 'en',
    ).then((value)
    {
      updateModel = value.data;
      if(updateModel?['status'])
      {
        showToast(msg: updateModel?['message'], state: MsgState.success);
      }else
      {
        showToast(msg: updateModel?['message'], state: MsgState.error);
      }
      emit(UpdateProfileSuccess());
      getProfileData();
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(UpdateProfileError());
    });
  }

  Map<String, dynamic>? searchModel;

  void getSearchData({
  required String search
}) {
    emit(GetSearchDataLoading());
    DioHelper.postData(url: SEARCH, token: token, lang: 'en',
        data :
        {
          'text' : search,
        }).then((value) {
      emit(GetFavoriteDataSuccess());
      searchModel = value.data;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetFavoriteDataError());
    });
  }
}
