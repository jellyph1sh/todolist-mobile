# TodoList App

Une application Flutter simple pour gérer une liste de tâches avec persistance des données grâce à SQLite.

## Fonctionnalités

- Ajouter une tâche avec un titre.
- Marquer une tâche comme terminée ou non terminée.
- Modifier une tâche existante.
- Supprimer une tâche.
- Persistance des données : les tâches sont sauvegardées localement dans une base de données SQLite.

## Technologies utilisées

- **Flutter** : Framework pour le développement multiplateforme.
- **Sqflite** : Bibliothèque pour la gestion de la base de données SQLite.
- **Freezed** : Génération de modèles immuables et gestion des données.
- **JsonSerializable** : Sérialisation et désérialisation des données JSON.

## Prérequis

Avant de lancer l'application, assurez-vous d'avoir installé les outils suivants :

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Un éditeur de code comme [Visual Studio Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio)
- Un émulateur ou un appareil physique pour tester l'application.

## Installation

1. Clonez ce dépôt sur votre machine locale :

   ```bash
   git clone https://github.com/votre-utilisateur/todo_list.git
   cd todo_list
   ```

2. Installez les dépendances Flutter :

   ```bash
   flutter pub get
   ```

3. Générez les fichiers nécessaires pour Freezed et JsonSerializable :

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Lancez l'application :

   - Connectez un appareil physique ou démarrez un émulateur.
   - Exécutez la commande suivante pour démarrer l'application :

     ```bash
     flutter run
     ```

## Structure du projet

- **`lib/`** : Contient le code source de l'application.
  - **`main.dart`** : Point d'entrée de l'application.
  - **`add_task.dart`** : Écran pour ajouter une nouvelle tâche.
  - **`database.dart`** : Gestion de la base de données SQLite.
  - **`models/todo_model.dart`** : Modèle de données pour les tâches, utilisant Freezed.
- **`pubspec.yaml`** : Fichier de configuration des dépendances.

## Fonctionnement

1. **Ajouter une tâche** : Cliquez sur le bouton flottant "+" pour ouvrir l'écran d'ajout de tâche. Entrez un titre et cliquez sur "Ajouter".
2. **Modifier une tâche** : Cliquez sur l'icône de crayon à côté d'une tâche pour la modifier.
3. **Supprimer une tâche** : Cliquez sur l'icône de poubelle pour supprimer une tâche.
4. **Marquer comme terminée** : Cochez ou décochez une tâche pour changer son état.

## Auteur

Créé par **JellyPh1sh**.

## Licence

Ce projet est sous licence MIT. Consultez le fichier [LICENSE](LICENSE) pour plus d'informations.