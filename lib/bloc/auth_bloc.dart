import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/useCases/user_login.dart';
import 'package:blog_app/features/auth/domain/useCases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp.call(UserSignUpParams(
      email: event.email,
      name: event.name,
      password: event.password,
    ));
    res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin
        .call(UserLoginParams(email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
  }
}
