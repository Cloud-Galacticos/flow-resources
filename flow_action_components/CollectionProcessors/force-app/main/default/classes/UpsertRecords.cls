/**
 * @description       : UpsertRecords
 * @author            : agentgill
 * @group             : https://github.com/alexed1/LightningFlowComponents/tree/master/flow_action_components/CollectionProcessors
 * @last modified on  : 10-27-2021
 * @last modified by  : agentgill
 **/
public without sharing class UpsertRecords {
  @InvocableMethod
  public static List<Results> execute(List<Request> requestList) {
    System.debug(LoggingLevel.INFO, '!!! UpsertRecords:' + requestList);
    List<Results> responseWrapper = new List<Results>();
    for (Request curRequest : requestList) {
      List<SObject> inputCollection = curRequest.inputCollection != null
        ? curRequest.inputCollection
        : new List<SObject>();
      SObject inputRecord = curRequest.inputRecord;
      Boolean allOrNone = curRequest.allOrNone != null
        ? curRequest.allOrNone
        : true;

      if (inputCollection == null && inputRecord == null) {
        throw new InvocableActionException(
          'You must pass in either an inputCollection or an inputRecord to the GenerateCollectionReport Action'
        );
      }
      Schema.SObjectField externalIdField = getExternalIdField(
        curRequest.externalIdFieldName
      );
      //add the inputRecord to inputCollection so we can just handle inputCollection
      //note that cpe's will be able to ensure these are the same type
      if (inputRecord != null) {
        inputCollection.add(inputRecord);
      }

      Set<Id> ids = saveUpsertResults(
        inputCollection,
        externalIdField,
        allOrNone
      );

      //Create a Results object to hold the return values
      Results response = new Results();
      List<Id> idsList = new List<Id>();
      idsList.addAll(ids);
      response.upsertedIds = idsList;

      responseWrapper.add(response);
    }

    return responseWrapper;
  }

  /**
   * @description Save Upsert Results
   * @author agentgill | 10-27-2021
   * @param inputCollection
   * @param externalIdField
   * @param allOrNone
   * @return Set<Id>
   **/
  private static Set<Id> saveUpsertResults(
    List<SObject> inputCollection,
    Schema.SObjectField externalIdField,
    Boolean allOrNone
  ) {
    Set<Id> ids = new Set<Id>();
    List<Database.upsertResult> results = new List<Database.upsertResult>();
    if (externalIdField != null) {
      results = Database.upsert(inputCollection, externalIdField, allOrNone);
    } else {
      results = Database.upsert(inputCollection, allOrNone);
    }

    for (Database.upsertResult result : results) {
      System.assert(result.isSuccess());
      ids.add(result.getId());
    }
    return ids;
  }

  /**
   * @description getExternalIdField
   * @author agentgill | 10-27-2021
   * @param externalIdFieldName
   * @return Schema.SObjectField
   **/
  private static Schema.SObjectField getExternalIdField(
    String externalIdFieldName
  ) {
    Schema.SObjectField externalIdField;
    if (externalIdFieldName == null) {
      externalIdField = null;
    } else {
      List<String> parts = externalIdFieldName.split('\\.');

      System.debug(LoggingLevel.INFO, '!!! getExternalIdField:' + parts);

      Map<String, SObjectField> fieldsMapByName = Schema.getGlobalDescribe()
        .get(parts.get(0).toLowerCase())
        .getDescribe()
        .fields.getMap();
      externalIdField = fieldsMapByName.get(parts.get(1).toLowerCase());
    }
    return externalIdField;
  }

  public class Request {
    @InvocableVariable
    public List<SObject> inputCollection;

    @InvocableVariable
    public SObject inputRecord;

    @InvocableVariable
    public String externalIdFieldName;

    @InvocableVariable
    public Boolean allOrNone;
  }

  public class Results {
    @InvocableVariable
    public String placeholder; //don't ask (OMG)

    @InvocableVariable
    public List<Id> upsertedIds;
  }

  public class InvocableActionException extends Exception {
  }
}
