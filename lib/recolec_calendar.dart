import 'package:flutter/material.dart';

class RecoleccionCalendar extends StatefulWidget {
  @override
  _RecoleccionCalendarState createState() => _RecoleccionCalendarState();
}

class _RecoleccionCalendarState extends State<RecoleccionCalendar> {
  TextEditingController horaController = TextEditingController();
  TextEditingController direccionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), // Removed the header text
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 85.0), // Add top padding
        child: Column(
          children: [
            Text(
              'Programa tu próxima recolección', // Centered text
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 60),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  _buildTableCell('L'),
                  _buildTableCell('M'),
                  _buildTableCell('M'),
                  _buildTableCell('J'),
                  _buildTableCell('V'),
                  _buildTableCell('S'),
                  _buildTableCell('D'),
                ]),
                TableRow(children: [
                  _buildDateCell('1'),
                  _buildDateCell('2'),
                  _buildDateCell('3'),
                  _buildDateCell('4'),
                  _buildDateCell('5'),
                  _buildDateCell('6'),
                  _buildDateCell('7'),
                ]),
                TableRow(children: [
                  _buildDateCell('8'),
                  _buildDateCell('9'),
                  _buildDateCell('10'),
                  _buildDateCell('11'),
                  _buildDateCell('12'),
                  _buildDateCell('13'),
                  _buildDateCell('14'),
                ]),
                TableRow(children: [
                  _buildDateCell('15'),
                  _buildDateCell('16'),
                  _buildDateCell('17'),
                  _buildDateCell('18'),
                  _buildDateCell('19'),
                  _buildDateCell('20'),
                  _buildDateCell('21'),
                ]),
                TableRow(children: [
                  _buildDateCell('22'),
                  _buildDateCell('23'),
                  _buildDateCell('24'),
                  _buildDateCell('25'),
                  _buildDateCell('26'),
                  _buildDateCell('27'),
                  _buildDateCell('28'),
                ]),
                                TableRow(children: [
                  _buildDateCell('29'),
                  _buildDateCell('30'),
                  _buildDateCell('31'),
                ]),
                // Add more TableRow for each week of the month with date numbers
                // ...
                // Add more TableRow for each week of the month with date numbers
              ],
            ),
            SizedBox(height: 100),
            TextField(
              controller: horaController,
              decoration: InputDecoration(
                labelText: 'Hora',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: direccionController,
              decoration: InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDateCell(String date) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(date),
    );
  }
}