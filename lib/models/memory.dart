class Memory {
  //lista de constante suportada pela calculadora
  static const operations = const ['%', '/', 'x', '-', '+', '='];

  String _value = '0';
  String operation;
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  bool _wipeValue = false;

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
  }

  //quando entrar no addDigit, ele vai setar
  _setOperation(String newOperation) {
    _wipeValue = true;
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
  }

  //Codigo para auto limpar
  _allClear() {
    _value = '0';
  }
}
