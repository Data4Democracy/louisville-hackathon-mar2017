Proposed Endpoints
==================

Get all bills (by status or number)
-----------------------------------
bills/

bills/status/{status}

bill/{number}


Legislators (by number)
-----------------------
legislators/

legislator/{id}/


See who voted for what or vice versa
------------------------------------

bill/{number}/legislators/vote/{vote}
-	e.g. bill/3/legislators/vote/nay*

legislator/{id}/bills/vote/{vote}
-	e.g.: legislator/2/bills/vote/yea*


Find controversial bills
------------------------
bills/votes/marginal/{difference}
-	e.g. bills/votes/marginal/5
-	should return bills that had a diff of 5 or less in yea/nays

bills/votes/{vote}/{count}
-	e.g. bills/votes/nay/10
-	should return bills with at least 10 nays

