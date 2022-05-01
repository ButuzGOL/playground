import { LiveAnnouncer } from '@angular/cdk/a11y';
import { AfterViewInit, Component, Inject, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort, Sort } from '@angular/material/sort';
import { FormBuilder, Validators } from '@angular/forms';
import {
  MatDialog,
  MatDialogRef,
  MAT_DIALOG_DATA,
} from '@angular/material/dialog';
import { DataTService } from '../data-t.service';

export interface PeriodicElement {
  id: string;
  name: string;
}

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent implements AfterViewInit {
  displayedColumns: string[] = ['id', 'name'];
  dataSource = new MatTableDataSource<PeriodicElement>();
  constructor(
    private _liveAnnouncer: LiveAnnouncer,
    public dialog: MatDialog,
    private dataTService: DataTService
  ) {}
  isLoading: boolean = false;
  // @ts-ignore
  @ViewChild(MatPaginator) paginator: MatPaginator;
  // @ts-ignore
  @ViewChild(MatSort) sort: MatSort;
  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
  }

  ngOnInit(): void {
    this.getData();
  }

  getData(): void {
    this.isLoading = true;
    setTimeout(() => {
      this.dataSource.data = this.dataTService.getDataT();
      this.isLoading = false;
    }, 1000);
  }

  refresh() {
    this.getData();
  }

  openDialog() {
    const dialogRef = this.dialog.open(DialogAbComponent, {
      width: '700px',
      height: '700px',
      data: {
        animal: 'panda',
      },
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result.abc) this.refresh();
      console.log(`Dialog result:`, result);
    });
  }

  /** Announce the change in sort state for assistive technology. */
  announceSortChange(sortState: Sort) {
    // This example uses English messages. If your application supports
    // multiple language, you would internationalize these strings.
    // Furthermore, you can customize the message to add additional
    // details about the values being sorted.
    if (sortState.direction) {
      this._liveAnnouncer.announce(`Sorted ${sortState.direction}ending`);
    } else {
      this._liveAnnouncer.announce('Sorting cleared');
    }
  }
}

export interface DialogData {
  animal: 'panda' | 'unicorn' | 'lion';
}

@Component({
  selector: 'dialog-ab',
  templateUrl: './dialog-ab.component.html',
})
export class DialogAbComponent {
  addressForm = this.fb.group({
    name: [null, Validators.required],
  });

  constructor(
    public dialogRef: MatDialogRef<DialogAbComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData,
    private fb: FormBuilder,
    private dataTService: DataTService
  ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }

  onSubmit(): void {
    if (this.addressForm.valid) {
      this.dataTService.add({
        id: '5',
        name: '555',
      });

      this.dialogRef.close({
        abc: '1234',
      });
    }
  }
}
