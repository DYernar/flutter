import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaz_latin/feature/auth/bloc/bloc.dart';
import 'package:qaz_latin/feature/signin/bloc/signin_event.dart';
import 'package:qaz_latin/feature/signin/bloc/signin_state.dart';
import 'package:qaz_latin/model/user_repository.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;

  SigninBloc(this._authBloc, this._userRepository) : super(ShowLoginButton());

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is SigninWithGoogleButtonPressed) {
      yield SignInLoading();
      if (await _userRepository.signInWithGoogle() == null) {
        yield SigninError();
        _authBloc.add(LoggedOutEvent());
      } else {
        _authBloc.add(LoggedInEvent());
      }
    }
  }
}
