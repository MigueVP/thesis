project_name: "thesis_miguevp"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements

constant: duration_display_selected_format {
## this constant should be applied in HTML: for a duration in milliseconds
## will derived appropriate time display based on what user selects for the 'select_duration_format' parameter
## if hms or hms3 will display HH:MM:SS (format '%X')
## if mmss or mmss3 will display MM:SS (format '%M:%S')
## if ms then no format is applied
## if hms3 or mmss3 or ss3 will display milliseconds HH:MM:SS.000 or MM:SS.000 or SS.000 (milliseconds derived with modulo and appended)
## if milliseconds do not need to be displayed they are rounded to seconds (e.g., 00:07.678 rounds to 00:08)
## since applied at HTML level any downloaded values will appear as underlying value of milliseconds and will not appear formatted

value: "{% assign selectedDisplay = duration_parameters.select_duration_format._parameter_value %}
{% assign displayFormat = '' %}
{% assign secValue = value | divided_by: 1000.0 %}
{% if selectedDisplay contains 'hms' %}{% assign displayFormat = '%X' %}
{% elsif selectedDisplay contains 'mmss' %}{% assign displayFormat = '%M:%S' %}
{% elsif selectedDisplay == 'ss3' %}{% assign displayFormat = '%S' %}
{% endif %}
{% if selectedDisplay contains '3' %}
{% assign displayMSvalue = value | modulo: 1000 | round | prepend: '000' | slice: -3,3 %}
{% assign displayMS = '.' | append: displayMSvalue %}
{% assign displayTime = secValue | floor | date: displayFormat %}
{% else %}
{% assign displayMS = '' %}
{% if selectedDisplay == 'ms' %}{% assign displayTime = rendered_value %}
{% else %}
{% assign displayTime = secValue | round | date: displayFormat %}
{% endif %}
{% endif %}
{{displayTime}}{{displayMS}}"
}

# local_dependency: {
#   project: "name_of_other_project"
# }
