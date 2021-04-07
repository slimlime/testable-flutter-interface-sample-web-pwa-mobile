class Ticker {
  Stream<int> tick({
    required int numTicksSecondsToCountDown,
  }) {
    const Duration oneSecond = Duration(
      seconds: 1,
    );

    final Stream<int> ticks = Stream.periodic(
      oneSecond,
      (computationCount) {
        return numTicksSecondsToCountDown - computationCount - 1;
      },
    );

    return ticks.take(numTicksSecondsToCountDown);
  }
}
