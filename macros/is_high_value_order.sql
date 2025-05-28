{% macro is_high_value_order(amount_col, threshold=1000) %}

    {{ amount_col }} >= {{ threshold }}

{% endmacro %}