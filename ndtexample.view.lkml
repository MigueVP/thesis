view: ndtexample {



    derived_table: {
      explore_source: order_items {
        column: category { field: products.category }
        column: count { field: products.count }
      }
    }
    dimension: category {
      description: ""
    }
    dimension: count {
      description: ""
      type: number
    }
  }
