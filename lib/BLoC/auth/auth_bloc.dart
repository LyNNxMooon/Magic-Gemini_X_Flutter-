import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_states.dart';
import 'package:magic_gemini_x_flutter/data/vo/user_vo.dart';
import 'package:magic_gemini_x_flutter/domain/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(AuthsInitial()) {
    on<UserLogin>(_onUserLogin);
    on<CheckAuth>(_onCheckAuth);
    on<UserLogout>(_onUserLogout);
  }

  Future<void> _onCheckAuth(CheckAuth event, Emitter<AuthStates> emit) async {
    try {
      UserVO? user = await authRepo.getCurrentUser();

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated("Unauthenticated!"));
      }
    } catch (error) {
      emit(UnAuthenticated('$error'));
    }
  }

  Future<void> _onUserLogin(UserLogin event, Emitter<AuthStates> emit) async {
    try {
      emit(AuthLoading());

      await authRepo
          .loginWithEmailAndPassword(event.email, event.password)
          .then(
        (value) {
          emit(Authenticated(value!));
        },
      );
    } catch (error) {
      emit(UnAuthenticated('$error'));
    }
  }

   Future<void> _onUserLogout(UserLogout event, Emitter<AuthStates> emit) async {
    try {

      emit(AuthLoading());

      await authRepo.logout();
      emit(UnAuthenticated("Successfully Logged out!"));
          
    } catch (error) {
      emit(UnAuthenticated('$error'));
    }
  }
}
