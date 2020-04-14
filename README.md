# Test de recrutement backend

## Passer le Test

Clonez le repo sur votre ordinateur. Réalisez l'exercice et commitez vos modifications. Quand vous avez fini, envopyez-nous par email l'intégralité du dossier dans une archive .zip

## Installer le Test

#### Prérequis

Vous devez avoir `docker` et `docker-compose` installé sur votre ordinateur. Voir : https://docs.docker.com/get-docker/

#### Installation

Lancez les commandes suivantes :
* Lancer le serveur : `docker-compose up`
  * *La première fois, docker va builder les images. Les fois suivantes, docker va utiliser les images déjà build. Pour forcer un rebuild, utiliser `docker-compose up --build`*
  * Les containers disponibles sont `db` pour la base de donnée postgres, et `web` pour le serveur rails.
* Créer, migrer et seeder la DB :
  * `docker-compose run web rake db:create`
  * `docker-compose run web rake db:migrate`
  * `docker-compose run web rake db:seed`

> Le fichier de seed contient des commentaires qui vous permettrons de mieux comprendre le rôle et les interactions des différents modèles.

> Attention, il semble qu'il y ait un bug sur le fichier de seed, seul le premier `Ride` est crée. C'est bizzare...

#### Premiers pas

Maintenant que votre appli est lancée, vous pouvez utiliser l'API GraphQL en allant sur http://localhost:3000/graphiql.

> Il existe d'autres façons d'utiliser l'API GraphQL qui peuvent être un peu plus sympatiques que l'interface de Graph*i*QL, par exemple l'extension chrome Altair : https://chrome.google.com/webstore/detail/altair-graphql-client/flnheeellpciglgpaodhkhmapeljopja

Pour vous mettre en jambe, voici quelques exemples de requêtes GraphQL que vous pouvez faire :

###### Récupérer les `User`
```
query{
  users {
    id
    email
    driverRides{
      id
      ride{
        departure
        arrival
      }
      passengerRides{
        id
        user{
          id
          email
        }
      }
    }
    passengerRides{
      id
      ride{
        departure
        arrival
      }
      driverRide{
        user{
          id
          email
        }
      }
    }
  }
}
```
###### Créer un `DriverRide`
```
mutation{
  createDriverRide(
    input: {
    	userId: 7,
    	rideId: 9
  	}
  ){
    driverRide{
      id
    }
    errors
  }
}
```

###### Créer un `PassengerRide`
```
mutation{
  createPassengerRide(
    input: {
    	userId: 7,
    	rideId: 9
  	}
  ){
    passengerRide{
      id
    }
    errors
  }
}
```

###### Associer un `DriverRide` et un `PassengerRide`
```
mutation{
  shareRide(
    input: {
    	driverRideId: 7,
    	passengerRideId: 8
  	}
  ){
    passengerRide{
      id
      driverRide{
        id
      }
    }
    errors
  }
}
```

## L'exercice

Avant de commencer, un petit avertissement. Cette applications est relativement vielle, plusieurs développeurs y ont contribué, parfois des juniors, et parfois on a été un peu pressé par le temps lors des reviews. Il est donc possible de rencontrer du *code legacy*.

Si vous voyez du code qui pourrait être amélioré, n'hésitez pas à le faire. Mais pas besoin non plus de recoder toute l'application. Même si c'est moche, ça marche, et il faut bien qu'on avance malgré tout.

Maintenant que ça c'est dit, voyons quelle sera votre tâche ...

...

...

[suspense]

...


#### Les `Network` !

Chance ! Vous êtes tombé sur le ticket que tout le monde rêve de faire depuis des semaines : ajouter les `Networks`.

Pour faire un récap rapide, on a des `Ride` qui sont des 'trajets' possibles pour nos utilisateurs. Les conducteurs vont déclarer qu'ils passent par un 'trajet' et qu'il sont disposés à prendre des passagers avec eux dans leur voiture. Et les passagers vont déclarer qu'ils attendent au point de départ d'un 'trajet' pour qu'un conducteur vienne les chercher.

Sauf que dernièrement (l'équipe commerciale fait un boulot super), on a de plus en plus de `Ride` qui ouvrent et ça n'a pas vraiment de sens d'afficher sur l'application mobile des `Ride` à Paris pour des utilisateurs Toulousains par exemple.

Pour régler ce problème, on a décidé de mettre en place des `Network`. Chaque `Ride` sera associé à un `Network`.

Comme ça on pourra avoir un `Network` "Toulouse" qui ne renverra que les `Ride` sur la région de Toulouse. Et un autre pour Paris, et toutes les autres villes.

On veut aussi associer les `User` aux `Network`. Chaque utilisateur est lié à un seul `Network`. Comme ça on saura où sont nos utilisateurs et sur quel réseau on doit gérer les paiements (feature en wip ;)).

Il faut aussi modifier l'API GraphQL. Comme on va avoir une app mobile par `Network`, on veut ajouter un `current_network` qui doit être disponible dans toute l'API. Le `current_network` sera récupéré à partir d'un header http (qui est encodé bien entendu).

Toutes les queries qui existent doivent renvoyer leurs résultats en fonction du `current_network` qui sera envoyé. Et il faut aussi que les créations d'objet enregistrent le `current_network` si besoin.

On veut aussi vérifier la cohérence des données qui rentrent dans l'API. Par exemple il ne doit pas être possible qu'un `User` d'un réseau puisse faire une demande pour un `Ride` d'un autre réseau. Ou qu'un conducteur d'un réseau prenne un pâssager d'un autre réseau.

Bref, vous avez compris.

Ha oui, et bien entendu il faudra rajouter les tests rspec qui vont bien.

Donc si je résume :
* Créer un modéle `Network`
* Ajouter le `current_network` dans le controller `graphql_controller` qui récupére le `Network` à partir d'un header http.
* Modifier les différents points d'API
  * Les queries ne renvoient que les objets associée au `current_network`
  * Les mutations ajoutent le `current_network` dans les créations d'objet si besoin
  * On conserve la cohérence des données
* Rajouter les tests rspec qui vont bien

C'est parti ! Vous avez 18 minutes pour finir !

(hihi)

Non en fait c'était une blague. Vous prenez le temps que vous voulez pour finir. Juste faut le finir avant l'entretient.

Et pour vous motiver, voici un gif rigolo : 

![alt text](http://francheska45.f.r.pic.centerblog.net/ea6ae6d2.gif)

Merci !
