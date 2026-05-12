class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException([this.message = 'Unauthorized']);
}
