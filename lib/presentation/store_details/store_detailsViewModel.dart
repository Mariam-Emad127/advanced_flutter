 import 'dart:ffi';
//import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/domain/usecase/store_details_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel implements StoreDetailsViewModelInput,StoreDetailsViewModelOutput{
    final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();
    final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);
  @override
  void start() {
   _loadData();
   }
  
  @override
   Sink get inputStoreDetails => _storeDetailsStreamController.sink;
  
  @override
   Stream<StoreDetails> get outputStoreDetails => _storeDetailsStreamController.stream.map((stores) => stores);

_loadData() async {
inputState.add(
  
  LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE  ));
(await storeDetailsUseCase.excute(Void)).fold((failure) => 
inputState.add(ErrorState(stateRendererType:  StateRendererType.FULL_SCREEN_ERROR_STATE,message: failure.message)) ,

 (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

 






@override
  void dispose() {
_storeDetailsStreamController.close();
    super.dispose();
  }

}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}

