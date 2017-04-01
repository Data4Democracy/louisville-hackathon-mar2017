/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.data4democracy.ky.bills.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.data4democracy.ky.bills.model.Bill;
import org.data4democracy.ky.bills.model.Legislator;
import org.data4democracy.ky.bills.model.Vote;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

/**
 *
 * @author ahill
 */
public class ProtoDaoImpl implements BillDao, LegislatorDao, VoteDao {

    private JdbcTemplate jdbcTemplate = null;

    public ProtoDaoImpl() {
        jdbcTemplate = new JdbcTemplate();

        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl(System.getenv("DB_URL"));
        dataSource.setUsername(System.getenv("DB_USR"));
        dataSource.setPassword(System.getenv("DB_PW"));

        jdbcTemplate.setDataSource(dataSource);

    }

    public static String SQL_SELECT_ALL_BILLS = "SELECT * FROM public.\"Bills\"";
    @Override
    public List<Bill> getAllBills() {
        return jdbcTemplate.query(SQL_SELECT_ALL_BILLS, new BillMapper());
    }

    
    public static String SQL_SELECT_ALL_BILL_BY_ID = "SELECT * FROM public.\"Bills\" WHERE bill_id = ?";
    @Override
    public Bill getBillByID(String billID) {
        try{
            return jdbcTemplate.queryForObject(SQL_SELECT_ALL_BILL_BY_ID, 
                    new BillMapper(), 
                    billID); 
        } catch (EmptyResultDataAccessException e){
            return null;
        }
    }

    public static String SQL_SELECT_ALL_LEGISLATORS = "SELECT * FROM public.\"Legislators\"";
    
    @Override
    public List<Legislator> getAllLegislators(){
        return jdbcTemplate.query(SQL_SELECT_ALL_LEGISLATORS, new LegislatorMapper());
    }

    public static String SQL_SELECT_LEGISLATOR_BY_ID = "SELECT * FROM public.\"Legislators\" WHERE legislator_id = ?";
    
    @Override
    public Legislator getLegislatorByID(int legislatorID) {
        try{
        return jdbcTemplate.queryForObject(SQL_SELECT_LEGISLATOR_BY_ID, 
                new LegislatorMapper(), 
                legislatorID); 
        } catch (EmptyResultDataAccessException e){
            return null;
        }
    }

    public static String SQL_SELECT_ALL_VOTES = "SELECT * FROM public.\"Votes\"";
    
    @Override
    public List<Vote> getAllVotes() {
        return jdbcTemplate.query(SQL_SELECT_ALL_VOTES, new VoteMapper());
    }

    public static String SQL_SELECT_VOTES_BY_BILL = "SELECT * FROM public.\"Votes\" WHERE bill_id = ?";
    
    @Override
    public List<Vote> getAllVotesByBill(String billId) {
        return jdbcTemplate.query(SQL_SELECT_VOTES_BY_BILL, new VoteMapper(), billId);
    }

    public static String SQL_SELECT_VOTES_BY_LEGISLATOR = "SELECT * FROM public.\"Votes\" WHERE legislator_id = ?";
    @Override
    public List<Vote> getAllVotesByLegislatorId(int legislatorId) {
        return jdbcTemplate.query(SQL_SELECT_VOTES_BY_LEGISLATOR, new VoteMapper(), legislatorId);
    }

    
    public static String SQL_SELECT_VOTES_BY_BILL_AND_LEGISLATOR 
            = "SELECT * FROM public.\"Votes\" WHERE bill_id = ? AND legislator_id = ?";
    
    @Override
    public Vote getVoteByBillAndLegislatorId(String billId, int legislatorId) {
        try{
            return jdbcTemplate.queryForObject(SQL_SELECT_VOTES_BY_BILL_AND_LEGISLATOR, 
                    new VoteMapper(), 
                    billId,
                    legislatorId); 
        } catch (EmptyResultDataAccessException e){
            return null;
        }
    }

        private static final class VoteMapper implements RowMapper<Vote> {
        @Override
        

    //    bill_id text COLLATE pg_catalog."default",
//    legislator_id integer,
//    "MemberName" text COLLATE pg_catalog."default",
//    "BillName" text COLLATE pg_catalog."default",
//    "Vote" text COLLATE pg_catalog."default"
        public Vote mapRow(ResultSet rs, int rowNum) throws SQLException {
            Vote words = new Vote();
            
            words.setBillId(rs.getString("bill_id"));
            words.setBillName(rs.getString("BillName"));
            
            words.setLegislatorId(rs.getInt("legislator_id"));
            words.setLegislatorName(rs.getString("MemberName"));
            
            words.setVote(rs.getString("Vote"));
            
            return words;
        }
    }
    private static final class BillMapper implements RowMapper<Bill> {
        @Override
        

//    bill_id text COLLATE pg_catalog."default",
//    "BillNumber" text COLLATE pg_catalog."default",
//    "SessionID" text COLLATE pg_catalog."default"
        public Bill mapRow(ResultSet rs, int rowNum) throws SQLException {
            Bill daLaw = new Bill();
            daLaw.setBillId(rs.getString("bill_id"));
            daLaw.setBillNumber(rs.getString("BillNumber"));
            daLaw.setSessionID(rs.getString("SessionID"));
            return daLaw;
        }
    }

    
    private static final class LegislatorMapper implements RowMapper<Legislator> {

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
        
        @Override
        public Legislator mapRow(ResultSet rs, int rowNum) throws SQLException {
                Legislator politicalMinion = new Legislator();
                
                politicalMinion.setId(rs.getInt("legislator_id"));
                
                politicalMinion.setFirstName(rs.getString("FirstName"));
                politicalMinion.setLastName(rs.getString("LastName"));
                
                politicalMinion.setFullName(rs.getString("Full.Name"));
                politicalMinion.setInitialName(rs.getString("Initial.Name"));
                
                politicalMinion.setFirstElected(rs.getInt("First.Elected"));
                
                politicalMinion.setGender(rs.getString("Gender"));
                politicalMinion.setRace(rs.getString("Race"));

                politicalMinion.setDateOfBirth(rs.getString("DOB"));
                politicalMinion.setDistrict(rs.getString("District"));
                politicalMinion.setParty(rs.getString("Party"));

                return politicalMinion;
        }

    }
}
