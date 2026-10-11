# Theoretical Framework Diagram

Here is a block diagram tailored to your BIDA Portal system. It replicates the style of your screenshot (actors on the sides, core modules in the center, database at the bottom). 

You can view this directly in the VS Code preview or paste it into the [Mermaid Live Editor](https://mermaid.live/) to export the image for your document.

```mermaid
flowchart LR
    %% Set diagram layout characteristics
    classDef actor fill:#fff,stroke:#000,stroke-width:2px,color:#000,font-weight:bold;
    classDef module fill:#fff,stroke:#333,stroke-width:1px,color:#000;
    classDef core fill:#f9f9f9,stroke:#000,stroke-width:2px;
    classDef db fill:#fff,stroke:#000,stroke-width:2px;
    classDef cloud fill:#fff,stroke:#000,stroke-width:1px,stroke-dasharray: 5 5;

    %% ─── ACTORS (Left & Right) ───
    USER["PORTAL USER<br/>(PWD / Senior Citizen)"]:::actor
    ADMIN["ADMINISTRATOR"]:::actor

    %% ─── TOP CLOUD ───
    INTERNET(("INTERNET / CLOUD")):::cloud

    %% ─── CORE SYSTEM (Center) ───
    subgraph SYSTEM ["BIDA PORTAL SYSTEM"]
        direction TB
        M1["USER AUTHENTICATION &<br/>PROFILE MODULE<br/>(Registration & Identity)"]:::module
        M2["DOCUMENT VERIFICATION &<br/>SERVICE APPLICATION MODULE<br/>(Appointments & Ticketing)"]:::module
        M3["ANALYTICS & CONTENT<br/>MANAGEMENT MODULE<br/>(Dashboard & Announcements)"]:::module
    end
    class SYSTEM core

    %% ─── DATABASE (Bottom) ───
    DB[("MYSQL DATABASE")]:::db

    %% ─── RELATIONSHIPS: Internet -> System ───
    INTERNET -.-> SYSTEM

    %% ─── RELATIONSHIPS: User (Left) -> System ───
    USER -- "Register Account & Log In" --> M1
    USER -- "Complete Profile Data" --> M1
    USER -- "Upload IDs & Documents" --> M2
    USER -- "Book Service Appointments" --> M2
    USER -- "Print Queue Tickets" --> M2

    %% ─── RELATIONSHIPS: Admin (Right) -> System ───
    %% We draw arrows FROM the system TO the admin, but reverse the visual arrow head so it stays on the right
    M1 <-- "Manage User Accounts & Roles" --- ADMIN
    M1 <-- "Approve Contact Changes" --- ADMIN
    M2 <-- "Verify Uploaded Documents" --- ADMIN
    M2 <-- "Approve or Reject Applications" --- ADMIN
    M3 <-- "Monitor Real-Time Statistics" --- ADMIN
    M3 <-- "Update Dynamic Announcements" --- ADMIN

    %% ─── RELATIONSHIPS: System <-> Database ───
    SYSTEM <== "STORED DATA" ===> DB
    SYSTEM <== "UPDATE DATA" ===> DB
```

### Breakdown of the Framework Elements:
1. **Left Side (Portal User):** Represents the citizens (PWDs & Senior Citizens) interacting with the system to register, build their profiles, upload their mandatory documents, and secure appointments leading to a queue ticket.
2. **Center (BIDA Portal System):** The core system is divided into three functional modules exactly reflecting what we built: Authentication/Profile, Application/Documents, and Analytics/Content.
3. **Right Side (Administrator):** Represents the administrative staff who review the uploaded documents, approve/reject the appointments, oversee portal statistics, and control the dashboard announcements.
4. **Bottom (MySQL Database):** Represents the structured storage where all profiles, uploaded files, and tracking metrics are securely kept.
