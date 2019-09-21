import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:provider/provider.dart';
import 'package:ql/ramData.dart';
import 'package:ql/simulationState.dart';
import 'package:ql/constants.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Controls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final beefySwitch = BeefySwitch();
    final buttonRow = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ActionType.values
            .map((a) => ActionWidget(actionType: a))
            .map((a) => Padding(padding: EdgeInsets.all(8), child: a) as Widget)
            .toList()
              ..add(beefySwitch));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
            margin: EdgeInsets.all(3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("History Explorer"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(width: 600, child: Scrubber()),
                ),
              ],
            )),
        Card(child: buttonRow, margin: EdgeInsets.all(3)),
      ],
    );
  }
}

enum ActionType {
  RUN,
  COMPILE,
  RESTART,
  BACK,
  STOP,
  PLAY,
  PAUSE,
  FORWARD,
  NOW,
}

IconData toIcon(ActionType actionType) {
  switch (actionType) {
    case ActionType.STOP:
      return Icons.stop;
    case ActionType.PLAY:
      return Icons.play_arrow;
    case ActionType.PAUSE:
      return Icons.pause;
    case ActionType.RESTART:
      return Icons.skip_previous;
    case ActionType.COMPILE:
      return Icons.transform;
    case ActionType.RUN:
      return Icons.build;
    case ActionType.NOW:
      return Icons.skip_next;
    case ActionType.BACK:
      return Icons.chevron_left;
    case ActionType.FORWARD:
      return Icons.chevron_right;
    default:
      return Icons.ac_unit;
  }
}

class ScrubberData {
  final int value;
  final int length;
  final bool paused;

  ScrubberData(this.value, this.length, this.paused);
}

class Scrubber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    return StreamBuilder(
        stream: controller.scrubberData,
        initialData: ScrubberData(0, 0, false),
        builder: (b, d) {
          return Slider(
            value: d.data.value,
            onChanged: d.data.length > 1 ? controller.scrubberChanged : null,
            onChangeStart: (_) => controller.pause(),
            min: 0,
            max: max(d.data.length - 1.0, 1.0),
            divisions: max(1, d.data.length),
          );
        });
  }
}

class ActionWidget extends StatelessWidget {
  final ActionType actionType;

  const ActionWidget({Key key, this.actionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(toIcon(actionType));
    final onPressed =
        () => Provider.of<Controller>(context).actionType.add(actionType);
    final _description = description(actionType);
    if (_description != null) {
      return RaisedButton.icon(
          onPressed: onPressed, icon: icon, label: Text(_description));
    } else {
      return IconButton(
        onPressed: onPressed,
        icon: icon,
      );
    }
  }
}

String description(ActionType actionType) {
  switch (actionType) {
    case ActionType.COMPILE:
      return "Compile";
    case ActionType.RUN:
      return "Run";
    default:
      return null;
  }
}

class BeefySwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<Controller>(
      builder: (a, b, c) => StreamBuilder<bool>(
          stream: b.beefy,
          initialData: false,
          builder: (c, s) => Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Text("Beefy Mode"),
                  Switch(
                    value: s.data,
                    onChanged: (v) {
                      b.beefyUpdate(v);
                    },
                  ),
                ],
              ))));
}

class Controller with ChangeNotifier {
  final slider = StreamController<double>();
  final beefyController = StreamController<bool>();
  final actionTypeController = StreamController<ActionType>();
  final simulationController = StreamController<SimulationState>();
  final compiledController = StreamController<String>();
  final programController = StreamController<String>();
  final scrubberDataController = StreamController<ScrubberData>();

  final BuildContext context;

  String _program = "";

  bool _beefy = false;

  List<SimulationState> _history = [];
  bool _paused = false;
  int _step = 0;

  Stream<ScrubberData> _scrubberDataValue;

  Stream<bool> _beefyValue;

  Stream<SimulationState> _simulations;

  Stream<String> _compiled;

  Socket socket;

