/**
 * @description       :
 * @author            : agentgill
 * @group             :
 * @last modified on  : 07-21-2021
 * @last modified by  : agentgill
 * Modifications Log
 * Ver   Date         Author      Modification
 * 1.0   07-21-2021   agentgill   Initial Version
 **/
public with sharing class DynamicFormController {
    @AuraEnabled
    public static String getForm() {
        return [SELECT form_json__c FROM DynamicForm__mdt LIMIT 1].form_json__c;
    }
}
