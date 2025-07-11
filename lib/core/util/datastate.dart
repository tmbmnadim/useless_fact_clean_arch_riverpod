abstract class DataState<T> {
  final T? _data;
  final String? _message;
  final Object? _error;

  const DataState({T? data, String? message, Object? error})
    : _data = data,
      _message = message,
      _error = error;

  T? getData({Function()? onSuccess, Function(String? error)? onFailure}) {
    if (this is DataSuccess && _data != null) {
      if (onSuccess != null) {
        onSuccess();
      }
      return _data as T;
    } else if (this is DataSuccess && _data == null) {
      if (onSuccess != null) {
        onSuccess();
      }
      return null;
    } else if (_error != null) {
      if (onFailure != null) {
        onFailure(this._message);
      }
      throw _error;
    } else {
      throw Exception("${T.runtimeType} not found");
    }
  }

  String getMessage(String placeholder) {
    return _message ?? placeholder;
  }
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String message, {super.error}) : super(message: message);
}
