local create_table, types
do
  local _obj_0 = require("lapis.db.schema")
  create_table, types = _obj_0.create_table, _obj_0.types
end
return {
  [1] = function(self)
    return create_table("categories", {
      {
        "id",
        types.serial
      },
      {
        "name",
        types.text
      },
      "PRIMARY KEY (id)"
    })
  end,
  [2] = function(self) end,
  create_table("products", {
    {
      "id",
      types.serial
    },
    {
      "category",
      types.text
    },
    {
      "name",
      types.text
    },
    {
      "price",
      types.double
    },
    "PRIMARY KEY (id)"
  })
}
