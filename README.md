# scriptOCprojet3
Récupérer la liste des groupes dont un utilisateur est membre.

***
# Pour Commencer
Ce script a été réalisé dans le cadre d'un projet "script 3" projet 7 pour OpenClassrooms
Le script est accompagné du fichier usergroupe.csv, comme exemple.

***

# Pré-requis
serveur Windows 2019 avec Active Directory

Création d'un fichier usergroupe.CSV encodée UF8 avec ; comme séparateur. La conversion du fichier peut etre réalisé depuis Excel.

Le fichier sera placé dans le répertoire c:\Scripts\AD_USERS

Le script fonctionne aussi bien en silencieux que en mode interactif, le détail d'utilisation est expliqué dans le paragraphe suivant.


***

# Démarrage
comment on lance le script

1.Script Silencieux
Le script se lance soit de manière silencieuse de la manière suivante ./script3.ps1 , ou ./script3.ps1 > usergroupe.txt si l'on veut récupérer le résultat du script.

2.Script Interactif
./script3.ps1 suivi d'un nom d'un utilisateur. Par exemple ./script3.ps1 user
Il suffit d'indiquer le nom d'un utilisateur.


***
# Installation / Explication 
étapes pour installer le script

Une seule fonction GetListeGrp.

Détection d'un argument à la fin du lancement du script , si l'argument est vide, on effectue l'importation du fichier usergroupe.csv.
Dans le cadre du projet, il est demandé de donner les membres d'un seul utilisateur de l'OU, mais le fichier peut etre utilisé pour plusieurs utilisateurs.
Le fichier usergroupe.csv se compose du Nom, Prenom comme titre. Le fichier CSV du script1github pourrait etre utliisé.

Si l'argument n'est pas vide, nom d'un seul utilisateur. Le script donne le nom des groupes de l'utilisateur que l'on désire. Ensuite on obtient le résultat demandé.

Ajout d'une condition, qui teste s'il y a une erreur dans le déroulement du script.
Elle renvoi un code ok , si tout c'est dérouler correctement, ou un code 1 en cas d'erreur, avec l'explication de l'erreur $error[0] et éventuellement le code de la commande incorrecte, renvoi les Exit Code de la commande. 

***

# Fabriqué 
PowerShell
Visual Studio Code

***

# Contributeurs et Auteur
REIFFSTECK Laurent Auteur 
BINAND Olivier Mentor OpenClassrooms

***

# Licence
libre de droit
