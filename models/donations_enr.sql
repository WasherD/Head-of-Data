with donors as (
    select * from {{ ref('stg_donors')}}
),

donations as (
    select * from {{ ref('stg_donations')}}
),

campaigns as (
    select 
        campaign_id,
        org_id,
        type,
        start_date,
        end_date
    from {{ ref('stg_campaigns')}}
),

organizations as (
    select
        org_id,
        geo_region,
        staff_size,
        date_joined,
        plan_tier
    from {{ ref('stg_organizations')}}
),

campaigns_enriched as (
    select 
        campaigns.*,
        organizations.geo_region,
        organizations.staff_size,
        organizations.date_joined,
        organizations.plan_tier
    from campaigns
    left join organizations using (org_id)
),

donations_enr as (
    select 
        donations.*,
        campaigns_enriched.type,
        campaigns_enriched.start_date,
        campaigns_enriched.end_date,
        campaigns_enriched.geo_region,
        campaigns_enriched.staff_size,
        campaigns_enriched.date_joined,
        campaigns_enriched.plan_tier,
        date_diff(donations.donation_date, campaigns_enriched.start_date, day) as donation_days_from_start,
        donors.donor_email,
        donors.donor_name
    from donations
    left join donors using (donor_id)
    left join campaigns_enriched using (campaign_id) 
)

select * from donations_enr