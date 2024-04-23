import 'package:flutter/material.dart';
import 'package:visual1/Widgets/BarraDeNavegacion.dart'; // Importa el widget de la barra de navegación
import '../Widgets/Menu.dart';

class VistaPrincipal extends StatefulWidget {
  @override
  _VistaPrincipalState createState() => _VistaPrincipalState();
}

class _VistaPrincipalState extends State<VistaPrincipal> {
  double papelCartonCantidad = 0;
  double plasticoMetalVidrioCantidad = 0;

  // Método para simular la actualización de datos desde la base de datos
  void actualizarDatos() {
    // Aquí iría la lógica para obtener los datos de la base de datos
    // Supongamos que se obtienen los valores de papel/cartón y plástico/metal/vidrio desde la base de datos
    double papelCartonDesdeBD = 174000; // Obtener desde la base de datos (estos son kg)
    double plasticoMetalVidrioDesdeBD = 12; // Obtener desde la base de datos

    // Actualizar los valores con los obtenidos de la base de datos
    setState(() {
      papelCartonCantidad = papelCartonDesdeBD;
      plasticoMetalVidrioCantidad = plasticoMetalVidrioDesdeBD;
    });
  }

  // Función para ajustar automáticamente la unidad según el valor de la cantidad
  String ajustarUnidad(double cantidad) {
    if (cantidad >= 1000000000) {
      // Cambia a millones de toneladas si la cantidad es mayor o igual a 1 billón
      return '${(cantidad / 1000000000).toStringAsFixed(2).replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '')}M Tn';
    } else if (cantidad >= 1000000) {
      // Cambia a miles de toneladas si la cantidad es mayor o igual a 1 millón pero menor a 1 billón
      return '${(cantidad / 1000000).toStringAsFixed(2).replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '')}K Tn';
    } else if (cantidad >= 1000) {
      // Cambia a toneladas si la cantidad es mayor o igual a 1 mil pero menor a 1 millón
      return '${(cantidad / 1000).toStringAsFixed(2).replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '')} Tn';
    } else {
      // Mantén en kilogramos si la cantidad es menor a 1 mil
      return '${cantidad.toStringAsFixed(2).replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '')} Kg';
    }
  }

  @override
  void initState() {
    super.initState();
    // Llamar a la función actualizarDatos al iniciar la vista
    actualizarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/inicio.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20, 
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(8),
                    child: IconButton(
                      icon: Icon(
                        Icons.menu, 
                        size: 32, 
                        color: Colors.black87, 
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Menu();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Text(
              'Se parte del cambio!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.green[900],
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Total de residuos recolectados en el área metropolitana',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.green[900],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.15,
                    backgroundColor: Color(0xFFE5B44C),
                    child: Text(
                      ajustarUnidad(papelCartonCantidad),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.green[900],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Papel/Carton',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  Text(
                    'tetrapack',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.15,
                    backgroundColor: Color(0xFF94C548),
                    child: Text(
                      ajustarUnidad(plasticoMetalVidrioCantidad),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.green[900],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Plástico,',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  Text(
                    'metal y vidrio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Divider(
            height: 1,
            color: Colors.black38,
          ),
          BarraDeNavegacion(),
        ],
      ),
    );
  }
}
