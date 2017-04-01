create schema normalized;

create table normalized.Members (
    MemberID bigserial primary key,
    FirstName varchar(100) not null,
    LastName varchar(100) not null,
    District varchar(100) not null,
    Party varchar(100) not null,
    Race varchar(100) null,
    Gender varchar(100) null,
    FirstElectedYear varchar(100) null,
    DateOfBirth varchar(100) null
);

create table normalized.Bill (
    BillID bigserial primary key,
    
);
    
create table normalized.BillSponsors (
    BillSponsorID bigserial primary key,
    BillID bigserial, # References normalized.Bill.BillID,
    SponsorMemberID bigserial # References normalized.Memberes.MemberID
);
