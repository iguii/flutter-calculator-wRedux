import '../actions.dart';
import '../reducer.dart';

AppState editHandler(AppState previousState, dynamic action) {
  switch (action) {
    case Edit.AC:
      return  AppState(
          currentNumber: 0,
          operacion: "",
          current: "",
          operations: previousState.operations);
    case Edit.Backspace:
      String previousOperacion = previousState.operacion;
      if (previousOperacion.length <= 1) {
        //TODO FIX
        return AppState(
            currentNumber: 0,
            operacion: previousOperacion,
            current: "",
            operations: previousState.operations);
      }
      return AppState(
          currentNumber: num.parse(
              previousOperacion.substring(0, previousOperacion.length - 1)),
          operacion:
              previousOperacion.substring(0, previousOperacion.length - 1),
          current: previousOperacion.substring(0, previousOperacion.length - 1),
          operations: previousState.operations);
  }
  return previousState;
}