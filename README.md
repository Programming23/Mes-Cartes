## Introduction

**Mes cartes** est une application qui aide les utilisateurs à améliorer leurs compétences d'apprentissage en créant des cartes éducatives pour favoriser l'apprentissage et la mémorisation. L'application permet aux utilisateurs de créer des cartes éducatives pour n'importe quel sujet qu'ils souhaitent apprendre. Elle dispose d'une interface utilisateur simple et intuitive, et utilise la technologie SQFLite pour gérer les bases de données locales, ce qui la rend rapide et efficace pour le stockage et la récupération des données. Les utilisateurs peuvent apprendre de manière amusante et efficace, à tout moment et en tout lieu.

## À propos des données

L'application fonctionne de manière intégrée avec SQFLite, une bibliothèque de gestion de bases de données locales pour les applications mobiles. Cette bibliothèque permet à l'application de stocker et de récupérer les informations de manière rapide et efficace, garantissant une expérience utilisateur fluide et performante. Les utilisateurs peuvent facilement ajouter, modifier et supprimer des cartes éducatives.

## Sources des graphiques

- **Logo de l'application** : Il s'agit d'une image modifiée du logo de l'application. Vous pouvez la trouver sur [Pinterest](https://www.pinterest.com/pin/878272364808420746/).
- **Police utilisée** : *Cairo* - [Google Fonts - Cairo](https://fonts.google.com/specimen/Cairo).
- **Icônes utilisées** : Les icônes sont fournies par Flutter.

## Préparation de l'application

Avant de commencer à modifier l'application, vous devez d'abord la configurer. Assurez-vous d'installer l'environnement de développement Flutter et de vérifier que toutes les bibliothèques et dépendances nécessaires sont bien installées.

## Modification de l'application

Vous pouvez personnaliser l'application en modifiant les éléments suivants :
- **Couleurs**, **polices** et **icônes**.
- Vous pouvez changer la police utilisée en téléchargeant la police souhaitée dans le dossier `assets` sous le nom `font.ttf`.
- Les images peuvent être modifiées dans le dossier `assets`.
- Les couleurs, tailles de texte et autres paramètres peuvent être modifiés dans le fichier `lib/constants/theme.dart`, plus précisément dans la variable `theme`.

## Rôles des fichiers

Pour personnaliser l'application, vous devez travailler avec les fichiers dans le dossier `lib`. Voici un aperçu des fichiers et dossiers importants :

### `main.dart`

Le fichier principal de l'application.

### `db_helper.dart`

Ce fichier gère la base de données, créant deux tables : "Groupes" et "Cartes éducatives". Il fournit des fonctions pour sauvegarder, récupérer et supprimer des données.

### `model.dart`

Ce fichier définit les modèles de données utilisés dans l'application, tels que les classes `FlashcardSet` et `Flashcard`. Ces modèles sont utilisés pour sauvegarder et récupérer les données des cartes et des groupes.

### Dossier `constants`

Ce dossier contient les fichiers permettant de personnaliser les couleurs, les polices et autres paramètres du texte :
- `numbers.dart` : Modifie la durée de la page d'attente et les dimensions des images.
- `texts.dart` : Modifie les chemins des images et les textes dans l'application.
- `theme.dart` : Modifie les couleurs, les tailles de police et autres aspects du thème.

### Dossier `screens`

Le dossier contenant les pages principales de l'application :
- `about_us.dart` : Crée l'interface utilisateur pour la page "À propos de nous".
- `loading_page.dart` : Affiche une page de chargement avec le logo de l'application.
- `home.dart` : Affiche la page d'accueil avec la liste des groupes de cartes.
- `flashcard_page.dart` : Permet d'ajouter et de consulter des cartes dans un groupe.
- `add_flashcard.dart` : Page pour ajouter ou modifier une carte éducative.
- `add_flashcard_set.dart` : Page pour ajouter ou modifier un groupe de cartes éducatives.
- `search.dart` : Permet de rechercher des groupes de cartes éducatives.

### Dossier `widgets`

Ce dossier contient des composants réutilisables pour simplifier l'interface :
- `navigation.dart` : Aide à la navigation entre les pages de l'application.
- `body_sets.dart` : Affiche le corps de la page des groupes de cartes.

## Contribuer

Si vous souhaitez contribuer à l'application, n'hésitez pas à soumettre une pull request. Avant de commencer, assurez-vous que l'application fonctionne correctement sur votre machine de développement et que toutes les dépendances sont à jour.
