Select

    date,
    geo_region,
    cpi,
    unemployment_rate,
    gdp_growth,
    holiday_flag

from {{ source('headofdata', 'extsignals_raw')}}