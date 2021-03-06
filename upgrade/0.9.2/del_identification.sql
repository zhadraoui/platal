ALTER TABLE auth_user_md5 MODIFY perms enum('user', 'admin', 'ext', 'non-inscrit') NOT NULL DEFAULT 'user';
ALTER TABLE auth_user_md5 ADD COLUMN matricule_ax char(8) NULL DEFAULT NULL AFTER matricule;
ALTER TABLE auth_user_md5 ADD COLUMN nom_ini char(255) NOT NULL DEFAULT '' AFTER promo;
ALTER TABLE auth_user_md5 ADD COLUMN prenom_ini char(40) NOT NULL DEFAULT '' AFTER nom_ini;
ALTER TABLE auth_user_md5 ADD COLUMN nom_ini_soundex char(4) NOT NULL DEFAULT '' AFTER prenom_ini;
ALTER TABLE auth_user_md5 ADD COLUMN prenom_ini_soundex char(4) NOT NULL DEFAULT '' AFTER nom_ini_soundex;
ALTER TABLE auth_user_md5 ADD COLUMN comment char(10) NOT NULL DEFAULT '';
ALTER TABLE auth_user_md5 ADD COLUMN appli char(10) NOT NULL DEFAULT '';
ALTER TABLE auth_user_md5 ADD COLUMN flags set('femme') NOT NULL DEFAULT '' AFTER prenom_ini_soundex;
ALTER TABLE auth_user_md5 ADD COLUMN last_known_email char(60) NOT NULL DEFAULT '';
ALTER TABLE auth_user_md5 ADD COLUMN deces date NOT NULL AFTER flags;
UPDATE auth_user_md5 AS a INNER JOIN identification AS i ON (a.matricule = i.matricule) SET a.matricule_ax = i.matricule_ax, a.nom_ini = i.nom, a.prenom_ini = i.prenom, a.nom_ini_soundex = i.nom_soundex, a.prenom_ini_soundex = i.prenom_soundex, a.comment = i.comment, a.appli = i.appli, a.flags = i.flags, a.last_known_email = i.last_known_email, a.deces = i.deces;
INSERT INTO auth_user_md5 (matricule, matricule_ax, promo, nom, prenom, nom_ini, prenom_ini, nom_ini_soundex, prenom_ini_soundex, comment, appli, flags, last_known_email, deces, perms) SELECT i.matricule, i.matricule_ax, i.promo, i.nom, i.prenom, i.nom, i.prenom, i.nom_soundex, i.prenom_soundex, i.comment, i.appli, i.flags, i.last_known_email, i.deces, 'non-inscrit' FROM identification AS i LEFT JOIN auth_user_md5 AS a ON a.matricule = i.matricule WHERE a.user_id IS NULL;
DROP TABLE identification;

alter table auth_user_md5 add index (epouse);
