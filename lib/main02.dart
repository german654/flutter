/*
  Archivo: text_styles_example.dart
  Propósito: Este archivo muestra ejemplos del uso de textos en Flutter, incluyendo diferentes estilos, alineaciones y
             combinaciones de estilos mediante widgets como `Text` y `RichText`.
  Autor: German
  Fecha de creación: 22 de octubre de 2024
  Última modificación: 22 de octubre de 2024
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Clase principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejemplo de Textos en Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(), // Pantalla principal
    );
  }
}

// Pantalla principal con barra de navegación inferior
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Lista de widgets que representan cada una de las pantallas de ejemplo
  static final List<Widget> _widgetOptions = <Widget>[
    const Example1(), // Texto simple
    const Example2(), // Texto alineado y estilizado
    const Example3(), // RichText con múltiples estilos
  ];

  // Actualiza el índice seleccionado en la barra de navegación
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Textos en Flutter'),
      ),
      body: Center(
        child: _widgetOptions
            .elementAt(_selectedIndex), // Muestra la pantalla seleccionada
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: 'Texto Simple',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_center),
            label: 'Texto Estilizado',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_format),
            label: 'Rich Text',
          ),
        ],
        currentIndex: _selectedIndex, // Índice actual
        selectedItemColor: Colors.blue, // Color del ítem seleccionado
        onTap: _onItemTapped, // Función que cambia el índice
      ),
    );
  }
}

// Ejemplo 1: Texto simple con estilo básico
class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Texto Simple'), // Título del AppBar
      ),
      body: const Center(
        child: Text(
          '¡Hola, Flutter!', // Texto a mostrar en pantalla
          style: TextStyle(
            fontSize: 24, // Tamaño del texto
            color: Colors.blue, // Color del texto
          ),
        ),
      ),
    );
  }
}

// Ejemplo 2: Texto alineado y estilizado
class Example2 extends StatelessWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Texto Estilizado'), // Título del AppBar
      ),
      body: const Center(
        child: Text(
          'Texto alineado y estilizado', // Texto con alineación central y varios estilos
          textAlign: TextAlign.center, // Alineación centrada
          style: TextStyle(
            fontSize: 26, // Tamaño del texto
            fontWeight: FontWeight.bold, // Peso del texto en negrita
            letterSpacing: 2, // Espaciado entre letras
            wordSpacing: 5, // Espaciado entre palabras
            color: Colors.purple, // Color del texto
            backgroundColor: Colors.yellow, // Color de fondo del texto
          ),
        ),
      ),
    );
  }
}

// Ejemplo 3: Texto con múltiples estilos usando RichText
class Example3 extends StatelessWidget {
  const Example3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de RichText'), // Título del AppBar
      ),
      body: Center(
        child: RichText(
          text: const TextSpan(
            text: 'Este es un ', // Texto inicial con estilo base
            style: TextStyle(
              fontSize: 24, // Tamaño del texto base
              color: Colors.black, // Color del texto base
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'texto ', // Parte del texto en negrita y azul
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Texto en negrita
                  color: Colors.blue, // Color azul
                ),
              ),
              TextSpan(
                text: 'rico ', // Parte del texto en cursiva y verde
                style: TextStyle(
                  fontStyle: FontStyle.italic, // Texto en cursiva
                  color: Colors.green, // Color verde
                ),
              ),
              TextSpan(
                text: 'en estilos.', // Parte del texto subrayada y roja
                style: TextStyle(
                  decoration: TextDecoration.underline, // Subrayado
                  color: Colors.red, // Color rojo
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
