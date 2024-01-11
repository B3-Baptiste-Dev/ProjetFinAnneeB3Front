import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Logique pour éditer le profil
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Logique pour se déconnecter
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Mettez ici l'URL de l'image du profil
            ),
            SizedBox(height: 20),
            Text(
              'Nom d\'utilisateur',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 4),
            Text(
              'user@example.com', // L'adresse email de l'utilisateur
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logique pour modifier le profil
              },
              child: Text('Modifier le profil'),
            ),
          ],
        ),
      ),
    );
  }
}
