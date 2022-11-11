view: nativederivedtable {

    derived_table: {
      explore_source: order_items {
        column: category { field: products.category }
        column: count { field: products.count }
        column: brand { field: products.brand }
        filters: {
          field: products.category
          value: "Accessories"
        }
      }
    }
    dimension: category {
      description: ""
    }
    dimension: count {
      description: ""
      type: number
    }
    dimension: brand {
      description: ""
    }
  }
