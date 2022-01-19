public static Map<String,String> getStatus(){
        Map<String,String> optionsList = new Map<String,String>();
        try{
        String objectName = 'Case';
        String fieldName = 'Category_Selection__c';
        RecordType recType= [select id from RecordType where DeveloperName='Smart_Affiliates'];
        String recordTypeId = recType.Id;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String host = System.Url.getSalesforceBaseURL().toExternalForm();
        String url =  'callout:DeleteFile/services/data/v51.0/ui-api/object-info/'+objectName+'/picklist-values/'+recordTypeId+'/'+fieldName;        
        request.setEndpoint(url);
        request.setMethod('GET');  
       // request.setHeader('Authorization', 'Bearer'+UserInfo.getSessionId());
        HttpResponse response;        
        response = http.send(request);        
        Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        system.debug(meta);
		
        //optionsList.put('--None--', '');
        if(meta.containsKey('values')){                                
                for(Object o: (List<Object> )meta.get('values')){
                    Map<String, object > temp = (Map<String, object>)o;  
                    	optionsList.put(String.valueOf(temp.get('label')), String.valueOf(temp.get('value')));
                }
            }        
        
        System.debug(optionsList);
        
        return optionsList;
      }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
