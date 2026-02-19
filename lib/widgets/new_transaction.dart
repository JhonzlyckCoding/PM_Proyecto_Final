import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class nuevaTransaccion extends StatefulWidget{
  final Function addTx;
  nuevaTransaccion(this.addTx);
  @override
  _nuevaTransaccionState createState()=>_nuevaTransaccionState();
}

class _nuevaTransaccionState extends State<nuevaTransaccion>{
  final _tituloControler= TextEditingController();
  final _cantidadControler= TextEditingController();
  DateTime? _seleccionarFecha;
  String _seleccionarCategoria= 'Comida';

  void _entregarDatos(){
    if (_cantidadControler.text.isEmpty)return;
    final tituloEntregado= _tituloControler.text;
    final cantidadEntregada= double.parse(_cantidadControler.text);

    if(tituloEntregado.isEmpty || cantidadEntregada<=0 || _seleccionarFecha==null){
      return;
    }
    widget.addTx(tituloEntregado,cantidadEntregada,_seleccionarFecha,_seleccionarCategoria);
    Navigator.of(context).pop();
  }

  void _presenterDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
      ).then((pickedDate){
        if(pickedDate==null)return;
        setState(() {
          _seleccionarFecha=pickedDate;
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    // 1. Agregamos el SingleChildScrollView para permitir el desplazamiento
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            // 2. Ajuste dinámico para que el teclado no tape los botones
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Titulo'),
                controller: _tituloControler,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Cantidad'),
                controller: _cantidadControler,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  DropdownButton<String>(
                    value: _seleccionarCategoria,
                    items: ['Comida', 'Cine', 'Viaje', 'Trabajo']
                        .map((Category) => DropdownMenuItem(
                              child: Text(Category),
                              value: Category,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _seleccionarCategoria = value!;
                      });
                    },
                  ),
                  const Spacer(),
                  Expanded(
                    child: Text(
                      _seleccionarFecha == null
                          ? 'Fecha no elegida'
                          : 'Fecha: ${DateFormat.yMd().format(_seleccionarFecha!)}',
                    ),
                  ),
                  TextButton(
                    child: const Text("Elegir Fecha",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: _presenterDatePicker,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Guardar Gasto"),
                    onPressed: _entregarDatos,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

