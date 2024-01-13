 import 'dart:async';
import 'package:advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs implements BaseViewModelOutputs{
final StreamController _inputStateStreamController=StreamController<FlowState>.broadcast();

@override
   Sink get inputState => _inputStateStreamController.sink;
@override
   Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);
@override
  void dispose() {
   _inputStateStreamController.close();
  }

}

abstract class BaseViewModelInputs {
void start ();

void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs { 
Stream <FlowState>get outputState;
}