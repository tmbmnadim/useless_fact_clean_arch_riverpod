abstract class DataState<T> {
  final T? data;
  final String? message;
  final Object? error;

  const DataState({this.data, this.message, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String message, {super.error}) : super(message: message);
}
