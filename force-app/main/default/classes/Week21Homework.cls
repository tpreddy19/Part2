public class Week21Homework {
    public void printContactAccountNames() {
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
}