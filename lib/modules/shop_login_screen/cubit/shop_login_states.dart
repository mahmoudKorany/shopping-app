abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ChangeSuffixIcon extends ShopLoginStates {}

class PostDataLoading extends ShopLoginStates {}

class PostDataSuccess extends ShopLoginStates
{
  final Map<String,dynamic> loginModel ;
  PostDataSuccess(this.loginModel);
}

class PostDataError extends ShopLoginStates
{
  final String error;
  PostDataError({required this.error});
}

class PostRegisterDataLoading extends ShopLoginStates {}

class PostRegisterDataSuccess extends ShopLoginStates {}

class PostRegisterDataError extends ShopLoginStates
{
  final String error;
  PostRegisterDataError({required this.error});
}


