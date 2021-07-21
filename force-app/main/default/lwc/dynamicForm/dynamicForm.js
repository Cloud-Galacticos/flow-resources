/**
 * @description       : dynamicForm
 * @author            : agentgill
 * @group             :
 * @last modified on  : 07-21-2021
 * @last modified by  : agentgill
 * Modifications Log
 * Ver   Date         Author      Modification
 * 1.0   07-14-2021   agentgill   Initial Version
 * 
TODO: Add custom button to call method
TODO: New method generating JSON -  Now we need to create json based on the dymanic inputs
    {
      "My String Field": "Mike & Abdel",
      "My Date field": "2021-07-21"
}

TODO: ON click of button - console log the JSON output
  
 **/
import { LightningElement } from 'lwc';
import getFormFields from '@salesforce/apex/dynamicFormController.getForm';
export default class DynamicForm extends LightningElement {
    fields;
    error;
    connectedCallback() {
        this.loadFields();
    }

    async loadFields() {
        // Modern async/await pattern for promise
        console.log('running async/await function now');
        try {
            const myFields = await getFormFields();
            console.log(myFields);
            this.fields = JSON.parse(myFields);
        } catch (error) {
            console.log(error);
        }
    }
}