  Stream<bool> get beefy =>
      _beefyValue ??= beefyController.stream.asBroadcastStream();
  Sink<ActionType> get actionType => actionTypeController.sink;
  Stream<SimulationState> get simulations =>
      _simulations ??= simulationController.stream.asBroadcastStream();
  Stream<String> get compiled =>
      _compiled ??= compiledController.stream.asBroadcastStream();
  Stream<ScrubberData> get scrubberData =>
      _scrubberDataValue ??= scrubberDataController.stream.asBroadcastStream();

  Controller(this.context) : super() {
    actionTypeController.stream.listen(actionTypeCame);
  }

  ScrubberData get _scrubberData =>
      ScrubberData(_step, _history.length, _paused);

  @override
  void dispose() {
    beefyController.close();
    actionTypeController.close();
    simulationController.close();
    programController.close();
    compiledController.close();
    scrubberDataController.close();
    super.dispose();
  }

  void compile() async {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Compiling program')));
    final response = await BrowserClient().post(parseAddress,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"program": _program}));
    Scaffold.of(context).hideCurrentSnackBar();
    final result = RamData.fromJson({"data": json.decode(response.body)});
    final compiledText = result.data.map((f) => f.join()).join("\n");
    compiledController.add(compiledText);
  }

  void beefyUpdate(bool v) {
    _beefy = v;
    beefyController.add(v);
  }

  void actionTypeCame(ActionType event) {
    switch (event) {
      case ActionType.PAUSE:
        pause();
        return;
      case ActionType.PLAY:
        play();
        return;
      case ActionType.STOP:
        stop();
        return;
      case ActionType.RESTART:
        restart();
        return;
      case ActionType.RUN:
        run();
        return;
      case ActionType.COMPILE:
        compile();
        return;
      case ActionType.NOW:
        now();
        return;
      case ActionType.BACK:
        back();
        return;
      case ActionType.FORWARD:
        forward();
        return;
      default:
        return;
    }
  }

  void pause() {
    _paused = true;
    timer?.cancel();
    socket?.emit('pause');
    updateScrubberState();
  }

  Timer timer;

  void play() {
    if (socket == null) {
      run();
      return;
    }
    resetTimer();
    _paused = false;
    updateScrubberState();
    socket?.emit('resume');
  }

  void stop() {
    reset();
  }

  void restart() {
    pause();
    _step = 0;
    addCurrentSim();
    updateScrubberState();
  }

  void addCurrentSim() {
    simulationController.add(_history[_step]);
    updateScrubberState();
  }

  void run() async {
    reset();
    await compile();
    build();
  }

  void reset() {
    timer?.cancel();
    _paused = false;
    socket?.disconnect();
    socket = null;
    _history = [];
    _step = 0;
    simulationController.add(SimulationState.empty());
    updateScrubberState();
  }

  void updateScrubberState() {
    scrubberDataController.add(_scrubberData);
  }

  void programUpdated(String program) {
    this._program = program;
  }

  void scrubberChanged(double value) {
    _step = value.floor();
    updateScrubberState();
    addCurrentSim();
  }

  void build() {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Building Simulation')));
    socket?.disconnect();
    socket = io(socketAddress);
    socket.on('connect', (data) {
      socket.emit('json', json.encode({"program": _program, "beefy": _beefy}));
      play();
    });
    socket.on('json', (data) {
      Scaffold.of(context).hideCurrentSnackBar();
      final states =
          List.of(data).map((d) => SimulationState.fromJson(d)).toList();
      _history.addAll(states);
      updateScrubberState();
    });
  }

  void resetTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 4), onTick);
  }

  bool maybeIncrementStep({int stepSize = 1}) {
    if (_step >= _history.length - stepSize) {
      return false;
    }
    _step += stepSize;
    return true;
  }

  bool maybeDecrementStep() {
    if (_step == 0) {
      return false;
    }
    _step--;
    return true;
  }

  void now() {
    _step = _history.length - 1;
    play();
  }

  void back() {
    maybeDecrementStep() ? addCurrentSim() : null;
  }

  void forward({int stepSize = 1}) {
    maybeIncrementStep(stepSize: stepSize) ? addCurrentSim() : null;
  }

  void onTick(Timer timer) {
    if (_paused) {
      return;
    }
    forward(stepSize: 3);
  }
}
