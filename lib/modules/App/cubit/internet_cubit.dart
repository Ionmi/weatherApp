import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> connecivityStreamSubscription;

  InternetCubit(this.connectivity) : super(InternetDisconnected()) {
    connecivityStreamSubscription = connectivity.onConnectivityChanged.listen(
        (event) => event == ConnectivityResult.none
            ? emitInternetDisconnected()
            : emitInternetConnected());
  }

  void emitInternetConnected() => emit(InternetConnected());

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connecivityStreamSubscription.cancel();
    return super.close();
  }
}
