with campaigns as (
    select * from {{ ref('stg_campaigns')}}
),

donations as (
    select * from {{ ref('donations_enr')}}
),

organizations as (
    select * from {{ ref('stg_organizations')}}
),

campaign_outcomes as (
    select
        campaign_id,
        count(*) as record_count,
        count(distinct donor_email) as dist_donor_count,
        sum(amount) as total_amount
    
    from donations
    group by 1
),

campaign_enr as (
    select
        campaigns.campaign_id,
        campaigns.org_id,
        organizations.sector,
        organizations.geo_region,
        organizations.staff_size,
        organizations.date_joined,
        organizations.plan_tier,
        campaigns.start_date,
        campaigns.end_date,
        date_diff(campaigns.end_date, campaigns.start_date, day) as campaign_duration_days,
        campaigns.type,
        campaigns.channel,
        campaigns.goal_amount,
        coalesce(campaign_outcomes.dist_donor_count, 0) as unique_donors,
        coalesce(campaign_outcomes.record_count, 0) as donation_count,
        coalesce(campaign_outcomes.total_amount, 0) as total_donations
        
    from campaigns
    left join campaign_outcomes using (campaign_id)
    left join organizations using (org_id)
    order by campaigns.org_id
)

select * from campaign_enr