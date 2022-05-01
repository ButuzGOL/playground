import { TestBed } from '@angular/core/testing';

import { DataTService } from './data-t.service';

describe('DataTService', () => {
  let service: DataTService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DataTService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
