/*
* Nombre del archivo: navegacion_app.dart
* Propósito: Demostrar el uso de navegación entre pantallas en Flutter utilizando Navigator
*           y la transferencia de datos entre páginas.
* Autor: German (Modificado y mejorado)
* Fecha de creación: 22 de Octubre de 2024
* Última modificación: 24 de Octubre de 2024
*
* Características:
* - Navegación entre páginas usando Navigator
* - Paso de datos entre pantallas
* - Diseño Material Design 3
* - Manejo de temas claro y oscuro
* - Animaciones de transición personalizadas
*/

import 'package:flutter/material.dart';

// ------------------
// Punto de entrada de la aplicación
// ------------------
void main() {
  runApp(const NavegacionApp());
}

// ------------------
// Widget principal de la aplicación
// ------------------
class NavegacionApp extends StatelessWidget {
  const NavegacionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Configuración básica de la aplicación
      title: 'Demo de Navegación',
      debugShowCheckedModeBanner: false, // Oculta el banner de debug

      // Configuración del tema de la aplicación
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      // Tema oscuro de la aplicación
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      // Página inicial de la aplicación
      home: const HomePage(),
    );
  }
}

// ------------------
// Página Principal (HomePage)
// ------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        title: const Text('Página Principal'),
        centerTitle: true,
        elevation: 2, // Sombra suave en la AppBar
      ),

      // Contenido principal
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título de bienvenida
              const Text(
                '¡Bienvenido!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Descripción
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Esta es una demostración de navegación entre páginas en Flutter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Botón de navegación
              ElevatedButton.icon(
                onPressed: () => _navegarASegundaPagina(context),
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'Ir a la Segunda Página',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Método para manejar la navegación a la segunda página
  void _navegarASegundaPagina(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SecondPage(
          message: '¡Hola desde la página principal!',
        ),
      ),
    );
  }
}

// ------------------
// Segunda Página (SecondPage)
// ------------------
class SecondPage extends StatelessWidget {
  final String message;

  const SecondPage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        title: const Text('Segunda Página'),
        centerTitle: true,
        elevation: 2,
        // Botón personalizado para regresar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Volver',
        ),
      ),

      // Contenido principal
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono decorativo
                Icon(
                  Icons.message,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),

                // Mensaje recibido
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Mensaje recibido:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
                          style: const TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Botón para regresar
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    'Regresar a la Página Principal',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
