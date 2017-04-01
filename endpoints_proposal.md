Proposed Endpoints
==================

Search bills
------------
bill/{bill_id}

bills/

bills/status/{status}

bills/votes/marginal/{difference}
-	e.g. bills/votes/marginal/5
-	Return bills that had a diff of 5 or less in yea/nays

bills/maxVotes/{vote}/{count}
-	e.g. bills/maxVotes/NV/10
-	Return bills with no more than 10 "no votes"

bills/minVotes/{vote}/{count}
-	e.g. bills/minVotes/nay/10
-	Return bills with at least 10 nays

bills/legislator/{id}/vote/{vote}
legislator/{id}/bills/vote/{vote}
-	e.g.: legislator/2/bills/vote/yea
-	Return bills that legislator 2 voted yea on.

bills/legislator/{id}/vote/{vote}/party/{party_id}
legislator/{id}/bills/vote/{vote}/party/{party_id}
-	e.g. bills/legislator/5/votes/yay/party/republican
-	Return Republican bills that legislator 5 voted yay on.

bills/legislator/{id}/vote/{vote}/result/{result}
legislator/{id}/bills/vote/{vote}/result/{result}
-	e.g. legislator/5/votes/yay/result/passed
-	Return Passed bills that legislator 5 voted yay on.


Search legislators
------------------
legislator/{id}/

legislators/

legislators/representatives/

legislators/senators/

legislators/party/{party_id}

legislators/maxVotes/{vote}/{count}
-	e.g. legislators/maxVotes/NV/10
-	Return legislators that have no more than 10 "no votes"

legislators/minVotes/{vote}/{count}
-	e.g. legislators/minVotes/NV/10
-	Return legislators that have at least 10 "no votes"

legislators/bill/{bill_id}/vote/{vote}
bill/{bill_id}/legislators/vote/{vote}
-	e.g. bill/3/legislators/vote/nay
-	Return legislators who voted nay on Bill 3.


Find votes
----------
vote/bill/{bill_id}
-	Return all votes (in House and Senate) for a bill.

vote/legislator/{legislator_id}
-	Return all votes on any bills for a legislator.

vote/legislator/{legislator_id}/bill/{bill_id}
vote/bill/{bill_id}/legislator/{legislator_id}
-	Return vote on specific bill and legistator.