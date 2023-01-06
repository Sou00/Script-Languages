local lapis = require("lapis")
local db = require("lapis.db")
local respond_to
respond_to = require("lapis.application").respond_to
local Model
Model = require("lapis.db.model").Model
local Categories
do
  local _class_0
  local _parent_0 = Model
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Categories",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Categories = _class_0
end
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    ["/"] = function(self)
      return "Welcome to the food store!"
    end,
    ["/categories"] = respond_to({
      GET = function(self)
        local res = db.select("* from categories")
        return {
          json = res
        }
      end,
      POST = function(self)
        db.insert("categories", {
          name = self.params.name
        })
        return "Category added"
      end,
      PUT = function(self)
        db.update("categories", {
          name = self.params.name
        }, {
          id = self.params.id
        })
        return "Category updated"
      end,
      DELETE = function(self)
        local _ = db.delete("categories"), {
          name = self.params.name
        }
        return "Category deleted"
      end
    }),
    ["/products"] = respond_to({
      GET = function(self)
        local res = db.select("* from products")
        return {
          json = res
        }
      end,
      POST = function(self)
        db.insert("products", {
          name = self.params.name,
          category = self.params.category,
          price = self.params.price
        })
        return "Product added!"
      end,
      PUT = function(self)
        db.update("products", {
          price = self.params.price
        }, {
          name = self.params.name
        })
        return "Product updated!"
      end,
      DELETE = function(self)
        db.delete("products", {
          name = self.params.name
        })
        return "Product deleted!"
      end
    }),
    ["/categories/:name"] = function(self)
      local res = db.select("* from categories where name = ?", self.params.name)
      return {
        json = res
      }
    end,
    ["/category/:name"] = function(self)
      local res = db.select("* from products where category = ?", self.params.name)
      return {
        json = res
      }
    end,
    ["/products/:name"] = function(self)
      local res = db.select("* from products where name = ?", self.params.name)
      return {
        json = res
      }
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = nil,
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  return _class_0
end
