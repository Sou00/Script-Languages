lapis = require "lapis"
db = require "lapis.db"
import respond_to from require "lapis.application"

import Model from require "lapis.db.model"

class Categories extends Model

class extends lapis.Application
  "/": =>
    "Welcome to the food store!"
  "/categories": respond_to{
    GET: =>
      res = db.select "* from categories"
      json: res

    POST: =>
      db.insert "categories", { name: @params.name }
      "Category added"
    PUT: =>
      db.update "categories", {
        name: @params.name
        },
        {
          id: @params.id
          } 
      "Category updated"
    
    DELETE: =>
      db.delete"categories", {
        name: @params.name
        }
      "Category deleted"
  }
  "/products": respond_to{
    GET: =>
      res = db.select "* from products"
      json: res

    POST: =>
      db.insert "products", {
        name: @params.name
        category: @params.category
        price: @params.price
        }
      "Product added!"

    PUT: =>
      db.update "products", {
        price: @params.price
        },
        {
          name: @params.name
          } 
      "Product updated!"
    
    DELETE: =>
      db.delete "products", {
        name: @params.name
        }
      "Product deleted!"
  }  
  "/categories/:name": =>
    res = db.select "* from categories where name = ?", @params.name
    json: res
  "/category/:name": =>
    res = db.select "* from products where category = ?", @params.name
    json: res
  "/products/:name": =>
    res = db.select "* from products where name = ?", @params.name
    json: res
 
