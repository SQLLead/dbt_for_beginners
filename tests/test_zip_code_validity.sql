select * 
from {{ ref('dim_customers') }}
where customer_zip not between 90000 and 99999