#pulling in core donor details.

Select

    string_field_0 as donor_id,
    string_field_1 as donor_email,
    string_field_2 as donor_name

from {{ source('headofdata', 'donors_raw')}}