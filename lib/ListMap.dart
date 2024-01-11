import 'package:flutter/material.dart';

class ListObjet extends StatefulWidget {
  const ListObjet({Key? key}) : super(key: key);

  @override
  _ListObjetState createState() => _ListObjetState();
}

class _ListObjetState extends State<ListObjet> {
  static const List<Map<String, String>> exemplesAnnonces = [
    {
      'nom': 'Demande 1',
      'description': 'Description de la demande 1',
      'imageUrl': 'https://picsum.photos/200/200'
    },
    {
      'nom' : 'Demande 2',

    }
  ];

  String? filterType;
  void _filterAnnonces(String type) {
    setState(() {
      filterType = type;
    });
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.map),
                title: const Text('Filtrer par distance'),
                onTap: () {
                  _filterAnnonces('distance');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text('Filtrer par lieu'),
                onTap: () {
                  _filterAnnonces('lieu');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Demandes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: exemplesAnnonces.length,
        itemBuilder: (context, index) {
          // Filtrer les annonces ici si nécessaire
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            shadowColor: Colors.grey.withOpacity(0.5),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exemplesAnnonces[index]['nom'] ?? '',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          exemplesAnnonces[index]['description'] ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                  child: Image.network(
                    exemplesAnnonces[index]['imageUrl'] ?? '',
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return const Text('Could not load image');
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100, right: 15),
        child: FloatingActionButton(
          onPressed: () => _showFilterSheet(context),
          backgroundColor: Colors.blue,
          child: const Icon(Icons.filter_list),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
