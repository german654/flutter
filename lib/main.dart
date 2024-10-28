/*
  Archivo: main.dart
  Propósito: Este archivo contiene una simple aplicación Flutter que muestra un título en la AppBar
            y un texto centrado en el cuerpo de la pantalla.
  Autor: German
  Fecha de creación: 22 de octubre de 2024
  Última modificación: 22 de octubre de 2024
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Punto de entrada principal de la aplicación
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Elimina la marca de "debug" en la esquina superior derecha
      title: 'Flutter Demo', // Título de la aplicación
      theme: ThemeData(
        primarySwatch:
            Colors.blue, // Define el color primario del tema como azul
      ),
      home: const MyHomePage(), // Define la página de inicio de la aplicación
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() =>
      _MyHomePageState(); // Crea el estado asociado a este widget
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold proporciona la estructura básica de una pantalla con appBar y body
      appBar: AppBar(
        title: const Text(
            'Título de Widget'), // Define el título que se muestra en la AppBar
      ),
      body: const Center(
        // Center alinea su hijo en el centro del espacio disponible
        child: Text(
            "Contenido Aquí"), // Texto que se muestra en el centro de la pantalla
      ),
    );
  }
}
