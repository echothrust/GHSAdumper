# GHSAdumper
A simple project grabbing the `github.com/github/advisory-database` repository and converting into into dumps of various formats.

Currently the following list of dumps is generated
* mongodump
* mongoexport
* mysqldump

The following files can be found on each release

**Mongodb**
* `GHSA-reviewed-YYYYMMDD.json`: mongoexport of reviewed only GHSA
* `GHSA-reviewed-ARR-YYYYMMDD.json`: mongoexport as array of reviewed only GHSA
* `GHSA-reviewed-mongodump-$(date +"%Y%m%d").zip`: mongodump produced

**MariaDB**
* `GHSA-reviewed-YYYYMMDD.sql` mysqldump of reviewed only GHSA
  ```sql
  CREATE TABLE `advisories` (
    `id` varchar(35) GENERATED ALWAYS AS (json_compact(json_extract(`doc`,'$._id'))) VIRTUAL,
    `doc` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
    UNIQUE KEY `id` (`id`),
    CONSTRAINT `id_not_null` CHECK (`id` is not null)
  ) ENGINE=InnoDB DEFAULT;
  ```
* `GHSA-reviewed-columns-YYYYMMDD.sql` mysqldump of reviewed only GHSA but with split columns
  ```sql
  CREATE TABLE `advisories` (
    `id` varchar(35) GENERATED ALWAYS AS (json_compact(json_extract(`doc`,'$._id'))) VIRTUAL,
    `doc` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin INVISIBLE DEFAULT NULL,
    `GHSA` char(22) GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.id')))) VIRTUAL,
    `severity` varchar(10) GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.database_specific.severity')))) VIRTUAL,
    `github_reviewed` tinyint(1) GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.database_specific.github_reviewed')))) VIRTUAL,
    `schema_version` char(6) GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.schema_version')))) VIRTUAL,
    `summary` text GENERATED ALWAYS AS (trim(json_unquote(json_compact(json_extract(`doc`,'$.summary'))))) VIRTUAL,
    `details` longtext GENERATED ALWAYS AS (trim(json_unquote(json_compact(json_extract(`doc`,'$.details'))))) VIRTUAL,
    `modified` timestamp GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.modified')))) VIRTUAL,
    `published` timestamp GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.published')))) VIRTUAL,
    `aliases` longtext GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.aliases')))) VIRTUAL,
    `affected` longtext GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.affected')))) VIRTUAL,
    `refs` longtext GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.references')))) VIRTUAL,
    `severities` longtext GENERATED ALWAYS AS (json_unquote(json_compact(json_extract(`doc`,'$.severity')))) VIRTUAL,
    UNIQUE KEY `id` (`id`),
    CONSTRAINT `id_not_null` CHECK (`id` is not null)
  ) ENGINE=InnoDB DEFAULT;
  ```