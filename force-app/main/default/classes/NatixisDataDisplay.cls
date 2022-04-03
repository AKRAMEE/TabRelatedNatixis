public class NatixisDataDisplay {
    @AuraEnabled
    Public static List<FirstWrapper> displayData(String ObjAId){
        //Get record related to Obj A 
        // get record related from Obj B
        List<Object_B__c> recsObjB = [SELECT id, Name,CreatedBy.Name,CreatedDate from Object_B__c where Object_A__c=:ObjAId];
        if(recsObjB.size()>0){
            //fill my wrraper
            List<FirstWrapper> recordsToDisplay = new  List<FirstWrapper> ();
            for(Object_B__c RecB:recsObjB){
                FirstWrapper recordToDisplay = new FirstWrapper();
                recordToDisplay.id=RecB.id;
                recordToDisplay.Name=RecB.Name;
                recordToDisplay.CreatedByName=RecB.CreatedBy.Name;
                recordToDisplay.CreatedDate=RecB.CreatedDate.date();
                recordToDisplay.RecordsC=null;
                recordsToDisplay.add(recordToDisplay);
            }
            //create set of id to get obj C related to B
            Set<Id> BIds = (new Map<Id,Object_B__c>(recsObjB)).keySet().clone();
        	List<Object_C__c> recsObjC = [SELECT id, Name,Description__c,Object_B__c from Object_C__c where Object_B__c=:BIds];
            system.debug('recsObjC '+recsObjC);
            if(recsObjC.size()>0){
                system.debug('recordsToDisplay '+recordsToDisplay);
                //fill my wrapper with C object to fetch in my table if they exist
                for(FirstWrapper PrioRaper:recordsToDisplay){
                    for(Object_C__c RecC:recsObjC){
                        if(RecC.Object_B__c==PrioRaper.id){
                            if(PrioRaper.RecordsC!=null){
                                PrioRaper.RecordsC.add(RecC);
                            }else{
                                PrioRaper.RecordsC=new List<Object_C__c>();
                                PrioRaper.RecordsC.add(RecC);
                            }
                            
                            system.debug('recordsToDisplay '+recordsToDisplay);
                        }
                    }
                }
            }
            return recordsToDisplay;
        }
        return null;
    }
    //wrraper to used to format my data that will be fetch
     public class FirstWrapper {
        @AuraEnabled
        public String id {get;set;}
        @AuraEnabled
        public String Name {get;set;}
        @AuraEnabled
        public String CreatedByName {get;set;}
        @AuraEnabled
        public Date CreatedDate {get;set;}
        @AuraEnabled
        public List<Object_C__c> RecordsC {get;set;}
     }
    
}