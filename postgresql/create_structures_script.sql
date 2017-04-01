# V0.0.0.0.0.1.  Most everything is a varchar(100) just to test loading.
# nothing is normalized.
# iterate iterate iterate!

create table Members (
    ID bigserial primary key,
    FirstName varchar(100) not null,
    LastName varchar(100) not null,
    District varchar(100) not null,
    Party varchar(100) not null,
    Race varchar(100) null,
    Gender varchar(100) null,
    FirstElectedYear varchar(100) null,
    DateOfBirth varchar(100) null
);




# 
# Grant privileges!
#

GRANT SELECT ON ALL TABLES IN SCHEMA public TO iheartuser;
