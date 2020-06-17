import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 25.0) {
        _infoText = "Peso normal (${imc.toStringAsPrecision(3)})";
      } else if (imc < 30) {
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      } else if (imc <= 35) {
        _infoText = "Obesidade I (${imc.toStringAsPrecision(3)})";
      } else if (imc <= 40) {
        _infoText = "Obesidade II. (${imc.toStringAsPrecision(3)})";
      } else if (imc <= 45) {
        _infoText = "Obesidade III. (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.teal[300],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_pin, size: 120.0, color: Colors.teal[300]),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (KG)",
                    labelStyle: TextStyle(color: Colors.teal[300]),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal[300], fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (CM)",
                    labelStyle: TextStyle(color: Colors.teal[300]),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal[300], fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Precisa de uma altura";
                    }
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.teal[300],
                      ),
                    )),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal[300], fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
