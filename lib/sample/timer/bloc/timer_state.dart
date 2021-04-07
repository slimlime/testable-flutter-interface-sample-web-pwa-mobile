part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(
    this.duration,
  );

  @override
  List<Object> get props => [];
}

class TimerReady extends TimerState {
  const TimerReady(
    int duration,
  ) : super(duration);
}
