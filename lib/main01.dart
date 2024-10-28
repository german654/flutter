/* =============================================================================
  ARCHIVO: main.dart
  PROPOSITO: Este archivo define la estructura de una aplicación Flutter con 
  navegación mediante un BottomNavigationBar 
  y un Drawer. Permite la selección de diferentes páginas 
  (Inicio, Perfil, Ajustes) y actualiza el contenido 
   de la pantalla según la opción seleccionada.
  AUTOR: German
  FECHA CREACIÓN: 22 de octubre de 2024
  ÚLTIMA MODIFICACIÓN: 22 de octubre de 2024
  =============================================================================*/

import 'package:flutter/material.dart';

// =============================================================================
// PUNTO DE ENTRADA DE LA APLICACIÓN
// =============================================================================
void main() {
  runApp(const MyApp()); // Punto de entrada de la aplicación
}

// =============================================================================
// WIDGET PRINCIPAL DE LA APLICACIÓN SIN ESTADO
// =============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Elimina la etiqueta de "debug" en la esquina superior
      // Configuración general de la aplicación
      title: 'Flutter Demo', // Título de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define el color primario del tema
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(), // Pantalla principal de la aplicación
    );
  }
}

// =============================================================================
// PÁGINA PRINCIPAL CON ESTADO
// =============================================================================
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Índice del ítem seleccionado en el BottomNavigationBar
  int _selectedIndex = 0;

  // Lista de widgets que se mostrarán  en el cuerpo según el índice
  // seleccionado
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Página 1: Inicio', style: TextStyle(fontSize: 30)),
    Text('Página 2: Perfil', style: TextStyle(fontSize: 30)),
    Text('Página 3: Ajustes', style: TextStyle(fontSize: 30)),
  ];

  // ===========================================================================
  // MÉTODOS DE NAVEGACIÓN
  // ===========================================================================
  // Funcion que actualiza el estado cuando se selecciona un ítem en el
  // BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Actualiza el estado y cierra el Drawer cuando se selecciona un ítem
  void _onItemTappedDra(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context); // Cierra el Drawer
    });
  }

  // ===========================================================================
  // CONSTRUCCIÓN DE LOS WIDGETS DE LA INTERFAZ
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar de la pantalla principal con el título
      appBar: AppBar(
        title: const Text('Estructura de App en Flutter'),
      ),
      // Drawer lateral con opciones de navegación
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Elimina cualquier padding adicional
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue, // Fondo azul para el DrawerHeader
              ),
              child: Text(
                'Menú de Navegación', // Título del Drawer
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Opción "Inicio" en el Drawer
            ListTile(
              leading: const Icon(Icons.home), // Icono de "Inicio"
              title: const Text('Inicio'),
              onTap: () => _onItemTappedDra(0), // Selección de "Inicio"
            ),
            // Opción "Perfil" en el Drawer
            ListTile(
              leading: const Icon(Icons.person), // Icono de "Perfil"
              title: const Text('Perfil'),
              onTap: () => _onItemTappedDra(1), // Selección de "Perfil"
            ),
            // Opción "Ajustes" en el Drawer
            ListTile(
              leading: const Icon(Icons.settings), // Icono de "Ajustes"
              title: const Text('Ajustes'),
              onTap: () => _onItemTappedDra(2), // Selección de "Ajustes"
            ),
          ],
        ),
      ),
      // Contenido principal de la pantalla que cambia según el índice seleccionado
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // BottomNavigationBar con las tres opciones
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Icono de "Inicio"
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Icono de "Perfil"
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Icono de "Ajustes"
            label: 'Ajustes',
          ),
        ],
        currentIndex:
            _selectedIndex, // Índice del ítem actualmente seleccionado
        selectedItemColor: const Color.fromARGB(
            255, 243, 177, 33), // Color del ítem seleccionado
        onTap: _onItemTapped, // Método que se ejecuta al seleccionar un ítem
      ),
    );
  }
}
