public inherited sharing class RecipeController {
    @AuraEnabled(Cacheable=true)
    public static List<Recipe__c> getAllRecipes() {
        return [
            SELECT
                Id,
                Name,
                Draft__c,
                Active_Time__c,
                Active_Time_Units__c,
                Complexity__c,
                Needs_Review__c,
                Possible_Duplicate__c,
                Season__c
            FROM Recipe__c
            ORDER BY Name
            LIMIT 50
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Recipe__c> searchRecipes(String searchTerm) {
        List<Recipe__c> recipes = new List<Recipe__c>();

        // Return all recipes when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            recipes = getAllRecipes();
        } else {
            // Prepare query parameters
            searchTerm = '%' + searchTerm + '%';

            // Execute search query
            recipes = [
                SELECT
                    Id,
                    Name,
                    Draft__c,
                    Active_Time__c,
                    Active_Time_Units__c,
                    Complexity__c,
                    Needs_Review__c,
                    Possible_Duplicate__c,
                    Season__c
                FROM Recipe__c
                WHERE Name LIKE :searchTerm
                ORDER BY Name
                LIMIT 50
            ];
        }

        System.debug('returning: ' + recipes);
        return recipes;
    }
}