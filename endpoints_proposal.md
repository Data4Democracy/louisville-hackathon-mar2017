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
-	*e.g. bill/3/legislators/vote/nay*

legislator/{id}/bills/vote/{vote}
-	*e.g.: legislator/2/bills/vote/yea*
