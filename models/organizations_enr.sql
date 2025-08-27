# enriching organization data with campaigns and donation details to complete ORG Level analysis

with organizations as (
    select * from {{ ref('stg_organizations')}}
),

campaigns as (
    select * from {{ ref('stg_campaigns')}}
),

donations as (
    select
        org_id,

        count(distinct donor_name) as distinct_donors_org,
        count(donor_id) as total_donors_org,
        count(donation_id) as total_donations,
        sum(amount) as total_raised
    
    from {{ ref('donations_enr')}}
    group by org_id
),

organizations_outcomes as (
    select
        org_id, 
        min(start_date) as first_campaign_date,
        max(start_date) as last_campaign_date,
        count(campaign_id) as number_of_campaigns

    from campaigns
    group by org_id
), 

final as (
    select
        organizations.*,
        coalesce(organizations_outcomes.first_campaign_date) as first_campaign_date,
        coalesce(organizations_outcomes.last_campaign_date) as last_campaign_date,
        coalesce(organizations_outcomes.number_of_campaigns, 0) as total_campaigns,
        coalesce(donations.distinct_donors_org, 0) as dist_donors_org,
        coalesce(donations.total_donors_org, 0) as total_donors_org,
        coalesce(donations.total_donations, 0) as total_donations_org,
        coalesce(donations.total_raised, 0) as total_raised,

    from organizations
    left join organizations_outcomes using (org_id)
    left join donations using (org_id)
    order by total_campaigns desc
)

select * from final
