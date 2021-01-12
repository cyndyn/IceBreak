import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:icebreak/services/icebreak_api_service.dart';
import 'package:mobx/mobx.dart';

part 'create_profile_store.g.dart';

class CreateProfileStore = _CreateProfileStore with _$CreateProfileStore;

abstract class _CreateProfileStore with Store {
  @observable
  int _id;

  @observable
  Exception _error;

  @observable
  ObservableFuture<Either<int, Exception>> _idFuture;

  @observable
  String name;

  @observable
  DateTime birthday = DateTime.now();

  @observable
  Gender gender = Gender.female;

  @observable
  Gender interestedIn = Gender.female;

  @observable
  String bio;

  @observable
  Position location;

  @observable
  double searchArea = 50;

  @observable
  RangeValues ageRange = RangeValues(18, 69);

  @observable
  CreateAccountPage _page = CreateAccountPage.nameBirthdayBio;

  @computed
  CreateAccountPage get page => _page;

  @computed
  int get id => _id;

  @computed
  Exception get error => _error;

  @computed
  bool get createdProfile => id != null;

  @action
  void goToPage(CreateAccountPage page) => _page = page;

  @action
  Future<void> createAccount(String token) async {
    // TODO: Validate input before creating account
    final Map<String, double> locationMap = {
      "lng": location.longitude,
      "lat": location.latitude
    };
    _idFuture = ObservableFuture(
      IcebreakAPIService.createProfile(
        token,
        name,
        birthday.toIso8601String().split('T')[0],
        locationMap,
        bio,
        gender.genderToString(),
        interestedIn.genderToString(),
        searchArea.round(),
        ageRange.start.round(),
        ageRange.end.round(),
      ),
    );
    final result = await _idFuture;
    result.fold(
      (id) {
        _id = id;
      },
      (error) {
        print(error.toString());
        _error = error;
      },
    );
  }
}

enum CreateAccountPage { nameBirthdayBio, gender, location }

enum Gender { male, female, nonBinary, other }

extension GenderExtension on Gender {
  String genderToString() {
    switch (this) {
      case Gender.female:
        return 'FEMALE';
      case Gender.male:
        return 'MALE';
      case Gender.nonBinary:
        return 'NB';
      default:
        return "OTHER";
    }
  }
}
