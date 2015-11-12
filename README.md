# TP 8 : Évolution de la base de données

1. Bootstrap de l'environnement grâce au script ``bootstrap.sh``.<br/>
   - Récupération et extraction des outils flyway (cli)
   - Récupération d'une image MySQL
   - Démarrage de l'image MySQL avec un volume de donnée
2. Run ``./mysql-shell`` and ``SHOW DATABASES;`` to make sure it has been created.
3. Complete the ``flyway.conf`` file to point to the database
4. Init the database and run the first migration with ``./flyway migrate``
5. Add a new SQL script to insert some datas (look at the ``templates/V2_Inserts.sql``)
6. Run a migration and verify it has inserted data (using ``./mysql-shell`` and SQL commands).
7. Add a new SQL script to **add a description column to the TODO table**.
8. Again, run the migration and validate your schema is up-to-date.

