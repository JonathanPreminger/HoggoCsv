# README

BrokerApp

Après avoir download le repo, cd inside, bundle, rails s et dans deux autres consoles : redis-server, bundle exec sidekiq.
Pour l’import, utiliser le Csv fourni.

1 - Choix sur le produit

2 - L’importation du CSV

3 - L’asynchronisation des requêtes à l’Api Siren

4 - La recherche permettant d’accéder au show

5 - La page show

6 - La carte des clusters à l’index

7 - Les validations et scopes sur le model Broker

8 - Sécurité 

9 - Test unitaires

10 - Limites et prolongement


1 - Choix sur le produit
La fonctionnalité principale de l’app est la cartographie des courtiers en France à partir d’une liste de siren en Csv.
Pour cela l’app nous donne la possibilité d’importer une liste de numéros siren au format Csv.
L’app va ensuite interroger une Api afin de récupérer des données complémentaires relatives notamment à la géolocalisation. 
Parmi les autres informations récupérées on trouve le nom et l'adresse complète du courtier.
Nous avons décidé de ne pas fournir la possibilité de créer, d’éditer ou de supprimer un courtier directement dans l’app : la data venant de sources externes professionnelles il semblait naturel de s’y référer strictement.
Une feature de recherche nous permet de cibler un courtier en particulier.
L’expérience utilisateur est amélioré grâce à l’asynchronisation des requêtes à l’Api.
À la racine on trouvera la page index.

2 - L’importation du CSV
Comme expliqué juste au-dessus du bouton d’importation, la BrokerApp va, juste après avoir importé le CSV, requêter une Api afin de récupérer des informations complémentaires. 
L’importation se fait en une seule requête sur la base de donnée, ce qui rend l’import très rapide. 
Après l’import nous sommes redirigés sur l’index et un message flash nous indique si tout s’est bien passé ou au contraire si des brokers n’ont pu être importés.
Le code de l’import se trouve dans un module pour ne pas surcharger le controlleur et lui laisser gérer uniquement les interactions liées aux requêtes.

3 - L’asynchronisation des requêtes à l’Api Siren
La partie requête à l’API se fait par l’intermédiaire d’un worker, et de manière asynchrone, il faut donc faire tourner sidekiq (bundle exec sidekiq) et un serveur redis (redis-server) pour que le worker se lance. 
L’idée est de fournir la meilleure expérience possible à l’utilisateur et d’éviter de tomber sur une erreur du type ‘request timeout’. 
Le code des calls à l’API est situé dans une classe dédiée: dans une classe InseeApi placé dans le dossier lib, elle est considérée comme étant un service.

4 - La recherche permettant d’accéder au show

Une fois les données chargées, on peut effectuer une recherche par numéro de siren dans la barre de recherche située dans la navbar. 
On est soit redirigé vers une page show si le numéro de siren existe en base, soit on est redirigé vers l’index et un message flash nous indique que ce numéro de siren n’existe pas en base.
Une fois que l’on se trouve sur la page show d’un siren, on peut directement re-faire une recherche sans revenir à la page index (c’est là tout l’intérêt de mettre la barre de recherche dans la navbar).
Le code relatif à la recherche se trouve dans un module séparé.


5 - La page show
La page show présente une modal contenant la carte de localisation du broker, son nom complet, son adresse complète et son numéro de siren.
Un breadcrumb permet de savoir où l’on se trouve dans l’archi de l’app et donne la possibilité de retourner sur la page Home.

6 - La carte des clusters à l’index 
Une fois les données chargées, l’index nous donne à voir une carte du monde centré sur Paris, avec tous les brokers géolocalisés (seulement sur ceux possédant une latitude et longitude, on utilise pour ça un scope afin éviter de rechercher sur l’ensemble des broker). 
Ils sont agrégés en cluster en fonction de l’échelle à laquelle on se trouve afin d’améliorer la lisibilité de la carte. 
Les clusters se réorganisent au fur et à mesure que l’on zoom ou dé-zoom. 
L’api de google permet une fois notre token d’accès récupéré d’obtenir cette carte interactive. Le javascript nécessaire est placé dans un partial puis render dans la view index. 

7 - Les validations et scopes sur le model Broker
Des validations sont requises sur le champ siren des brokers : elles vérifient leur présence, leur unicité et leur format.
Un scope a été créé sur les Broker possédant des données de localisation, ce qui permet au moment de la cartographie de n’envoyer que des Broker pouvant être localisés. 
Choix à discuter avec le product owner : le scope n’a, par contre, pas été utilisé pour la recherche, on part du principe que même si un Broker n’est pas localisé il doit être accessible en recherche.

8 - Sécurité 
Les tokens d’accès sont placés dans un fichier secrets.yml qui est lui-même listé dans le .gitignore. Le but ici étant de ne pas exposer au monde nos clé d’accès et ainsi d’éviter que l’on récupère des donnés critiques.

9 - Test unitaires
Pour les lancer : ‘rspec’ ou ‘bundle exec rspec’.
Des tests unitaires ont été effectués sur le model Broker, notamment sur au moment de la création, on a vérifié que les validations étaient bien fonctionnelles.

10 - Limites et prolongement
La principale limite de l’app concerne les calls à l’Api. On ne peut effectuer 25 000 calls à l’Api dans un temps restreints. 
En l’état, l’app fait 25 calls à partir des 25 premiers siren de la liste importée. Cela permet d’avoir un aperçu de toutes les features présentes sur l’app.
Parmi les solutions que l’on peut proposer : 
La première est d’augmenter les calls jusqu’à 25 000 en mettant des ‘wait’ tous les 25 calls, de façon à ce que l’Api ne bloque pas les calls. L’UX n’en serait pas affecté et ce grâce à l’asynchronisation.
La deuxième est de trigger le call à l’Api au moment d’une recherche (et donc de l’action show). Ainsi un call est effectué à l’Api seulement si le broker en question ne possède pas de champs latitude ou longitude. Cela permet de populate progressivement la bdd au fur et à mesure des recherches. Merci de votre attention.

Merci de votre attention.










