import 'package:qaz_latin/feature/auth/bloc/auth_event.dart';
import 'package:qaz_latin/feature/auth/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:qaz_latin/model/user_repository.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(null);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartedEvent) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedInEvent) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOutEvent) {
      print("event fired");
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      yield LoadingState();
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final u = await _userRepository.getUser();
        if (u.email == null) {
          yield UnauthenticatedState();
          return;
        }
        yield AuthenticatedState(u);
      } else {
        yield UnauthenticatedState();
      }
    } catch (_) {
      yield UnauthenticatedState();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    yield AuthenticatedState(await _userRepository.getUser());
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield UnauthenticatedState();
    print("signing out");
    _userRepository.signOut();
  }
}
