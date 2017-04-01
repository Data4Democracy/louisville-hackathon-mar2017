Proposed Endpoints
==================

Get all bills (by status or number)
-----------------------------------
bills/

bills/status/{status}

bill/{bill_id}

Legislators (by number)
-----------------------
legislators/

legislators/representatives/

legislators/senators/

legislator/{id}/

legislators/maxVotes/{vote}/{count}
-	e.g. legislators/maxVotes/NV/10
-	Return legislators that have no more than 10 "no votes"

legislators/minVotes/{vote}/{count}
-	e.g. legislators/minVotes/NV/10
-	Return legislators that have at least 10 "no votes"

See who voted for what or vice versa
------------------------------------
bill/{number}/legislators/vote/{vote}
-	e.g. bill/3/legislators/vote/nay

legislator/{id}/bills/vote/{vote}
-	e.g.: legislator/2/bills/vote/yea


Find controversial bills
------------------------
bills/votes/marginal/{difference}
-	e.g. bills/votes/marginal/5
-	Return bills that had a diff of 5 or less in yea/nays

bills/maxVotes/{vote}/{count}
-	e.g. bills/maxVotes/NV/10
-	Return bills with no more than 10 "no votes"

bills/minVotes/{vote}/{count}
-	e.g. bills/minVotes/nay/10
-	Return bills with at least 10 nays

Find votes
----------
vote/bill/{bill_id}
-	Return all votes (in House and Senate) for a bill.

vote/legislator/{legislator_id}
-	Return all votes on any bills for a legislator.

vote/legislator/{legislator_id}/bill/{bill_id}
-	Return vote on specific bill and legistator.

vote/bill/{bill_id}/legislator/{legislator_id}
-	Return vote on specific bill and legistator.




