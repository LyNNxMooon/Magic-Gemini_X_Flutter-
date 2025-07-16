import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_events.dart';
import 'package:magic_gemini_x_flutter/BLoC/auth/auth_states.dart';
import 'package:magic_gemini_x_flutter/data/vo/user_vo.dart';
import 'package:magic_gemini_x_flutter/domain/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final AuthRepo authRepo;
  StreamSubscription<User?>? _authSubscription;

  AuthBloc({required this.authRepo}) : super(AuthsInitial()) {
    on<UserLogin>(_onUserLogin);
    //on<CheckAuth>(_onCheckAuth);
    on<AuthStateChanged>(_onAuthStateChanged);
    on<UserLogout>(_onUserLogout);

    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      add(AuthStateChanged(user));
    });
  }

  Future<void> _onAuthStateChanged(
      AuthStateChanged event, Emitter<AuthStates> emit) async {
    if (event.user != null) {
      UserVO user =
          UserVO(uid: event.user!.uid, email: event.user!.email ?? "");
      emit(Authenticated(user));
    } else {
      emit(UnAuthenticated("Token Expired! Login again!"));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  // Future<void> _onCheckAuth(CheckAuth event, Emitter<AuthStates> emit) async {
  //   try {
  //     UserVO? user = await authRepo.getCurrentUser();

  //     if (user != null) {
  //       emit(Authenticated(user));
  //     } else {
  //       emit(UnAuthenticated("Unauthenticated!"));
  //     }
  //   } catch (error) {
  //     emit(UnAuthenticated('$error'));
  //   }
  // }

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

class RegisterBloc extends Bloc<AuthEvents, RegistrationStates> {
  final AuthRepo authRepo;

  RegisterBloc({required this.authRepo}) : super(RegistrationInital()) {
    on<RegisterUser>(_onUserRegister);
  }

  Future<void> _onUserRegister(
      RegisterUser event, Emitter<RegistrationStates> emit) async {
    try {
      emit(RegistrationLoading());

      if (event.password != event.confirmPassword) {
        emit(RegisterFailed("Passwords do not match!"));
      } else {
        await authRepo.registerWithEmailAndPassword(
            event.email, event.password);
        emit(RegisterSuccessful(
            "Registration successful!"));
      }
    } catch (error) {
      emit(RegisterFailed('$error'));
    }
  }
}
