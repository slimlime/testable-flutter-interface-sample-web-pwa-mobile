import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:testable_web_app/sample/timer/repository/ticker_data_source.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 60;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc(
    Ticker ticker,
  )   : _ticker = ticker,
        super(
          const TimerReady(
            _duration,
          ),
        );

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();

    return super.close();
  }
}
