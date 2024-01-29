import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading.tr();
  @override
  String getMessage() {
    return message ?? AppStrings.loading.tr();
  }

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({required this.stateRendererType, required this.message});

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}
// EMPTY STATE
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.POPUP_SUCCESS;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              message: getMessage(),
              retryActionFunction: retryActionFunction(),
              stateRendererType: getStateRendererType(),
            );
          }
        }
      case ErrorState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              message: getMessage(),
              retryActionFunction: retryActionFunction(),
              stateRendererType: getStateRendererType(),
            );
          }
        }
      case ContentState:
        {
        //  dismissDialog(context);

          return contentScreenWidget;
        }
      case EmptyState:
        {
          //dismissDialog(context);
          return StateRenderer(
            message: getMessage(),
            retryActionFunction: () {},
            stateRendererType: getStateRendererType(),
          );
        }
        case SuccessState:{

     //dismissDialog(context);
          return StateRenderer(
            message: getMessage(),
            retryActionFunction: () {},
            stateRendererType: getStateRendererType(),
          );


        }

      default:
        {
          return contentScreenWidget;
        }
    }
  }
}

_isThereCurrentDialogShowing(BuildContext context) {
  ModalRoute.of(context)?.isCurrent != true;
}

/* dismissDialog(BuildContext context) {
  if (_isThereCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}
 */
/* dismissDialog(BuildContext context) {
  if (context != null && _isThereCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
} */
showPopUp(
    BuildContext context, StateRendererType stateRendererType, String message) {
  WidgetsBinding.instance?.addPostFrameCallback((_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {},
          );
        });
  });
}
