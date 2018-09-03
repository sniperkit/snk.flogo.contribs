# REFERENCES

## Configuration Managers

### Golang
- https://github.com/skurik/sphinx-reindexer (Nice!)
    - TCP server accepting requests to reindex a specific Sphinx index, waiting for it to be rotated by searchd
- https://github.com/skurik/seraph (Nice!)
    - Seraph, the Sphinx config manager. Exposed as a RESTful web service.
    - https://github.com/skurik/seraph/blob/master/config.go (Nb. Sphinx struct)

## TSV/CSV Pipelines
- github.com/stefobark/index_tsv

## Regex
- https://github.com/nicholaslocascio/deep-regex/blob/master/datasets/KB13/targ.txt


ID,Platform,Name,Created Timestamp,Updated Timestamp,Description,Keywords,Homepage URL,Licenses,Repository URL,Versions Count,SourceRank,Latest Release Publish Timestamp,Latest Release Number,Package Manager ID,Dependent Projects Count,Language,Status,Last synced Timestamp,Dependent Repositories Count,Repository ID,Repository Host Type,Repository Name with Owner,Repository Description,Repository Fork?,Repository Created Timestamp,Repository Updated Timestamp,Repository Last pushed Timestamp,Repository Homepage URL,Repository Size,Repository Stars Count,Repository Language,Repository Issues enabled?,Repository Wiki enabled?,Repository Pages enabled?,Repository Forks Count,Repository Mirror URL,Repository Open Issues Count,Repository Default branch,Repository Watchers Count,Repository UUID,Repository Fork Source Name with Owner,Repository License,Repository Contributors Count,Repository Readme filename,Repository Changelog filename,Repository Contributing guidelines filename,Repository License filename,Repository Code of Conduct filename,Repository Security Threat Model filename,Repository Security Audit filename,Repository Status,Repository Last Synced Timestamp,Repository SourceRank,Repository Display Name,Repository SCM type,Repository Pull requests enabled?,Repository Logo URL,Repository Keywords
1,Alcatraz,21st digital Templates,2015-01-11 23:56:18 UTC,2018-03-12 01:03:55 UTC,"A starting point for stripped down, structured and nib-less iOS applications including support for CocoaPods and Uncrustify.","",https://github.com/21stdigital/Xcode-Templates,"",https://github.com/21stdigital/Xcode-Templates,0,2,2018-03-12 01:03:38 UTC,,,0,Objective-C,,2018-03-12 01:03:54 UTC,0,3945,GitHub,21stdigital/Xcode-Templates,"Stripped down, structured, nib-less project & file templates",false,2014-07-16 19:33:01 UTC,2017-05-10 09:26:03 UTC,2014-07-20 22:11:52 UTC,,172,13,Objective-C,true,false,false,1,,0,master,4,21914226,,,1,README.md,"","","","","","",,2017-04-20 00:24:04 UTC,3,GitHub,,git,,,""

LOAD DATA LOW_PRIORITY LOCAL INFILE '/Volumes/HardDrive/datasets/libraries.io/csv/projects.csv' IGNORE INTO TABLE projects
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES ()

head -n 1 /Volumes/HardDrive/datasets/libraries.io/csv/projects_with_repository_fields-1.2.0-2018-03-12.csv | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g; s/ Timestamp/_at/g;' | awk '{print "("$1")"}'

eg:

head -n 50 /Volumes/HardDrive/datasets/libraries.io/csv/projects_with_repository_fields-1.2.0-2018-03-12.csv > /Volumes/HardDrive/datasets/libraries.io/csv/projects_with_repository_fields_50_lines.csv

LOAD DATA LOW_PRIORITY LOCAL INFILE '/Volumes/HardDrive/datasets/libraries.io/csv/projects_with_repository_fields_50_lines.csv' IGNORE INTO TABLE projects_with_repository_fields
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES (id,platform,name,created_timestamp,updated_timestamp,description,keywords,homepage_url,licenses,repository_url,versions_count,sourcerank,latest_release_publish_timestamp,latest_release_number,package_manager_id,dependent_projects_count,language,status,last_synced_timestamp,dependent_repositories_count,repository_id,repository_host_type,repository_name_with_owner,repository_description,repository_fork?,repository_created_timestamp,repository_updated_timestamp,repository_last_pushed_timestamp,repository_homepage_url,repository_size,repository_stars_count,repository_language,repository_issues_enabled?,repository_wiki_enabled?,repository_pages_enabled?,repository_forks_count,repository_mirror_url,repository_open_issues_count,repository_default_branch,repository_watchers_count,repository_uuid,repository_fork_source_name_with_owner,repository_license,repository_contributors_count,repository_readme_filename,repository_changelog_filename,repository_contributing_guidelines_filename,repository_license_filename,repository_code_of_conduct_filename,repository_security_threat_model_filename,repository_security_audit_filename,repository_status,repository_last_synced_timestamp,repository_sourcerank,repository_display_name,repository_scm_type,repository_pull_requests_enabled?,repository_logo_url,repository_keywords)

col1,col2,coln )