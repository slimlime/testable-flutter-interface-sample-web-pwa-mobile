part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(
    this.duration,
  );

  @override
  List<Object> get props {
    return [
      duration,
    ];
  }
}

/// Initial state.
/// Ready to start counting down
class TimerInitial extends TimerState {
  const TimerInitial(
    int duration,
  ) : super(duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

/// Currently running.
/// Can pause and reset.
/// See duration
class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(
    int duration,
  ) : super(duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

/// Timer paused during an active countdown run
/// Can be reset or unpaused(resumed)
class TimerRunPause extends TimerState {
  const TimerRunPause(
    int duration,
  ) : super(duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

/// Done. Can reset
class TimerRunCompleteResettable extends TimerState {
  const TimerRunCompleteResettable() : super(0);

  @override
  String toString() => 'TimerRunCompleteResettable { duration: 0 }';
}
