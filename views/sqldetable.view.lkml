view: sqldetable {
  derived_table: {
    sql: SELECT
          users.age  AS `users.age`,
          users.city  AS `users.city`,
          users.gender  AS `users.gender`,
          users.state  AS `users.state`,
          users.email  AS `users.email`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id
      WHERE (users.age < 90)
      GROUP BY
          1,
          2,
          3,
          4,
          5
      ORDER BY
          users.age

       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_age {
    type: number
    sql: ${TABLE}.`users.age` ;;
  }

  dimension: users_city {
    type: string
    sql: ${TABLE}.`users.city` ;;
  }

  dimension: users_gender {
    primary_key: yes
    type: string
    sql: ${TABLE}.`users.gender` ;;
  }

  dimension: users_state {
    type: string
    sql: ${TABLE}.`users.state` ;;
  }

  dimension: users_email {
    type: string
    sql: ${TABLE}.`users.email` ;;
  }

  set: detail {
    fields: [users_age, users_city, users_gender, users_state, users_email]
  }
}
