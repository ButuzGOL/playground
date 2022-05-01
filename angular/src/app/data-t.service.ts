import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class DataTService {
  constructor() {}
  data = [
    { id: '1', name: 'Hydrogen' },
    { id: '2', name: 'Helium' },
    { id: '3', name: 'Lithium' },
  ];

  getDataT() {
    return this.data;
  }

  add(value: any) {
    this.data.push(value);
  }
}
