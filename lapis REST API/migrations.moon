-- migrations.moon

import create_table, types from require "lapis.db.schema"

{
  [1]: =>
    create_table "categories", {
      { "id", types.serial }
      { "name", types.text }

      "PRIMARY KEY (id)"
    },
    [2]: =>
    create_table "products", {
      { "id", types.serial }
      { "category", types.text }
      { "name", types.text }
      { "price", types.double }
      "PRIMARY KEY (id)"
    }
}