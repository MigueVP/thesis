# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Show by day"
      value: "day"
    }
    allowed_value: {
      label: "Show by month"
      value: "month"
    }
  }



  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  measure: idnumber {
    type: number
    sql: ${TABLE}.id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.



  measure: avg_order {

    sql: ${count} ;;
    value_format_name: usd
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Status" in Explore.

  dimension: status {
    required_access_grants: [test_access]
    sql: ${TABLE}.status ;;
    html: {% if value == 'pending' %}
      <p style="color: black; background-color: lightblue; font-size:100%; text-align:center"> <img src="https://cdn-icons-png.flaticon.com/512/248/248958.png"height=20 width=20>
      {{ rendered_value }}</p>
    {% elsif value == 'complete' %}
      <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center"><img src="https://cdn-icons-png.flaticon.com/512/190/190411.png"height=20 width=20>
      {{ rendered_value }}</p>
    {% else %}
      <p style="color: black; background-color: #FFD2D2; font-size:100%; text-align:center"><img src="https://cdn-icons-png.flaticon.com/512/753/753345.png"height=20 width=20>

      {{ rendered_value }}</p>
      {% endif %}
;;
  }


  dimension: user_id {
    type: number
    label: "{% if user_id == 'Looker' %} Employee Name {% else %} Customer Name {% endif %}"
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }



  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      billion_orders.count,
      fakeorders.count,
      hundred_million_orders.count,
      hundred_million_orders_wide.count,
      order_items.count,
      order_items_vijaya.count,
      ten_million_orders.count
    ]
  }
}
