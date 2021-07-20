/**
 * @description       : dynamicForm
 * @author            : agentgill
 * @group             :
 * @last modified on  : 07-20-2021
 * @last modified by  : agentgill
 * Modifications Log
 * Ver   Date         Author      Modification
 * 1.0   07-14-2021   agentgill   Initial Version
 **/
import { LightningElement } from 'lwc';

export default class DynamicForm extends LightningElement {
    fields = [
        {
            FieldLabel: 'My String Field!',
            FieldName: 'My String Field',
            FieldType: 'Text'
        },
        {
            FieldLabel: 'My Number Field!',
            FieldName: 'My Number Field',
            FieldType: 'Float'
        },
        {
            FieldLabel: 'My Date Field!',
            FieldName: 'My Date Field',
            FieldType: 'Date'
        }
    ];
}
