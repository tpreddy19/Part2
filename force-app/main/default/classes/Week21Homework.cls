public class weekTwoHomework {
     public  void printContactAccountNames() {
        // Querying contacts with associated account information using a WHERE clause
        List<Contact> contacts = [SELECT Id, Name, Account.Name, Account.Industry 
                                  FROM  Contact 
                                  WHERE AccountId != null];

        // Loop through the contacts and print the Account Name for each contact
        for(Contact con : contacts) {
            // Print the Account Name using System.debug
            System.debug('Contact Name: ' + con.Name + ', Account Name: ' + con.Account.Name + ', Industry: ' 
                         + con.Account.Industry);
        }         
         
    }
      public void printOpportunityAccountNames() {
        // A method that includes a query for a list of Accounts AND includes all their closed-won opportunities in a subquery. 
        List<Opportunity> opportunities = [SELECT ACCOUNT.NAME,STAGENAME,ID FROM OPPORTUNITY WHERE STAGENAME = 'CLOSED WON'];
        // Use a loop to print out the name of each Account’s opportunity with System.debug.
        for(Opportunity opp : opportunities) {
           
            System.debug('Opp ID: ' + opp.ID + ', Account Name: ' + opp.Account.Name + ', StageName: ' 
                         + opp.StageName );
        }         
         
    }
    public void printOpportunityMap() {
        // A method that queries for Opportunity records that returns results in a map format.
        // First get the map of OPPortunities for ID
       Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>([SELECT Id, Name FROM Opportunity ]);
       Set<Id> oppIds = opportunityMap.keyset();
       for(Id oppId : oppIds) {
    		Opportunity opp = opportunityMap.get(oppId);
           
    			System.debug('Opportunity ID: ' + opp.Id + ', Opportunity Name: ' + opp.Name);
		}  
         
    }
     public void printOpenOpportunities() {
        // An aggregate results query that returns an integer equal to the total number of open opportunities in your org.   
         AggregateResult[] results = [SELECT Count(ID) idCount FROM OPPORTUNITY WHERE STAGENAME !='CLOSED WON'];
         If (results.size()>0){
             Integer i = (Integer)results[0].get('idCount');
          // Print the total number of open opportunities using system.debug
             System.debug('Count ' +i);
         }
       
         
    }
}
