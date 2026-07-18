select
    country,
    count(*) as order_count,
    sum(amount) as total_amount,
    avg(amount) as average_order_amount,
    min(order_date) as first_order_date,
    max(order_date) as latest_order_date
from {{ source('raw', 'customer_orders') }}
group by country
