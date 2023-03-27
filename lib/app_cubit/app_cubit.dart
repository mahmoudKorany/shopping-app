import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


}