import 'package:flutter/material.dart';

class Transaccion {
  final String id;
  final String titulo;
  final double cantidad;
  final DateTime fecha;
  final String categoria;

  Transaccion({
    required this.id,
    required this.titulo,
    required this.cantidad,
    required this.fecha,
    required this.categoria
  });
}

