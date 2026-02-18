import 'package:flutter/material.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget{

  final List<Transaction> transaccionesRecientes;

  Chart(this.transaccionesRecientes)

  List<Map<String, Object>> get valorTransaccionesAgrupadas{

    return List.generate(4, (index){


      final categorias = ['Comida', 'Cine', 'Viaje', 'Trabajo']
      final nombreCategorias = categorias[index];

      var totalSum = 0.0;

      for (var i = 0; i <transaccionesRecientes.length; i++){

        if(transaccionesRecientes[i].categoria == nombreCategorias){

          totalSum += transaccionesRecientes[i].cantidad;

        }

      }

      return{

        'Categoria': nombreCategorias,
        'Cantidad': totalSum,

      };

    });

  }

  double get gastoTotal{

    return valorTransaccionesAgrupadas.fold(0.0, (sum, item){

      return sum + (item['Cantidad'] as double);

    });

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: valorTransaccionesAgrupadas.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: Column(
                children: <Widget>[
                  Text(data['Categoria'] as String),
                  SizedBox(height: 4),
                  Text('\$${(data['Cantidad'] as double).toStringAsFixed(2)}'),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}

class ChartBar extends StatelessWidget{

  final String etiqueta;
  final double cantidadGasto;
  final double porcentajeGastoTotal;

  ChartBar(this.etiqueta, this.cantidadGasto, this.porcentajeGastoTotal);
  
  IconData obtenerIcon(String etiqueta){

    switch(etiqueta){

      case 'comida': return Icons.restaurant;
      case 'cine': return Icons.movie;
      case 'viaje': return Icons.flight;
      case 'trabajo': return Icons.work;
      default: return Icons.category;

    }

  }


  @override
  Widget build(BuildContext context){

    return LayoutBuilder(builder: (ctx, restriccion){

      return Column(

        children: <Widget>[

          Container(

            height: restriccion.maxHeight * 0.15,
            child: FittedBox(

              child: Text('\$${cantidadGasto.toStringAsFixed(0)}'),

            ),

          ),

          SizedBox(height: restriccion.maxHeight * 0.6,
          widht: 10,
          child: Stack(


            

          ),))

        ]

      )

    })

  }

}
