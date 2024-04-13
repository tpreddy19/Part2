public class LeadTriggerHandler {
    
    public static void handleAfterInsert(List<Lead> newLeads){
        List<Task> tsksList = new List<Task>();
        
        for(Lead newLead : newLeads){
            Task tsk = new Task(Subject = 'Follow with the new lead',   
                                Description = 'Create a task for the new lead',
                                WhoId = newLead.Id,
                                ActivityDate = Date.today().addDays(7));
            tsksList.add(tsk);
            
        }
        Insert tsksList;
    }
    public static void handleAfterUpdate(List<Lead> newLeads, Map<Id, Lead> oldLeadMap) {
        List<Task> tasksToCreate = new List<Task>();
        for (Lead newLead : newLeads) {
            Lead oldLead = oldLeadMap.get(newLead.Id);

            // Check if the Product Interest has changed (for after update trigger)
            if (oldLead != null && newLead.ProductInterest__c != oldLead.ProductInterest__c) {
                createTask(newLead, tasksToCreate);
            }
            // For after insert trigger, always create a task
            else if (oldLead == null) {
                createTask(newLead, tasksToCreate);
            }
        }
        
        // Insert tasks
        if (!tasksToCreate.isEmpty()) {
            insert tasksToCreate;
        }
    }

    private static void createTask(Lead lead, List<Task> tasksToCreate) {
        // Create a task to follow up with the lead
        Task newTask = new Task(
            Subject = 'Follow up with Lead',
            Description = 'Follow up with Lead regarding their interest in ' + lead.ProductInterest__c,
            WhoId = lead.Id,
            ActivityDate = Date.today().addDays(7) // Follow up in 7 days
        );
        tasksToCreate.add(newTask);
    }
}