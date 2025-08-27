#pulling in core organization data.

Select

    org_id,
    sector,
    geo_region,
    staff_size,
    plan_tier,
    date_joined,
    crm_integrated,
    crm_integration_date,
    avg_monthly_api_calls

from {{ source('headofdata', 'organizations_raw')}}