//
//  ViewController.swift
//  XML
//
//  Created by Ouriel Bennathan on 03/03/2022.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate{

        //our site  : https://www.boi.org.il/currency.xml
        // tags : NAME UNIT CURRENCYCODE COUNTRY RATE CHANGE
     
        //string wich indicates our result
        var display:String = ""
        
        //boolean which indicate an element name
        var passName = false ,passUnit = false , passCode = false, passCountry = false , passRate = false , passChange = false
        
        //we need xml parser
        var parser = XMLParser()
        //our site of currencys
        let myUrl:String = "https://www.boi.org.il/currency.xml"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //let start our work
            print ("Load XML")
            
            //convert to URL
            let url:URL = URL(string: myUrl)!
            //use our parser for getting the information as String
            parser = XMLParser(contentsOf: url)!
            //let the parser use the function in this class
            parser.delegate = self
            //to use the parser function in other class
            //just use the syntex : parser.delegate = otherclass
            
            let allOK:Bool = parser.parse()
            if  allOK {
                print ("we have an xml\nour resultL\n\(display)")
            } else {
                print ("Error in data")
            }
        }
        
        //start of element
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            //check  if  we have start element
            switch elementName {
            case "NAME":
                passName=true
            case "UNIT":
                passUnit=true
            case "CURRENCYCODE":
                passCode=true
            case "COUNTRY":
                passCountry=true
            case "RATE":
                passRate=true
            case "CHANGE":
                passChange=true
            default:
                break
            }
        }
        
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            if passName{
                display += "name:\(string)"
            }
            if  passUnit {
                display += "\t unit:\(string)"
            }
            if passCode {
                display += "\t Currency Code:\(string)"
            }
            if passCountry {
                display += "\t Country:\(string)"
            }
            if passRate {
                display += "\t rate:\(string)"
            }
            if passChange {
                display += "\t change:\(string)\n"
            }
        }
     
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            //check  if  we have end element
            switch elementName {
            case "NAME":
                passName=false
            case "UNIT":
                passUnit=false
            case "CURRENCYCODE":
                passCode=false
            case "COUNTRY":
                passCountry=false
            case "RATE":
                passRate=false
            case "CHANGE":
                passChange=false
            default:
                break
            }
        }
        
        func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
            print ("error:\(parseError)")
        }
     
    


}

