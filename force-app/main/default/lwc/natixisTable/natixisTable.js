import { api, LightningElement } from 'lwc';
import NatixisDataDisplay from '@salesforce/apex/NatixisDataDisplay.displayData';
const columnsC = ['Name', 'Description'];
const columnsB = ['Name', 'CreatedBy', 'CreatedByName']
export default class NatixisTable extends LightningElement {
    style = '';
    Tab = [];
    @api recordId;
    connectedCallback() {
        this.column = columnsC;
        this.columnsB = columnsB;
        NatixisDataDisplay({ ObjAId: this.recordId })
            .then(result => {
                this.Tab = result;
                console.log('result:', result);
                if (result == null) {
                    this.style = `display: none; visibility: hidden;`;
                    return this.style;
                }

            })
            .catch(error => {
                console.log('error:', error);
                this.style = `display: none; visibility: hidden;`;
                return this.style;
            });
    }
}