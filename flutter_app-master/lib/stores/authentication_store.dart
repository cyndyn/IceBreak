import 'package:dartz/dartz.dart';
import 'package:icebreak/services/icebreak_api_service.dart';
import 'package:mobx/mobx.dart';

part 'authentication_store.g.dart';

enum AuthenticationState { unauthenticated, authenticating, authenticated }

class AuthenticationStore = _AuthenticationStore with _$AuthenticationStore;

abstract class _AuthenticationStore with Store {
  @observable
  String _token;

  @observable
  Exception _error;

  @observable
  bool _registered = false;

  @observable
  ObservableFuture<Either<String, Exception>> _tokenFuture;

  @computed
  String get token => _token;

  @computed
  Exception get error => _error;

  @computed
  bool get registered => _registered;

  @computed
  AuthenticationState get state {
    if (_tokenFuture == null || _tokenFuture.status == FutureStatus.rejected) {
      return AuthenticationState.unauthenticated;
    } else if (_tokenFuture.status == FutureStatus.pending) {
      return AuthenticationState.authenticating;
    } else if (_tokenFuture.status == FutureStatus.fulfilled &&
        _token != null) {
      return AuthenticationState.authenticated;
    } else {
      return AuthenticationState.unauthenticated;
    }
  }

  @action
  Future<void> login(String username, String password) async {
    _tokenFuture = ObservableFuture(
      IcebreakAPIService.login(username, password),
    );
    final result = await _tokenFuture;
    result.fold(
      (token) => _token = token,
      (error) => _error = error,
    );
  }

  @action
  Future<void> register(String username, String password) async {
    _tokenFuture = ObservableFuture(
      IcebreakAPIService.register(username, password),
    );
    final result = await _tokenFuture;
    result.fold(
      (token) {
        _registered = true;
        _token = token;
      },
      (error) {
        print(error.toString());
        _error = error;
      },
    );
  }

  @action
  void logout() {
    _tokenFuture = null;
    _error = null;
    _token = null;
    _registered = false;
  }
}
