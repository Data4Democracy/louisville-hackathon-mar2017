/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.data4democracy.ky.bills.model;

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
public class Vote {
//    bill_id text COLLATE pg_catalog."default",
//    legislator_id integer,
//    "MemberName" text COLLATE pg_catalog."default",
//    "BillName" text COLLATE pg_catalog."default",
//    "Vote" text COLLATE pg_catalog."default"
    private String billId;
    private String billName;
    
    private int legislatorId;
    private String legislatorName;
    
    private String vote;
    
}
