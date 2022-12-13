# This files contains your custom actions which can be used to run
# custom Python code.
#
# See this guide on how to implement these action:
# https://rasa.com/docs/rasa/custom-actions


# This is a simple example for a custom action which utters "Hello World!"

from typing import Any, Text, Dict, List
#
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
import traceback
from datetime import datetime
#
#
# class ActionHelloWorld(Action):
#
#     def name(self) -> Text:
#         return "action_hello_world"
#
#     def run(self, dispatcher: CollectingDispatcher,
#             tracker: Tracker,
#             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
#
#         dispatcher.utter_message(text="Hello World!")
#
#         return []
import json

class ActionGetMenu(Action):
    
    def name(self) -> Text:
        return "action_get_menu"
        
    def run(self, dispatcher: CollectingDispatcher,
             tracker: Tracker,
             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        try:
            filename = "menu.json"
            menu = dict()
            with open(filename, 'r') as f:
                menu = json.load(f)
            dispatcher.utter_message("Here is the menu")
            for item in menu:
                dispatcher.utter_message(item['name'] + " " + str(item['price']) + "$")
        except Exception as e:
            dispatcher.utter_message("Sorry we are down for the moment : "+str(e))

        return []
    
class ActionGetDate(Action):
    
    def name(self) -> Text:
        return "action_get_date"
        
    def run(self, dispatcher: CollectingDispatcher,
             tracker: Tracker,
             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        try:
            filename = "opening_hours.json"
            with open(filename, 'r') as f:
                opening = json.load(f)
            
            hour =""
            day = ""
       
            for item in tracker.latest_message['entities']:
                if item['entity'] == 'time':
                    hour = item['value']
                if item['entity'] == 'day':
                    day = item['value'].lower()
            #dispatcher.utter_message("hiho" +hour)
            #dispatcher.utter_message(hour.replace(":","."))
            if day == "today":
                    i = datetime.now().weekday()
                    weekdays = ["monday", "tuesday", "wednesday", "thursday","friday","saturday","sunday"]
                    day = weekdays[i]
            open_hour = opening[day.capitalize()]['open']
            close_hour = opening[day.capitalize()]['close']
            if hour != "":
                hour = float(hour.replace(":","."))
            
                if hour < close_hour and hour > open_hour:
                    dispatcher.utter_message("Yes, on " + day.capitalize() + "s we are open from "+str(open_hour)+" to "+ str(close_hour))
                elif day == "Sunday":
                     dispatcher.utter_message("No, we are closed on Sundays")
                else:
                    dispatcher.utter_message("No, on " + day.capitalize() + "s we are open from "+str(open_hour)+" to "+ str(close_hour))
            elif day == "sunday":
                dispatcher.utter_message("No, we are closed on Sundays")
            else:
                dispatcher.utter_message("On " + day.capitalize() + "s we are open from "+str(open_hour)+" to "+ str(close_hour))
        except Exception as e:
            dispatcher.utter_message("Sorry we are down for the moment : "+str(e))
            dispatcher.utter_message(traceback.format_exc())
        return []
    
    
class ActionGetOrder(Action):
    
    def name(self) -> Text:
        return "action_get_order"
        
    def run(self, dispatcher: CollectingDispatcher,
             tracker: Tracker,
             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        try:
            filename = "menu.json"
            menu = dict()
            with open(filename, 'r') as f:
                menu = json.load(f)
            
            food =""
            option = ""
            addition = ""
            for item in tracker.latest_message['entities']:
                if item['entity'] == 'food':
                    food = item['value'].lower()
                if item['entity'] == 'option':
                    option = item['value'].lower()
                if item['entity'] == 'addition':
                    addition = item['value'].lower()
            wasFound = 0
            for item in menu:
                if item['name'].lower() == food:
                    dispatcher.utter_message("You ordered: " + item['name'] + " "+option+" "+addition+" for " + str(item['price']) + "$")
                    dispatcher.utter_message("Your order will be ready in " + str(item['preparation_time']) + "h")
                    wasFound=1
            if wasFound == 0:
                dispatcher.utter_message("Your order could not be completed because there is no " + food +" on our menu")

        except Exception as e:
            dispatcher.utter_message("Sorry we are down for the moment : "+str(e))

        return []