# sql_data_warehouse_project
Building a modern data warehouse with SQL Server, including ETL Processes, data modelling and analysis.
## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

### BI: Analytics & Reporting (Data Analysis)

#### Objective
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.  

For more details, refer to [docs/requirements.md](docs/requirements.md).

## 📂 Repository Structure
```
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│   ├── source_crm/                     # CRM source: customers, products, sales details
│   ├── source_erp/                     # ERP source: customer birthdates and gender, locations, product categories
│
├── docs/                               # Project documentation and architecture details
│   ├── requirements.md                 # Project requirements (also as Project_Requirements.pdf)
│   ├── data_architecture.png           # The project's architecture (bronze, silver, gold)
│   ├── data_flow.png                   # Data flow diagram
│   ├── data_integration.png            # How the source tables relate to each other
│   ├── data_model.png                  # Data model (star schema)
│   ├── ETL.png                         # The ETL techniques and methods used
│   ├── data_catalog.md                 # Catalog of the gold layer, field descriptions and metadata
│   ├── naming_conventions.md           # Consistent naming guidelines for tables, columns, and files
│   ├── data_layers.pdf                 # The three layers side by side
│   ├── Project_Notes_Sketches.pdf      # Baraa's project notes and sketches
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── init_database.sql               # Creates the database and the three schemas
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Quality checks for the silver and gold layers
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
└── .gitignore                          # Files and directories to be ignored by Git
