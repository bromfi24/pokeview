import 'package:pokeview/model/exception/http_exception.dart';
import 'package:pokeview/presentation/common/errorhandling/app_action.dart';
import 'package:pokeview/presentation/common/errorhandling/app_error.dart';
import 'package:pokeview/presentation/common/errorhandling/base/error_bundle.dart';
import 'package:pokeview/presentation/common/errorhandling/base/error_bundle_builder.dart';
import 'package:pokeview/presentation/common/localization/localization_manager.dart';

class AuthErrorBuilder extends ErrorBundleBuilder {
  AuthErrorBuilder.create(super.exception, super.appAction) : super.create();

  @override
  ErrorBundle handle(HTTPException exception, AppAction appAction) {
    AppError appError = getDefaultAppError(exception);
    String errorMessage = getDefaultErrorMessage(exception);

    switch (exception.statusCode) {
      case 500:
        appError = AppError.SERVER;
        errorMessage = localizations.error_server;
        break;
    }

    return ErrorBundle(exception, appAction, appError, errorMessage);
  }
}
