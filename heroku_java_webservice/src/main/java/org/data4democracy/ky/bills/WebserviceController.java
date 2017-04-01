
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.data4democracy.ky.bills.dao.ProtoDaoImpl;
import org.data4democracy.ky.bills.model.Bill;
import org.data4democracy.ky.bills.model.Legislator;
import org.data4democracy.ky.bills.model.Vote;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author ahill
 */
@Controller
@EnableAutoConfiguration
public class WebserviceController {

    private ProtoDaoImpl dao = new ProtoDaoImpl();

//    @RequestMapping("/votes")
//    @ResponseBody
//    public List<Vote> allVotes(){
//        return dao.getAllVotes();
//    }
    
    @RequestMapping("/votes/record/legislator/{legislator_id}")
    @ResponseBody
    public Map allLegislatorVotingRecord(@PathVariable("legislator_id") int legislatorId){
        Map<String, Object> votingRecord = new HashMap<>();
        votingRecord.put("legislator", dao.getLegislatorByID(legislatorId));
        List<Vote> votes = dao.getAllVotesByLegislatorId(legislatorId);
        
        List<String> billsVoted =
        votes.stream().filter( v -> v.getVote().equalsIgnoreCase("yay") || v.getVote().equalsIgnoreCase("yea"))
                      .map(Vote::getBillName)
                      .collect(Collectors.toList());
        
        votingRecord.put("yay", billsVoted);
        
        billsVoted =
        votes.stream().filter( v -> v.getVote().equalsIgnoreCase("nay"))
                      .map(Vote::getBillName)
                      .collect(Collectors.toList());
        
        votingRecord.put("nay", billsVoted);
        
        return votingRecord;
    }
    
    @RequestMapping("/votes/legislator/{legislator_id}")
    @ResponseBody
    public List<Vote> allVotesByLegislator(@PathVariable("legislator_id") int legislatorId){
        return dao.getAllVotesByLegislatorId(legislatorId);
    }
    
    @RequestMapping("/votes/bill/{bill_id}")
    @ResponseBody
    public List<Vote> allVotesByBill(@PathVariable("bill_id") String billId){
        return dao.getAllVotesByBill(billId);
    }
    
    @RequestMapping(value={"/votes/bill/{bill_id}/legislator/{legislator_id}",
                           "/votes/legislator/{legislator_id}/bill/{bill_id}"})
    @ResponseBody
    public Vote allVotesByBillAndLegislator(@PathVariable("bill_id") String billId, 
                                            @PathVariable("legislator_id") int legislatorId){
        return dao.getVoteByBillAndLegislatorId(billId, legislatorId);
    }
    
    @RequestMapping("/bills")
    @ResponseBody
    public List<Bill> allBills(){
        return dao.getAllBills();
    }

    @RequestMapping("/bill/{id}")
    @ResponseBody
    public Bill allBillById(@PathVariable String id){
        return dao.getBillByID(id);
    }
    
    @RequestMapping("/legislators")
    @ResponseBody
    public List<Legislator> allLegislators(){
        return dao.getAllLegislators();
    }

    @RequestMapping("/legislator/{id}")
    @ResponseBody
    public Legislator allLegislatorById(@PathVariable int id){
        return dao.getLegislatorByID(id);
    }
    
    @RequestMapping("/testConnection")
    @ResponseBody
    String testConnection() {

        System.out.println("-------- PostgreSQL "
                + "JDBC Connection Testing ------------");

        try {

            Class.forName("org.postgresql.Driver");

        } catch (ClassNotFoundException e) {

            System.out.println("Where is your PostgreSQL JDBC Driver? "
                    + "Include in your library path!");
            e.printStackTrace();
            return "Driver exploded";

        }

        System.out.println("PostgreSQL JDBC Driver Registered!");

        Connection connection = null;

        try {

            connection = DriverManager.getConnection(
                    System.getenv("DB_URL"),
                    System.getenv("DB_USR"),
                    System.getenv("DB_PW"));

        } catch (SQLException e) {

            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return "Connection failed";

        }

        if (connection != null) {
            System.out.println("You made it, take control your database now!");
            return "It worked!";
        } else {
            System.out.println("Failed to make connection!");
        }

        return "Try again...";
    }

    public static void main(String[] args) throws Exception {
        SpringApplication.run(WebserviceController.class, args);
    }
}
