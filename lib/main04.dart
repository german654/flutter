// =============================================================================
// ARCHIVO: main.dart
// =============================================================================
// DESCRIPCIÓN:
// Este archivo implementa una aplicación Flutter que muestra diferentes widgets
// de entrada como Checkbox, Switch, RadioButton, Slider y DropdownButton.
// Demuestra la gestión de estado y manejo de eventos para cada tipo de control.
//
// AUTOR: German
// FECHA CREACIÓN: 22 de octubre de 2024
// ÚLTIMA MODIFICACIÓN: 24 de octubre de 2024
// =============================================================================

import 'package:flutter/material.dart';

// =============================================================================
// PUNTO DE ENTRADA DE LA APLICACIÓN
// =============================================================================
void main() {
  runApp(const InputWidgetsApp());
}

// =============================================================================
// WIDGET PRINCIPAL DE LA APLICACIÓN
// =============================================================================
class InputWidgetsApp extends StatelessWidget {
  const InputWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets de Entrada Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const InputWidgets(),
    );
  }
}

// =============================================================================
// WIDGET PRINCIPAL DE CONTROLES DE ENTRADA
// =============================================================================
class InputWidgets extends StatefulWidget {
  const InputWidgets({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputWidgetsState createState() => _InputWidgetsState();
}

// =============================================================================
// ESTADO DEL WIDGET DE CONTROLES DE ENTRADA
// =============================================================================
class _InputWidgetsState extends State<InputWidgets> {
  // =============================================================================
  // VARIABLES DE ESTADO Y CONFIGURACIÓN
  // =============================================================================

  // Estados de los controles
  bool _isChecked = false;
  bool _switchValue = false;
  int _selectedValue = 1;
  double _sliderValue = 20.0;
  String? _dropdownSelectedValue;

  // Configuraciones
  static const double _padding = 16.0;
  static const int _sliderDivisions = 10;
  static const double _sliderMin = 0.0;
  static const double _sliderMax = 100.0;

  // Lista de opciones para el DropdownButton
  final List<Map<String, String>> _dropdownItems = [
    {'label': 'Opción A', 'value': '1'},
    {'label': 'Opción B', 'value': '2'},
    {'label': 'Opción C', 'value': '3'},
  ];

  // =============================================================================
  // MÉTODOS PARA CONSTRUIR WIDGETS
  // =============================================================================

  /// Construye el widget Checkbox con su etiqueta
  Widget _buildCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
            debugPrint('Checkbox: $_isChecked');
          },
        ),
        const Text('Acepto los términos y condiciones'),
      ],
    );
  }

  /// Construye el widget Switch con su título
  Widget _buildSwitch() {
    return SwitchListTile(
      title: const Text('Habilitar opción'),
      value: _switchValue,
      onChanged: (bool value) {
        setState(() {
          _switchValue = value;
        });
        debugPrint('Switch: $_switchValue');
      },
    );
  }

  /// Construye el grupo de RadioButtons
  Widget _buildRadioButtons() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text('Seleccione una opción:',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        _buildRadioOption(1, 'Opción 1'),
        _buildRadioOption(2, 'Opción 2'),
      ],
    );
  }

  /// Construye una opción individual del RadioButton
  Widget _buildRadioOption(int value, String title) {
    return ListTile(
      title: Text(title),
      leading: Radio<int>(
        value: value,
        groupValue: _selectedValue,
        onChanged: (int? value) {
          setState(() {
            _selectedValue = value!;
          });
          debugPrint('Radio seleccionado: $_selectedValue');
        },
      ),
    );
  }

  /// Construye el widget Slider con su etiqueta de valor
  Widget _buildSlider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          value: _sliderValue,
          min: _sliderMin,
          max: _sliderMax,
          divisions: _sliderDivisions,
          label: _sliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _sliderValue = value;
            });
            debugPrint('Slider valor: $_sliderValue');
          },
        ),
        Text('Valor seleccionado: ${_sliderValue.round()}'),
      ],
    );
  }

  /// Construye el widget DropdownButton
  Widget _buildDropdown() {
    return DropdownButton<String>(
      value: _dropdownSelectedValue,
      hint: const Text('Seleccione una opción'),
      isExpanded: true,
      items: _dropdownItems.map((item) {
        return DropdownMenuItem<String>(
          value: item['value'],
          child: Text(item['label']!),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _dropdownSelectedValue = newValue!;
        });
        debugPrint('Dropdown valor: $_dropdownSelectedValue');
      },
    );
  }

  // =============================================================================
  // CONSTRUCCIÓN PRINCIPAL DEL WIDGET
  // =============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets de Entrada'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sección de Checkbox
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildCheckbox(),
                ),
              ),

              // Sección de Switch
              Card(
                child: _buildSwitch(),
              ),

              // Sección de RadioButtons
              Card(
                child: _buildRadioButtons(),
              ),

              // Sección de Slider
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildSlider(),
                ),
              ),

              // Sección de DropdownButton
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildDropdown(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
