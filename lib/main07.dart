/*
* Nombre del archivo: usuario_lista_app.dart
* Propósito: Aplicación Flutter que demuestra diferentes formas de mostrar datos de usuarios
*           utilizando ListView y DataTable, con manejo de estados asincrónicos.
* Autor: German (Modificado y mejorado)
* Fecha de creación: 22 de Octubre de 2024
* Última modificación: 24 de Octubre de 2024
*/

import 'package:flutter/material.dart';

// ------------------
// Punto de entrada de la aplicación
// ------------------
void main() {
  runApp(const UsuarioListaApp());
}

// ------------------
// Widget principal de la aplicación
// ------------------
class UsuarioListaApp extends StatelessWidget {
  const UsuarioListaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Usuarios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Utiliza Material Design 3
      ),
      home: const HomePage(),
    );
  }
}

// ------------------
// Página principal con navegación
// ------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListaUsuariosPage()),
              ),
              child: const Text('Ver Lista de Usuarios'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TablaUsuariosPage()),
              ),
              child: const Text('Ver Tabla de Usuarios'),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------
// Modelo de datos
// ------------------
class Usuario {
  final String nombre;
  final int edad;

  /// Constructor para crear una instancia de Usuario
  const Usuario(this.nombre, this.edad);
}

// ------------------
// Servicios de datos
// ------------------
class UsuarioService {
  /// Simula una llamada a API para obtener usuarios
  /// Retorna una lista de usuarios después de un delay
  static Future<List<Usuario>> obtenerUsuarios() async {
    // Simulamos un tiempo de espera como en una llamada real a API
    await Future.delayed(const Duration(seconds: 2));

    // Retornamos datos de ejemplo
    return const [
      Usuario('Juan Pérez', 25),
      Usuario('Ana García', 30),
      Usuario('Pedro Martínez', 28),
      Usuario('María Rodríguez', 22),
      Usuario('Luis Sánchez', 35),
      Usuario('Carmen López', 27),
      Usuario('Diego Torres', 33),
    ];
  }
}

// ------------------
// Páginas de visualización
// ------------------
class ListaUsuariosPage extends StatelessWidget {
  const ListaUsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: FutureBuilder<List<Usuario>>(
        future: UsuarioService.obtenerUsuarios(),
        builder: (context, snapshot) {
          // Manejo de estados de la carga de datos
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay usuarios disponibles'));
          }

          // Construcción de la lista de usuarios
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final usuario = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(usuario.nombre[0]),
                  ),
                  title: Text(usuario.nombre),
                  subtitle: Text('Edad: ${usuario.edad} años'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Implementar acción al tocar un usuario
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TablaUsuariosPage extends StatelessWidget {
  const TablaUsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabla de Usuarios'),
      ),
      body: FutureBuilder<List<Usuario>>(
        future: UsuarioService.obtenerUsuarios(),
        builder: (context, snapshot) {
          // Manejo de estados de la carga de datos
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay usuarios disponibles'));
          }

          // Construcción de la tabla de usuarios
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text('Nombre',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Edad',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Acciones',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: snapshot.data!
                    .map((usuario) => DataRow(
                          cells: [
                            DataCell(Text(usuario.nombre)),
                            DataCell(Text('${usuario.edad} años')),
                            DataCell(IconButton(
                              icon: const Icon(Icons.info),
                              onPressed: () {
                                // TODO: Implementar acción para ver detalles
                              },
                            )),
                          ],
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
