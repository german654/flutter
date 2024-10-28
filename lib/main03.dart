/* =============================================================================
  ARCHIVO: main.dart
  PROPOSITO: Este archivo implementa una aplicación Flutter que muestra ejemplos 
  de diferentes tipos de botones y campos de texto. Además, permite gestionar el 
  estado de la interfaz y simular procesos de carga a través de componentes reutilizables.
  AUTOR: German
  FECHA CREACIÓN: 22 de octubre de 2024
  ÚLTIMA MODIFICACIÓN: 22 de octubre de 2024
  =============================================================================*/

import 'package:flutter/material.dart';

// =============================================================================
// PUNTO DE ENTRADA DE LA APLICACIÓN
// =============================================================================
void main() {
  runApp(const MyApp());
}

// =============================================================================
// CLASE PRINCIPAL DE LA APLICACIÓN
// =============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// =============================================================================
// CLASE HomePage: DEFINE LA PÁGINA PRINCIPAL DEL APLICATIVO
// =============================================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controladores para los campos de texto
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _message = '';

  @override
  void dispose() {
    _textController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // =============================================================================
  // MÉTODO: Muestra un mensaje en la parte inferior de la pantalla
  // =============================================================================
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // =============================================================================
  // MÉTODO: Simula un proceso de carga
  // =============================================================================
  void _simulateLoading() {
    setState(() {
      _isLoading = true;
      _message = 'Procesando...';
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _message = '';
      });
    });
  }

  // =============================================================================
  // CONSTRUYE LA INTERFAZ DE USUARIO
  // =============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplos de Widgets'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sección de Botones
            const Text(
              'Tipos de Botones',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // ElevatedButton Componentizado
            ElevatedButtonComponent(
              isLoading: _isLoading,
              simulateLoading: _simulateLoading,
              showSnackBar: _showSnackBar,
            ),
            const SizedBox(height: 10),

            // TextButton Componentizado
            TextButtonComponent(
              isLoading: _isLoading,
              simulateLoading: _simulateLoading,
              showSnackBar: _showSnackBar,
            ),
            const SizedBox(height: 10),

            // OutlinedButton Componentizado
            OutlinedButtonComponent(
              isLoading: _isLoading,
              simulateLoading: _simulateLoading,
              showSnackBar: _showSnackBar,
            ),
            const SizedBox(height: 10),

            // IconButton Componentizado
            IconButtonComponent(
              isLoading: _isLoading,
              simulateLoading: _simulateLoading,
              showSnackBar: _showSnackBar,
            ),
            const SizedBox(height: 10),

            // ElevatedButton con icono Componentizado
            ElevatedButtonWithIconComponent(
              isLoading: _isLoading,
              simulateLoading: _simulateLoading,
              showSnackBar: _showSnackBar,
            ),
            const SizedBox(height: 20),

            // Sección de Campos de Texto
            const Text(
              'Campos de Entrada',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Campo de texto simple
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Campo de texto simple',
                hintText: 'Escribe algo aquí',
                prefixIcon: const Icon(Icons.edit),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                    _showSnackBar('Campo limpiado');
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _message = 'Escribiendo: $value';
                });
              },
              onSubmitted: (value) {
                _showSnackBar('Texto ingresado: $value');
              },
            ),
            const SizedBox(height: 20),

            // TextFormField con validación
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'ejemplo@correo.com',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _emailController.clear();
                      _showSnackBar('Campo limpiado');
                    },
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un correo';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Ingrese un correo válido';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    _showSnackBar('Correo válido: $value');
                  }
                },
              ),
            ),

            const SizedBox(height: 20),
            // Mensaje de estado
            if (_message.isNotEmpty)
              Text(
                _message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading
            ? null
            : () {
                _simulateLoading();
                _showSnackBar('FloatingActionButton presionado');
              },
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Icon(Icons.add),
      ),
    );
  }
}

// =============================================================================
// COMPONENTES DE BOTONES MODULARIZADOS
// =============================================================================

class ElevatedButtonComponent extends StatelessWidget {
  final bool isLoading;
  final VoidCallback simulateLoading;
  final Function(String) showSnackBar;

  const ElevatedButtonComponent({
    required this.isLoading,
    required this.simulateLoading,
    required this.showSnackBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () {
              simulateLoading();
              showSnackBar('ElevatedButton presionado');
            },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : const Text('ElevatedButton'),
    );
  }
}

class TextButtonComponent extends StatelessWidget {
  final bool isLoading;
  final VoidCallback simulateLoading;
  final Function(String) showSnackBar;

  const TextButtonComponent({
    required this.isLoading,
    required this.simulateLoading,
    required this.showSnackBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading
          ? null
          : () {
              simulateLoading();
              showSnackBar('TextButton presionado');
            },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.blue.withOpacity(0.1),
      ),
      child: const Text('TextButton'),
    );
  }
}

class OutlinedButtonComponent extends StatelessWidget {
  final bool isLoading;
  final VoidCallback simulateLoading;
  final Function(String) showSnackBar;

  const OutlinedButtonComponent({
    required this.isLoading,
    required this.simulateLoading,
    required this.showSnackBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading
          ? null
          : () {
              simulateLoading();
              showSnackBar('OutlinedButton presionado');
            },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(16),
      ),
      child: const Text('OutlinedButton'),
    );
  }
}

class IconButtonComponent extends StatelessWidget {
  final bool isLoading;
  final VoidCallback simulateLoading;
  final Function(String) showSnackBar;

  const IconButtonComponent({
    required this.isLoading,
    required this.simulateLoading,
    required this.showSnackBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading
          ? null
          : () {
              simulateLoading();
              showSnackBar('IconButton presionado');
            },
      icon: const Icon(Icons.thumb_up),
    );
  }
}

class ElevatedButtonWithIconComponent extends StatelessWidget {
  final bool isLoading;
  final VoidCallback simulateLoading;
  final Function(String) showSnackBar;

  const ElevatedButtonWithIconComponent({
    required this.isLoading,
    required this.simulateLoading,
    required this.showSnackBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading
          ? null
          : () {
              simulateLoading();
              showSnackBar('ElevatedButton con icono presionado');
            },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
      ),
      icon: const Icon(Icons.thumb_up),
      label: const Text('ElevatedButton con icono'),
    );
  }
}
