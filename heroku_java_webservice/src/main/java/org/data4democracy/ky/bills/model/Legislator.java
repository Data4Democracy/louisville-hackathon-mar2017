/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.data4democracy.ky.bills.model;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 *
 * @author ahill
 */

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class Legislator {

//    legislator_id integer,
//    "FirstName" text COLLATE pg_catalog."default",
//    "LastName" text COLLATE pg_catalog."default",
//    "District" text COLLATE pg_catalog."default",
//    "Full.Name" text COLLATE pg_catalog."default",
//    "Party" text COLLATE pg_catalog."default",
//    "Race" text COLLATE pg_catalog."default",
//    "Gender" text COLLATE pg_catalog."default",
//    "First.Elected" integer,
//    "DOB" text COLLATE pg_catalog."default",
//    "Initial.Name" text COLLATE pg_catalog."default"
    private int id;
    
    private String firstName;
    private String lastName;
    private String fullName;
    private String initialName;
    
    private String district;
    private String party;
    
    private String race;
    private String gender;
    private String dateOfBirth;
    
    private int firstElected;

}
