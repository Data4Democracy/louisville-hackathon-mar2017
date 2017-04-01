/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.data4democracy.ky.bills.dao;

import java.util.List;
import org.data4democracy.ky.bills.model.*;

/**
 *
 * @author ahill
 */
public interface LegislatorDao {
    
    public List<Legislator> getAllLegislators();
    public Legislator getLegislatorByID(int legislatorID);
    
}
