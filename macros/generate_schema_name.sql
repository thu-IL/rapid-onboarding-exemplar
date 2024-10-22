{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

        {# we just want schemas in personal dev target to have prefixes #}
        {%- if (target.name | lower) == 'personal_dev' -%}
            {{ default_schema }}_{{ custom_schema_name | trim }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}

    {%- endif -%}

{%- endmacro %}