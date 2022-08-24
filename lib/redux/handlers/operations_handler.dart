import '../../db/helper.dart';
import '../../model/operation.dart';
import '../reducer.dart';
import '../actions.dart';

AppState operationsHandler(AppState previousState, dynamic action) {
  List<dynamic> newOperations = previousState.operations;
  dynamic operationChar;
  switch (action) {
    case Operations.Sum:
      operationChar = '+';
      break;
    case Operations.Substract:
      operationChar = '-';
      break;
    case Operations.Multiply:
      operationChar = 'x';
      break;
    case Operations.Divide:
      operationChar = '/';
      break;
    case Operations.Equal:
      // sacar resultados
      newOperations.add(previousState
          .currentNumber); // se asegura de que el ultimo numero se incluya

      String result = _operate(newOperations).toString();
      addToHistory(previousState.operacion, result);

      return AppState(
          currentNumber: 0,
          operacion: previousState.operacion,
          current: "",
          operations: const [],
          result: result);
  }

  newOperations.addAll([previousState.currentNumber, operationChar]);

  return AppState(
      currentNumber: 0,
      operacion: "${previousState.operacion}$operationChar",
      current: "",
      operations: newOperations);
}

dynamic _operate(List<dynamic> operations) {
  dynamic result = operations[0];
  for (int i = 1; i < operations.length; i += 2) {
    if (operations[i].runtimeType == String) {
      switch (operations[i]) {
        case "+":
          result += operations[i + 1];
          break;
        case "-":
          result -= operations[i + 1];
          break;
        case "x":
          result *= operations[i + 1];
          break;
        case "/":
          result /= operations[i + 1];
          break;
        default:
          result += 0;
      }
    }
  }

  if (result.runtimeType == double) {
    result = double.parse(result.toString()).toStringAsFixed(4);
  }
  return result;
}

void addToHistory(String operation, String result) async {
  await DatabaseHelper.instance
      .add(Operation(operation: operation, result: result));
}
