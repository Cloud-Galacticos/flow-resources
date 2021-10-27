/**
 * @description       :
 * @author            : agentgill
 * @group             :
 * @last modified on  : 10-27-2021
 * @last modified by  : agentgill
 **/
@isTest
public with sharing class UpsertRecordsTest {
  @isTest
  public static void canUpsertNewRecords() {
    List<Account> newAccounts = ListActionsTest.createAccounts(4, false);
    UpsertRecords.Request curRequest = new UpsertRecords.Request();
    curRequest.inputCollection = newAccounts;
    List<UpsertRecords.Request> curRequests = new List<UpsertRecords.Request>();
    curRequests.add(curRequest);
    Test.startTest();
    UpsertRecords.execute(curRequests);
    Test.stopTest();
    List<Account> retrievedAccounts = [
      SELECT Id
      FROM Account
      WHERE Name != 'foo'
    ];

    System.assertEquals(4, retrievedAccounts.size(), 'Accounts not inserted');
  }

  @isTest
  public static void canUpsertExistingRecords() {
    List<Account> newAccounts = ListActionsTest.createAccounts(4, true);
    newAccounts[0].Name = 'foo';

    UpsertRecords.Request curRequest = new UpsertRecords.Request();
    curRequest.inputCollection = newAccounts;
    List<UpsertRecords.Request> curRequests = new List<UpsertRecords.Request>();
    curRequests.add(curRequest);
    Test.startTest();
    UpsertRecords.execute(curRequests);
    Test.stopTest();
    List<Account> retrievedAccounts = [
      SELECT Id
      FROM Account
      WHERE Name != 'baz'
    ];
    System.assertEquals(4, retrievedAccounts.size(), 'Something went wrong');
    retrievedAccounts = [SELECT Id FROM Account WHERE Name = 'foo'];
    System.assertEquals(1, retrievedAccounts.size(), 'Accounts not updated');
  }

  @isTest
  public static void canUpsertExistingRecordsUsingExternalId() {
    List<Account> newAccounts = ListActionsTest.createAccounts(4, true);
    newAccounts[0].Name = 'foo';

    UpsertRecords.Request curRequest = new UpsertRecords.Request();
    curRequest.inputCollection = newAccounts;
    curRequest.externalIdFieldName = 'Account.Id';
    List<UpsertRecords.Request> curRequests = new List<UpsertRecords.Request>();
    curRequests.add(curRequest);
    Test.startTest();
    UpsertRecords.execute(curRequests);
    Test.stopTest();
    List<Account> retrievedAccounts = [
      SELECT Id
      FROM Account
      WHERE Name != 'baz'
    ];
    System.assertEquals(4, retrievedAccounts.size(), 'Something went wrong');
    retrievedAccounts = [SELECT Id FROM Account WHERE Name = 'foo'];
    System.assertEquals(1, retrievedAccounts.size(), 'Accounts not updated');
  }
}
