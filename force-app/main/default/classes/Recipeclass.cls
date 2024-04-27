trigger RecipeTrigger on Recipe__c (before insert, before update, after insert, after update) {
    if (Trigger.Isinsert ||trigger.Isupdate){
        RecipeClass.recipeValidator(trigger.new);
    }
    //SF will have modified values in Trigger.New
    if(Trigger.IsBefore)
    {RecipeClass.recipeValidator(trigger.new);}
}

//Create a method that will be called before a recipe is inserted or updated  to check if it is missing key values. 
//If it is missing one or more of the following, check the Draft__c field on the recipe:
public class RecipeClass {
    public static void recipeValidator(List<Recipe__c> testRecipes){
        //loop over the recipe to check for missing fields        
        for(Recipe__c testRecipe : testRecipes){
         if(testRecipe.Name == null ||
           	testRecipe.Active_Time__c == null ||
           	testRecipe.Description__c == null ||
           	testRecipe.Active_Time_Units__c == null ||
            testRecipe.Servings__c == null){
            	testRecipe.Draft__c = true;
            }
        }

 	}
// This method checks the complexity of the recipe by referencing the HelperFunction class. rate Recipe complexity method.
    public static void checkRecipeComplexity(List<Recipe__c> testRecipes){
           for(Recipe__c testRecipe : testRecipes){ 
               String complexity = HelperFunctions.rateRecipeComplexity(testRecipe).toString();
              If (complexity <> ''){
                  testRecipe.Complexity__c = complexity;
              }
          }
    }
    
 public static void createTask(List<Recipe__c> testRecipes){
        //loop over the recipe to check for missing fields 
        List<Task> tsksList = new List<Task>();    
     //checking whether the recipe exists in Recipeusage. If it is there, then there will be a record in cookbook and recipe.
        List<Recipe_Usage__c> recpUsages = [Select cookbook__r.name,cookbook__r.OwnerId, Recipe__r.name, Recipe__r.draft__c, 
                                            Recipe__c from Recipe_Usage__c where Recipe__c = : testRecipes];
        for(Recipe_Usage__c reUasg : recpUsages){
         if(reUasg.Recipe__r.draft__c <> true ){    
                //whoever is the owner of the cookbook should have a task
            	Task tsk = new Task(Subject = 'Follow with the new Recipe',   
                                Description = 'Create a task for the new Recipe',
                                WhatId = reUAsg.Id,
                                OwnerId = reUasg.cookbook__r.OwnerId,
                                ActivityDate = Date.today().addDays(7));
            tsksList.add(tsk);
            }            
        }
     	insert tsksList;

 	}
}
