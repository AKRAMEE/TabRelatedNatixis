@isTest
public class NatixisDataDisplayTest {
    @isTest
    Public static void displayDataTest(){
        
        //create object A
        List<Object_A__c> objAs= new List<Object_A__c>();
        for(Integer j =0; j<2;j++){
            Object_A__c objA= new Object_A__c();
            objA.Name= 'Test A 1';
            objAs.add(objA);
        }
        insert objAs;
        
        //create object B
        Object_B__c objB= new Object_B__c();
        objB.Name= 'Test B 1';
        objB.Object_A__c=objAs[0].Id;
        insert objB;
        
        //create object C
        List<Object_C__c> objCs= new List<Object_C__c>();
        for(Integer j =0; j<2;j++){
            Object_C__c objC= new Object_C__c();
            objC.Name= 'Test C'+j;
            objC.Object_B__c=objB.Id;
            objC.Description__c='hello world';
            objCs.add(objC);
        }
        insert objCs;
        
        //tests result
        List<NatixisDataDisplay.FirstWrapper> result;
        List<NatixisDataDisplay.FirstWrapper> resultNull;
        Test.startTest();
        result= NatixisDataDisplay.displayData(objAs[0].Id);
        //Tests null path
        resultNull= NatixisDataDisplay.displayData(objAs[1].Id);
        Test.stopTest();
        
        //Assertions verification for result
        system.assertEquals(result.size(), 1);
        system.assertEquals(resultNull, null);
    }
}