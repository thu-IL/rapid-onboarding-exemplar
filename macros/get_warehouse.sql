{% macro get_warehouse() %}
        
    {% if flags.FULL_REFRESH == True %}
        {{ var('s_warehouse') }}
    {% else %}
        {{ target.warehouse }}
    {% endif %}

{% endmacro %}