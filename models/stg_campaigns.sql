#pulling in core campaigns data.

Select

    campaign_id,
    org_id,
    type,
    channel,
    goal_amount,
    start_date,
    end_date,
    is_recurring    

from {{ source('headofdata', 'campaigns_raw')}}