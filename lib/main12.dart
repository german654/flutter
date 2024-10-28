/*
 * Nombre del archivo: scroll_widgets_demo.dart
 * Propósito: Demonstrar el uso de diferentes widgets de desplazamiento en Flutter
 * Autor: German (Modificado y mejorado)
 * Fecha de creación: 22 de Octubre de 2024
 * Última modificación: 24 de Octubre de 2024
 * 
 * Este archivo contiene ejemplos de:
 * - SingleChildScrollView: Para scroll simple de un solo hijo
 * - ListView.builder: Para listas eficientes con muchos elementos
 * - GridView: Para visualización en cuadrícula
 * - ScrollController: Para control programático del scroll
 */

import 'package:flutter/material.dart';

// Punto de entrada principal de la aplicación
void main() {
  runApp(MyApp());
}

// Widget principal que define la estructura base de la aplicación
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo de Widgets de Scroll',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

// Página principal que contiene la navegación entre ejemplos
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejemplos de Scroll'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationButton(
              context,
              'SingleChildScrollView Example',
              SingleChildScrollViewExample(),
            ),
            _buildNavigationButton(
              context,
              'ListView Example',
              ListViewScrollExample(),
            ),
            _buildNavigationButton(
              context,
              'GridView Example',
              GridViewScrollExample(),
            ),
            _buildNavigationButton(
              context,
              'ScrollController Example',
              ScrollControllerExample(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method para construir botones de navegación
  Widget _buildNavigationButton(
      BuildContext context, String title, Widget destination) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        ),
        child: Text(title),
      ),
    );
  }
}

// EJEMPLO 1: SingleChildScrollView
class SingleChildScrollViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollView'),
      ),
      body: SingleChildScrollView(
        // Configuración del padding y física del scroll
        padding: const EdgeInsets.all(16.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: List.generate(20, (index) {
            // Generación de contenedores de ejemplo
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Item $index',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// EJEMPLO 2: ListView.builder
class ListViewScrollExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Scroll'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 50,
        // Construcción eficiente de elementos bajo demanda
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text('Elemento $index'),
              subtitle: Text('Descripción del elemento $index'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Acción al tocar el elemento
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seleccionado elemento $index')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// EJEMPLO 3: GridView
class GridViewScrollExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView Scroll'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.blue[300 + (index * 100) % 300],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.grid_on,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Item $index',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// EJEMPLO 4: ScrollController
class ScrollControllerExample extends StatefulWidget {
  @override
  _ScrollControllerExampleState createState() =>
      _ScrollControllerExampleState();
}

class _ScrollControllerExampleState extends State<ScrollControllerExample> {
  // Controlador para manejar el scroll programáticamente
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    // Configurar listener para detectar la posición del scroll
    _scrollController.addListener(_scrollListener);
  }

  // Método que escucha los cambios en el scroll
  void _scrollListener() {
    // Mostrar/ocultar botón de scroll según la posición
    setState(() {
      _showScrollToTopButton = _scrollController.offset > 200;
    });

    // Detectar cuando llegamos al final o inicio de la lista
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        print('Llegamos al inicio de la lista');
      } else {
        print('Llegamos al final de la lista');
      }
    }
  }

  // Método para hacer scroll al inicio de la lista
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Método para hacer scroll al final de la lista
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollController'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
            subtitle: Text('Descripción detallada del item $index'),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_showScrollToTopButton)
            FloatingActionButton(
              heroTag: 'scrollToTop',
              onPressed: _scrollToTop,
              child: Icon(Icons.arrow_upward),
              mini: true,
            ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'scrollToBottom',
            onPressed: _scrollToBottom,
            child: Icon(Icons.arrow_downward),
          ),
        ],
      ),
    );
  }
}
