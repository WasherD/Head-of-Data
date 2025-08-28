# Nonprofit Data Pipeline - dbt BigQuery Project

A dbt (data build tool) project that transforms and models nonprofit fundraising data in BigQuery, creating clean, analysis-ready views for campaigns, donations, organizations, and performance metrics.

## 📊 Overview

This project processes raw nonprofit data and creates a set of staging and mart tables optimized for analytics and reporting. The models handle campaign tracking, donation processing, donor management, and organizational metrics.

## 🏗️ Data Models

### Staging Models (`stg_*`)
Clean and standardize raw data:
- `stg_campaigns` - Campaign dimension data
- `stg_donations` - Individual donation transactions  
- `stg_donors` - Donor profile information
- `stg_extsignals` - External signal/attribution data
- `stg_organizations` - Organization master data

### Core Models
Business logic and transformations:
- `campaign_enr` - Enriched campaign data with calculated fields
- `donations_enr` - Enhanced donation records with derived metrics
- `organizations_enr` - Organization data with aggregated statistics
- `org_monthly_metrics` - Monthly organizational performance metrics

## 🛠️ Prerequisites

- [dbt Core](https://docs.getdbt.com/dbt-cli/installation) (version 1.0+)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- BigQuery access with appropriate permissions
- Python 3.7+

## 📁 Project Structure

```
├── models/
│   ├── staging/        # Raw data cleaning (stg_*)
│   ├── marts/          # Business logic models
│   └── analytics/      # Reporting-ready views
├── seeds/              # Static reference data
├── snapshots/          # Point-in-time captures
├── tests/              # Data quality tests
├── macros/             # Reusable SQL functions
└── target/             # Compiled SQL (generated)
```

## 🔧 Configuration

Key configuration files:
- `dbt_project.yml` - Project settings and model configurations
- `profiles.yml` - Database connection settings
- `packages.yml` - dbt package dependencies
