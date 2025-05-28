{% test test_zip_code_validity(model, column_name, min_zip=90000, max_zip=99999) %}

    {{ log ("DEBUG TEST: model=" ~ ", column_name=" ~ column_name, info=True) }}
  SELECT *
  FROM {{ model }}
  WHERE {{ column_name }} NOT BETWEEN {{ min_zip }} AND {{ max_zip }}
  
{% endtest %}
