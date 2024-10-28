// =============================================================================
// ARCHIVO: main.dart
// =============================================================================
// DESCRIPCIÓN:
// Este archivo implementa una aplicación Flutter que demuestra diferentes tipos
// de layouts y widgets de construcción de interfaz, incluyendo Container, Row,
// Column, Stack, Padding, Center, Expanded, y DropdownButton.
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
  runApp(const LayoutDemoApp());
}

// =============================================================================
// WIDGET PRINCIPAL DE LA APLICACIÓN
// =============================================================================
class LayoutDemoApp extends StatelessWidget {
  const LayoutDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LayoutDemo(),
    );
  }
}

// =============================================================================
// WIDGET PRINCIPAL DE DEMOSTRACIÓN DE LAYOUTS
// =============================================================================
class LayoutDemo extends StatefulWidget {
  const LayoutDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LayoutDemoState createState() => _LayoutDemoState();
}

class _LayoutDemoState extends State<LayoutDemo> {
  // =============================================================================
  // VARIABLES DE ESTADO Y CONFIGURACIÓN
  // =============================================================================

  // Configuración del DropdownButton
  final List<Map<String, String>> _dropdownItems = [
    {'label': 'Opción A', 'value': '1'},
    {'label': 'Opción B', 'value': '2'},
    {'label': 'Opción C', 'value': '3'},
  ];
  String? _selectedValue;

  // Constantes de diseño
  static const double _padding = 16.0;
  static const double _boxSize = 50.0;
  static const double _containerWidth = 200.0;
  static const double _containerHeight = 100.0;

  // =============================================================================
  // MÉTODOS PARA CONSTRUIR WIDGETS
  // =============================================================================

  /// Construye la sección del DropdownButton
  Widget _buildDropdownSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: [
            const Text('DropdownButton Demo',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedValue,
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
                  _selectedValue = newValue;
                });
                debugPrint('Valor seleccionado: $_selectedValue');
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Construye un Container decorado
  Widget _buildDecoratedContainer() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(_padding),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: const Text(
          'Hola, Soy un Container',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  /// Construye una demostración de Row y Column
  Widget _buildRowColumnDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Este es un texto arriba'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(color: Colors.red, height: _boxSize, width: _boxSize),
                Container(
                    color: Colors.green, height: _boxSize, width: _boxSize),
                Container(
                    color: Colors.blue, height: _boxSize, width: _boxSize),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Este es un texto abajo'),
          ],
        ),
      ),
    );
  }

  /// Construye una demostración de Stack
  Widget _buildStackDemo() {
    return SizedBox(
      height: 300,
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blueAccent,
            ),
            Positioned(
              top: 50,
              left: 50,
              child: Container(
                width: _containerWidth / 2,
                height: _containerHeight,
                color: Colors.red,
              ),
            ),
            Positioned(
              bottom: 50,
              right: 50,
              child: Container(
                width: _containerWidth / 2,
                height: _containerHeight,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Construye una demostración de widgets expandidos
  Widget _buildExpandedDemo() {
    return const Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ColorBox(color: Colors.red, text: 'Elemento 1'),
          ),
          Expanded(
            child: ColorBox(color: Colors.green, text: 'Elemento 2'),
          ),
          Expanded(
            child: ColorBox(color: Colors.blue, text: 'Elemento 3'),
          ),
        ],
      ),
    );
  }

  // =============================================================================
  // CONSTRUCCIÓN PRINCIPAL DEL WIDGET
  // =============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demostración de Layouts'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdownSection(),
            const SizedBox(height: _padding),
            _buildDecoratedContainer(),
            const SizedBox(height: _padding),
            _buildRowColumnDemo(),
            const SizedBox(height: _padding),
            _buildStackDemo(),
            const SizedBox(height: _padding),
            _buildExpandedDemo(),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// WIDGETS AUXILIARES
// =============================================================================

/// Widget auxiliar para crear cajas de color con texto
class ColorBox extends StatelessWidget {
  final Color color;
  final String text;

  const ColorBox({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
