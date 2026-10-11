# Database Entity Relationship (ER) Diagram

Based on the `database.sql` schema within your project (and the recent feature removals), here is the Entity Relationship Diagram for the BIDA Portal. 

```mermaid
erDiagram
    users {
        INT id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR suffix
        VARCHAR middle_name
        DATE date_of_birth
        ENUM gender
        ENUM civil_status
        VARCHAR contact_number UK
        VARCHAR email UK
        VARCHAR password
        ENUM role
        VARCHAR house_street
        VARCHAR barangay
        VARCHAR user_type
        VARCHAR classification_id
        VARCHAR profile_photo
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    user_documents {
        INT id PK
        INT user_id FK
        ENUM document_type
        VARCHAR file_name
        VARCHAR file_path
        TIMESTAMP uploaded_at
        ENUM status
    }

    pending_contact_changes {
        INT id PK
        INT user_id FK
        ENUM field
        VARCHAR new_value
        ENUM status
        TIMESTAMP requested_at
    }

    pwd_profiles {
        INT id PK
        INT user_id FK
        ENUM application_type
        VARCHAR blood_type
        VARCHAR religion
        VARCHAR educational_attainment
        VARCHAR employment_status
        VARCHAR employment_category
        VARCHAR employment_type
        VARCHAR occupation
        VARCHAR gsis_no
        VARCHAR pagibig_no
        VARCHAR philhealth_no
        ENUM philhealth_status
        VARCHAR emergency_contact_name
        VARCHAR emergency_contact_num
        VARCHAR emergency_relationship
        TEXT disability_type
        TEXT disability_cause
        VARCHAR certifying_physician
        DATE med_cert_date
        DATE med_cert_expiry_date
        VARCHAR physician_license_no
        VARCHAR father_name
        VARCHAR mother_name
        VARCHAR guardian_name
        ENUM accomplished_by
        VARCHAR accomplished_by_name
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    senior_profiles {
        INT id PK
        INT user_id FK
        ENUM application_type
        VARCHAR blood_type
        VARCHAR civil_status
        VARCHAR religion
        VARCHAR lahi
        VARCHAR is_widow_widower
        VARCHAR spouse_name
        DATE spouse_dob
        TEXT children_data
        ENUM pensioner
        VARCHAR pension_type
        VARCHAR emergency_contact_name
        VARCHAR emergency_contact_num
        VARCHAR emergency_relationship
        ENUM accomplished_by
        VARCHAR accomplished_by_name
        DATE brgy_cert_date
        DATE brgy_cert_expiry_date
        ENUM status
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    carousel_slides {
        INT id PK
        VARCHAR badge_text
        VARCHAR title
        TEXT description
        VARCHAR image_path
        TIMESTAMP created_at
    }

    user_notifications {
        INT id PK
        INT user_id FK
        VARCHAR title
        TEXT message
        VARCHAR link
        TINYINT is_read
        TIMESTAMP created_at
    }

    service_applications {
        INT id PK
        INT user_id FK
        ENUM application_type
        DATE appointment_date
        VARCHAR appointment_time
        ENUM status
        VARCHAR queue_ticket_number
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    service_application_docs {
        INT id PK
        INT application_id FK
        VARCHAR requirement_name
        VARCHAR file_path
        TIMESTAMP uploaded_at
    }

    users ||--o{ user_documents : "has uploaded"
    users ||--o{ pending_contact_changes : "has pending changes"
    users ||--|{ pwd_profiles : "has profile"
    users ||--|{ senior_profiles : "has profile"
    users ||--o{ user_notifications : "receives"
    users ||--o{ service_applications : "applies for services"
    service_applications ||--|{ service_application_docs : "requires documents"
```

## Overview of Relationships

- **Users Core:** The central entity is the `users` table. Almost all other tables have a foreign key linking back to it (`user_id`).
- **One-to-Many Relationships:** A single user can have multiple:
  - Uploaded documents (`user_documents`)
  - Pending contact changes (`pending_contact_changes`)
  - PWD profiles (`pwd_profiles`)
  - Notifications (`user_notifications`)
  - Service applications (`service_applications`)
- **Service Applications:** A specific service application can have multiple supporting documents attached to it (`service_application_docs`).
- **Standalone:** The `carousel_slides` table exists independently and is not tied directly to user data.
