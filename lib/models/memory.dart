class Memory {
  //lista de constante suportada pela calculadora
  static const operations = const ['%', '/', 'x', '-', '+', '='];

  String _value = '0';
  String _operation;
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  bool _wipeValue = false;
  String _lastCommand;

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (_isReplacingOperation(command)) {
      _operation = command;
      return;
    }

    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
    _lastCommand = command;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != '=' &&
        command != '=';
  }

  //quando entrar no addDigit, ele vai setar
  _setOperation(String newOperation) {
    bool isEqualSign = newOperation == '=';

    if (_bufferIndex == 0) {
      if (!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeValue = true;
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }
    //se quiser limapr o valor após apertar '=', descomenta
    _wipeValue = true; //!isEqualSign;
  }

  _addDigit(String digit) {
    final isDot = digit == '.';
    //codigo para tirar o 0 da frente de outros valores e implementação do 0. / Limiando o .
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    if (isDot && _value.contains('.') && !wipeValue) {
      return;
    }

    final emptyValue = isDot ? '0' : '';

    //se o valor tiver setado ele vai mostrar vazio, caso contrario ele usa o valor atual
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    //caso nao seja um valor double valido, ele zera.
    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
    //print(_buffer);
  }

  //Codigo para auto limpar
  _allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _operation = null;
    _wipeValue = false;
  }

  _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];

      default:
        return _buffer[0];
    }
  }
}
