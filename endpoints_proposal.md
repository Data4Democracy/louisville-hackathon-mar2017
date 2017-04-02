#Current Live Server
https://derby-pie-politics.herokuapp.com (root redirects here)
Clickable links below are live, others still pending.
==================
#Endpoint Descriptors:

##Search bills
------------
[bill/{bill_id}](https://derby-pie-politics.herokuapp.com/bill/ga2017HB003)

[bills/](https://derby-pie-politics.herokuapp.com/bills/)

bills/result/{result}

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

bills/legislator/{id}/sponsored
legislator/{id}/bills/sponsored
-	Return bills sponsored or co-sponsored by legislator.


##Search legislators
------------------
[legislator/{id}](https://derby-pie-politics.herokuapp.com/legislator/40)

[legislators/](https://derby-pie-politics.herokuapp.com/legislators/)

legislators/house/

legislators/senate/

[legislators/party](https://derby-pie-politics.herokuapp.com/legislators/party/)

legislators/party/{party}

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

legislator/{id}/cosponsors
-	Returns legislators who have co-sponsored any bill with given legislator.

##Find votes
----------
[votes/bill/{bill_id}](https://derby-pie-politics.herokuapp.com/votes/bill/ga2017HB001)
-	Return all votes (in House and Senate) for a bill.

[votes/legislator/{legislator_id}](https://derby-pie-politics.herokuapp.com/votes/legislator/40)
-	Return all votes on any bills for a legislator.

[/votes/record/legislator/{legislator_id}](https://derby-pie-politics.herokuapp.com/votes/record/legislator/1)
- Returns legislator info and condensed voting record on bills grouped by vote type

[vote/legislator/{legislator_id}/bill/{bill_id}](https://derby-pie-politics.herokuapp.com/votes/legislator/40/bill/ga2017HB156)
[vote/bill/{bill_id}/legislator/{legislator_id}](https://derby-pie-politics.herokuapp.com/votes/bill/ga2017HB156/legislator/40/)
-	Return vote on specific bill and legistator.

