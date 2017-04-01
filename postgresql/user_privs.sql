#
# There are three users; only the password for the "user" (read-only) account is needed for most uses
# Default privs are as below:
#

alter default privileges in schema public grant select on tables to iheartuser;
alter default privileges in schema public grant all on tables to iheartroot;
alter default privileges in schema public grant all on tables to iheartpower;

grant select on all tables in schema public to iheartuser;
grant all on all tables in schema public to iheartroot;
grant all on all tables in schema public to iheartpower;
