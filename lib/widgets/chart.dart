import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget{

  final List<Transaccion> transaccionesRecientes;

  Chart(this.transaccionesRecientes);

  List<Map<String, Object>> get valorTransaccionesAgrupadas{

    return List.generate(4, (index){


      final categorias = ['Comida', 'Cine', 'Viaje', 'Trabajo'];
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
      color: Colors.deepPurple[50],
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: valorTransaccionesAgrupadas.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['Categoria'] as String,
                data['Cantidad'] as double,
                gastoTotal == 0.0 ? 0.0 : (data['Cantidad'] as double) / gastoTotal,
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

      case 'Comida': return Icons.fastfood;
      case 'Cine': return Icons.movie;
      case 'Viaje': return Icons.flight;
      case 'Trabajo': return Icons.work;
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

              child: Text('\$${cantidadGasto.toStringAsFixed(0)}')),

          

          ),

          SizedBox(height: restriccion.maxHeight * 0.05),
          Container(
          height: restriccion.maxHeight*0.6,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color:Colors.grey,width:1.0),
                  color: Color.fromRGBO(220,220,220,1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: porcentajeGastoTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: restriccion.maxHeight*0.05,),
        Container(
          height: restriccion.maxHeight*0.15,
          child: FittedBox(child: Icon(obtenerIcon(etiqueta), color:Colors.grey)),
        ),
      ],
      );

    });

  }

}
