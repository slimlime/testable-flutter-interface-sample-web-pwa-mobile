import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:testable_web_app/sample/timer/repository/ticker_data_source.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({
    required Ticker ticker,
  })   : _ticker = ticker,
        super(
          const TimerInitial(
            _duration,
          ),
        );

  final Ticker _ticker;
  static const int _duration = 60;
  StreamSubscription<int>? _tickerSubscription;

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState(
        event,
      );
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();

    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(
    TimerStarted start,
  ) async* {
    yield TimerRunInProgress(start.duration);
    // Wow so not sure if this is intended race condition.
    // Await blocking may kill the timer
    //
    // The library docs need better standards...
    // Maintainability issue
    // Does not really matter if await as we throw away the reference and
    // let it cancel whenever it wants
    await _tickerSubscription?.cancel();

    _tickerSubscription = getTickerSubscribed(_ticker, add, start);
  }
}

StreamSubscription<int>? getTickerSubscribed(
  Ticker ticker,

  /// Notifies the [Bloc] of a new [event] which triggers [mapEventToState].
  void Function(TimerEvent) mapEventToStateCallbackTriggerAddFn /* Bloc.add */,
  TimerStarted start,
) {
  final StreamSubscription<int> subscription = ticker
      .tick(
        numTicksSecondsToCountDown: start.duration,
      )
      .listen(
        (duration) => mapEventToStateCallbackTriggerAddFn(
          TimerTicked(
            duration: duration,
          ),
        ),
      );

  return subscription;
}

Stream<TimerState> fpMapTimerStartedToTimerState(
  TimerStarted startEvent,
  StreamSubscription<int> tickerSubscription,
) async* {
  yield TimerRunInProgress(
    startEvent.duration,
  );
  // ignore: unawaited_futures
  tickerSubscription.cancel();
}
