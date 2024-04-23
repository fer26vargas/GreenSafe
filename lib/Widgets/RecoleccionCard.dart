import 'package:flutter/material.dart';

class RecoleccionCardWidget extends StatelessWidget {
  final String name;
  final String address;
  final String imageUrl;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RecoleccionCardWidget({
    Key? key,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green[900]!, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto
            CircleAvatar(
              backgroundImage: AssetImage(imageUrl),
              radius: 35, 
            ),
            SizedBox(width: 25), 
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(address),
                  SizedBox(height: 5), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[900],
                        ),
                        child: Text('Rechazar', style: TextStyle(color: Colors.white)),
                        onPressed: onReject,
                      ),
                      SizedBox(width: 10), 
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[900],
                        ),
                        child: Text('Aceptar', style: TextStyle(color: Colors.white)),
                        onPressed: onAccept,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
