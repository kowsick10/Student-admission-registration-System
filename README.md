# Student Admission Registration - SAP RAP Managed Implementation

## Overview

This project is an ABAP RESTful Application Programming Model (RAP) application for handling **Student Admission Registrations**. It is built using the **Managed Implementation Type**, meaning the SAP RAP framework automatically handles the standard CRUD (Create, Read, Update, Delete) operations and transaction buffers without requiring custom ABAP logic for basic database interactions.

## Architecture

This application follows the standard 3-tier RAP architecture:

1. **Data Model & Behavior:** Database Table, Core Data Services (CDS) Views, and Behavior Definition (BDEF).
2. **Business Service Provisioning:** Service Definition and Service Binding (OData V4).
3. **UI Consumption:** SAP Fiori Elements (List Report and Object Page).

Preview 
<img width="1853" height="908" alt="image" src="https://github.com/user-attachments/assets/9efe167f-8112-436a-a216-9a9b4b1faff8" />

<img width="1837" height="768" alt="image" src="https://github.com/user-attachments/assets/177a35d7-a44e-441b-97f8-549c5cf6a8a8" />

## Prerequisites

* **IDE:** Eclipse with ABAP Development Tools (ADT) installed.
* **System:** SAP S/4HANA (Release 2020 or newer) or SAP BTP ABAP Environment.
* **Authorizations:** Developer access with permissions to create ABAP Dictionary objects, CDS views, and Service Bindings.

---

## Implementation Steps (Managed Generator Workflow)

### 1. Database Table (`ZSTUDENT_ADM`)

The physical storage is a transparent table utilizing a `UUID` as the primary key. This allows the managed framework to automatically generate unique IDs. It also utilizes standard SAP `ABP_*` data elements for administrative fields to pass strict generator validations.

```abap
@EndUserText.label : 'Student Admission Registration Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zstudent_adm {

  " --- KEY FIELDS ---
  key client            : abap.clnt not null;
  key admission_id      : sysuuid_x16 not null;

  " --- DATA FIELDS ---
  first_name            : abap.char(50);
  last_name             : abap.char(50);
  date_of_birth         : abap.dats;
  course_id             : abap.char(10);
  status                : abap.char(1);

  " --- ADMINISTRATIVE FIELDS ---
  created_by            : abp_creation_user;
  created_at            : abp_creation_tstmpl;
  last_changed_by       : abp_lastchange_user;
  last_changed_at       : abp_lastchange_tstmpl;
  local_last_changed_at : abp_locinst_lastchange_tstmpl;

}

```

### 2. CDS Data Model

* **Interface View (Root):** Exposes the database table to the RAP framework.
* **Projection View:** Projects the Interface View specifically for UI consumption and includes Fiori `@UI` annotations.

### 3. Behavior Definition (BDEF)

* **Implementation Type:** `managed`
* **Numbering:** Early numbering via `managed` is used for the `admission_id` to auto-generate UUIDs.
* **Draft capabilities:** Can be enabled using `with draft` for save-and-resume functionality.

### 4. Business Service

* **Service Definition:** Exposes the Projection View.
* **Service Binding:** Binds the definition to an **OData V4 - UI** protocol.

### 5. UI Preview

Once the Service Binding is published, use the **Preview** function in ADT to launch the generated Fiori Elements application.

---

## Known Behaviors & Validations

* **Admin Fields:** The table strictly requires `abp_creation_user`, `abp_creation_tstmpl`, `abp_lastchange_user`, `abp_lastchange_tstmpl`, and `abp_locinst_lastchange_tstmpl`. Generic `CHAR(12)` or standard timestamp fields will throw a generator validation error.
* **Status Field:** Can be extended later with value helps (e.g., 'N' for New, 'A' for Approved, 'R' for Rejected).

