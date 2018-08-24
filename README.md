# Demo_Wafer
#First of all, from given API consuming data using URLSessionDataTask (no third party SDK used and native apple provided API)

#Using latest decodable protocol to map/decode json to required struct

#No need to parse unnecessary data and map it to our struct(because only country, currency and language only required here)

#Custom cell (dynamic height based on data(Country name, currency name and language name)

#Helper functions to filter first language and currency in case multiple records available(keeping business
logic in function where in we can change it to second if required in future)

#Keeping struct properties optional because of safe coding and expectation of null in API response

#APIManager returns only collection with custom objects already filled in to be used for showing in tableview data

#For swipe to delete as we are supporting ios 10 and later and no customisation of icon available for editing capability and hence
utilised swipe and tap gesture recognizer on cell

#Using affine transformation we are extending cell to show clipped delete button(bomb icon) on swipe direction left

#Also using tap gesture event , we remove delete button and form cell in original state

#Now, due to issue of clipped(delete button not beinng in bound of parenttableviewcell); we allow that gesture using hittest method and
points observation if they are within range SO ALLWOING hitTest FOR THAT delete button event(No third party solution but step by step
solution to solve the given problem utilising existing tacticts i.e APIs, UIKit delegate methods , gesture recognizer APIs etc
)

-->Only constraint over here is anchor point decision and fast/slow swipe past anchor point of delete button 

