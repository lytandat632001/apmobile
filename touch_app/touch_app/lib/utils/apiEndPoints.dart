class ApiEndPoints {
  static final String baseUrl =
      'https://jatinderji.github.io/users_pets_api/users_pets.json';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String regiserEmail = 'authaccount/registration';
  final String loginEmail = 'authaccount/login';
}
