#pulling in core donations data.

Select

    campaign_id,
    donation_id,
    org_id,
    donor_id,
    donation_date,
    amount,
    payment_method

from {{ source('headofdata', 'donations_raw')}}