import 'package:pokeview/presentation/common/errorhandling/base/error_bundle.dart';

enum Status { IDLE, LOADING, SUCCESS, ERROR }

class ResourceState {
  Status status;
  dynamic data;
  ErrorBundle? error;

  ResourceState(this.status, this.data, this.error);

  ResourceState.idle() : status = Status.IDLE;

  ResourceState.loading() : status = Status.LOADING;

  ResourceState.success(this.data) : status = Status.SUCCESS;

  ResourceState.error(this.error) : status = Status.ERROR;
}
