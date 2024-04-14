import 'dart:async';
import 'package:flutter/material.dart';
import '../Widgets/BarraDeNavegacion.dart';
import '../Widgets/Menu.dart';

class EstadisticasUsuario extends StatefulWidget {
  @override
  _EstadisticasUsuarioState createState() => _EstadisticasUsuarioState();
}

class _EstadisticasUsuarioState extends State<EstadisticasUsuario> {
  String nombreUsuario = 'Juan Vargas'; // Simulación del nombre de usuario
  double papelCartonCantidad = 0;
  double plasticoMetalVidrioCantidad = 0;
  double reduccionCarbono = 0;
  int arbolesDejadosTalar = 0;
  double ahorroEnergia = 0;

  StreamController<double> papelCartonStreamController =
      StreamController<double>();
  StreamController<double> plasticoMetalVidrioStreamController =
      StreamController<double>();

  // Método para simular la actualización de datos desde la base de datos
  void actualizarDatos() {
    double papelCartonDesdeBD = 13; // Obtener desde la base de datos por usuario
    double plasticoMetalVidrioDesdeBD = 12; // Obtener desde la base de datos por usuario

    papelCartonStreamController.add(papelCartonDesdeBD);
    plasticoMetalVidrioStreamController.add(plasticoMetalVidrioDesdeBD);

    // Calcular los valores de reducción de carbono, árboles dejados de talar y ahorro de energía
    reduccionCarbono = calcularReduccionCarbono(
        papelCartonDesdeBD, plasticoMetalVidrioDesdeBD);
    arbolesDejadosTalar =
        calcularArbolesDejadosTalar(papelCartonDesdeBD.toInt());
    ahorroEnergia =
        calcularAhorroEnergia(papelCartonDesdeBD, plasticoMetalVidrioDesdeBD);
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

  // Función para calcular la reducción de carbono en kgCO2e
  double calcularReduccionCarbono(
      double papelCarton, double plasticoMetalVidrio) {
    // Supongamos que cada tonelada de papel/cartón reciclado ahorra 1.2 toneladas de CO2 y cada tonelada de plástico/metal/vidrio reciclado ahorra 3.5 toneladas de CO2
    double reduccionPapelCarton = papelCarton * 1.2;
    double reduccionPlasticoMetalVidrio = plasticoMetalVidrio * 3.5;

    // La reducción total de carbono es la suma de ambas
    double reduccionTotal = reduccionPapelCarton + reduccionPlasticoMetalVidrio;

    return reduccionTotal;
  }

  // Función para calcular la cantidad de árboles dejados de talar
  int calcularArbolesDejadosTalar(int papelCarton) {
    // Supongamos que se salvan 17 árboles por cada tonelada de papel/cartón reciclado
    return (papelCarton / 17).round();
  }

  // Función para calcular el ahorro de energía en kWh
  double calcularAhorroEnergia(double papelCarton, double plasticoMetalVidrio) {
    // Supongamos que se ahorran 300 kWh por cada tonelada de papel/cartón reciclado y 900 kWh por cada tonelada de plástico/metal/vidrio reciclado
    double ahorroPapelCarton = papelCarton * 300;
    double ahorroPlasticoMetalVidrio = plasticoMetalVidrio * 900;

    // El ahorro total de energía es la suma de ambos
    double ahorroTotal = ahorroPapelCarton + ahorroPlasticoMetalVidrio;

    return ahorroTotal;
  }

  @override
  void initState() {
    super.initState();
    // Llamar a la función actualizarDatos al iniciar la vista
    actualizarDatos();
  }

  @override
  void dispose() {
    papelCartonStreamController.close();
    plasticoMetalVidrioStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40), // Espacio para el menú
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 32,
                  color: Colors.black87,
                ),
                onPressed: () {
                  // Mostrar el menú
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Menu();
                    },
                  );
                },
              ),
            ],
          ),
          Text(
            'Hola',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
          ),
          SizedBox(height: 10),
          Text(
            nombreUsuario, // Nombre de usuario obtenido de la base de datos
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Tu Recolección total',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 14, 48, 16),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  StreamBuilder(
                    stream: papelCartonStreamController.stream,
                    builder:
                        (BuildContext context, AsyncSnapshot<double> snapshot) {
                      if (snapshot.hasData) {
                        papelCartonCantidad = snapshot.data!;
                        return CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          backgroundColor: Color(0xFFE5B44C),
                          child: Text(
                            ajustarUnidad(papelCartonCantidad),
                            style: TextStyle(
                              fontSize:
                                  24, // Reducido el tamaño de fuente para ajustar el número de dígitos
                              fontWeight: FontWeight.w900,
                              color: Colors.green[900],
                            ),
                            maxLines:
                                1, // Establecer el número máximo de líneas
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
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
              SizedBox(width: 40),
              Column(
                children: [
                  StreamBuilder(
                    stream: plasticoMetalVidrioStreamController.stream,
                    builder:
                        (BuildContext context, AsyncSnapshot<double> snapshot) {
                      if (snapshot.hasData) {
                        plasticoMetalVidrioCantidad = snapshot.data!;
                        return CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          backgroundColor: Color(0xFF94C548),
                          child: Text(
                            ajustarUnidad(plasticoMetalVidrioCantidad),
                            style: TextStyle(
                              fontSize:
                                  24, // Reducido el tamaño de fuente para ajustar el número de dígitos
                              fontWeight: FontWeight.w900,
                              color: Colors.green[900],
                            ),
                            maxLines:
                                1, // Establecer el número máximo de líneas
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
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
          SizedBox(height: 18),
          Text(
            'Tu huella de carbono',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 14, 48, 16),
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
                    backgroundColor: Color(0xFFACACAC), // Nuevo color
                    child: Text(
                      '${reduccionCarbono.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize:
                            24, // Reducido el tamaño de fuente para ajustar el número de dígitos
                        fontWeight: FontWeight.w900,
                        color: Colors.green[900],
                      ),
                      maxLines: 1, // Establecer el número máximo de líneas
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Reducción en carbono\nkgCO2e',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 40),
              Column(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.15,
                    backgroundColor: Color(0xFFA6C2DC), // Nuevo color
                    child: Text(
                      '$arbolesDejadosTalar',
                      style: TextStyle(
                        fontSize:
                            24, // Reducido el tamaño de fuente para ajustar el número de dígitos
                        fontWeight: FontWeight.w900,
                        color: Colors.green[900],
                      ),
                      maxLines: 1, // Establecer el número máximo de líneas
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Árboles dejados de\ntalar',
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
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.15,
                    backgroundColor: Color(0xFFF19BBA), // Nuevo color
                    child: Text(
                      '${ahorroEnergia.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize:
                            24, // Reducido el tamaño de fuente para ajustar el número de dígitos
                        fontWeight: FontWeight.w900,
                        color: Colors.green[900],
                      ),
                      maxLines: 1, // Establecer el número máximo de líneas
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ahorro de energía\nkWh',
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
