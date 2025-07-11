class MoodProviderManager {}

enum ControllerStateStatus {
  initial,
  loading,
  success,
  failure,
  created,
  updated;

  String toName() {
    switch (this) {
      case initial:
        return "INITIAL";
      case ControllerStateStatus.loading:
        return "LOADING";
      case ControllerStateStatus.success:
        return "SUCCESS";
      case ControllerStateStatus.failure:
        return "FAILURE";
      case ControllerStateStatus.created:
        return "CREATED";
      case ControllerStateStatus.updated:
        return "UPDATED";
    }
  }

  ControllerStateStatus fromString(String value) {
    switch (value) {
      case "INITIAL":
      case "initial":
        return ControllerStateStatus.initial;
      case "LOADING":
      case "loading":
        return ControllerStateStatus.loading;
      case "SUCCESS":
      case "success":
        return ControllerStateStatus.success;
      case "FAILURE":
      case "failure":
        return ControllerStateStatus.failure;
      case "CREATED":
      case "created":
        return ControllerStateStatus.created;
      case "UPDATED":
      case "updated":
        return ControllerStateStatus.updated;
      default:
        throw Exception("Status $value not found!");
    }
  }
}
