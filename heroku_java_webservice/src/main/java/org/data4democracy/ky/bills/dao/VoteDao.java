/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.data4democracy.ky.bills.dao;

import java.util.List;
import org.data4democracy.ky.bills.model.Vote;

/**
 *
 * @author ahill
 */
public interface VoteDao {
    public List<Vote> getAllVotes();
    public List<Vote> getAllVotesByBill(String billId);
    public List<Vote> getAllVotesByLegislatorId(int legislatorId);
    
    public Vote getVoteByBillAndLegislatorId(String billId, int legislatorId);
}
