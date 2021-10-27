/**
 * @description       :
 * @author            : agentgill
 * @group             :
 * @last modified on  : 10-27-2021
 * @last modified by  : agentgill
 **/
@isTest
public with sharing class ListActionsTest {
  private final static Integer NUMBER_OF_TEST_RECORDS = 5;
  private final static String TEST_RECORD_NAME = 'Test Acc';
  public static List<Account> createAccounts(
    Integer numberOfRecords,
    Boolean doInsert
  ) {
    List<Account> returnList = new List<Account>();
    for (Integer i = 0; i < numberOfRecords; i++) {
      returnList.add(
        new Account(
          Name = TEST_RECORD_NAME + i,
          Website = '' + i,
          AnnualRevenue = 5000
        )
      );
    }
    if (doInsert) {
      //insert returnList without triggering duplicate rules
      Database.DMLOptions dml = new Database.DMLOptions();
      dml.DuplicateRuleHeader.AllowSave = true;
      List<Database.SaveResult> sr = Database.insert(returnList, dml);
    }

    return returnList;
  }
}
