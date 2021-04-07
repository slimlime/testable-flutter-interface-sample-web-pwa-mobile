part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(
    this.duration,
  );

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {
  const TimerInitial(
    int duration,
  ) : super(duration);
}
