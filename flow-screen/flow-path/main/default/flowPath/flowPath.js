/**
 * @description       : FlowPath (https://developer.salesforce.com/docs/component-library/bundle/lightning-progress-indicator/documentation)
 * @author            : agentgill
 * @group             :
 * @last modified on  : 07-27-2021
 * @last modified by  : agentgill
 * Modifications Log
 * Ver   Date         Author      Modification
 * 1.0   07-05-2021   agentgill   Initial Version
 **/
import { LightningElement, api } from 'lwc';

export default class FlowPath extends LightningElement {
    @api activeStages;
    @api currentStage;
    @api pathType;
    @api pathVariant;
}
