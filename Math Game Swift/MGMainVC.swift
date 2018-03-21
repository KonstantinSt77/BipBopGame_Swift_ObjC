//
//  MGMainVC.swift
//  Math Game Swift
//
//  Created by Konstantin on 21.03.2018.
//  Copyright © 2018 Stolyarenko Konstantin. All rights reserved.
//

import UIKit

class MGMainVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bipTxtField: UITextField!
    @IBOutlet var bopTextField: UITextField!
    var resultArray = [MGBipBopModel]()
    var firstNumber = ""
    var lastNumber = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initViewDesign()
    }
    
    func initViewDesign()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.bipTxtField.delegate = self
        self.bipTxtField.tag = 1
        self.bipTxtField.layer.borderWidth = 2.0
        self.bipTxtField.layer.borderColor = UIColor.blue.cgColor
        self.bipTxtField.layer.cornerRadius = 20
        self.bipTxtField.clipsToBounds = true
        
        self.bopTextField.delegate = self
        self.bopTextField.tag = 2
        self.bopTextField.layer.borderWidth = 2.0
        self.bopTextField.layer.borderColor = UIColor.blue.cgColor
        self.bopTextField.layer.cornerRadius = 20
        self.bopTextField.clipsToBounds = true
    }
    
    @IBAction func refreshScreen(_ sender: Any)
    {
        self.resultArray.removeAll()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ResultCellID", for: indexPath) as! MGTableViewCell
        let bipBopModel = resultArray[indexPath.row]
        cell.customLabel.text = bipBopModel.modelTitle
        cell.customLabel.textAlignment = NSTextAlignment(rawValue: Int(truncating: bipBopModel.modelPosition))! 
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.resultArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if(textField.tag == 1)
        {
            self.firstNumber = textField.text!
            self.resultArray.removeAll()
        }
        else
        {
            self.lastNumber = textField.text!
            self.resultArray.removeAll()
        }
        self.generateSequence(firstNumberStr: self.firstNumber, lastNumberStr: self.lastNumber)
    }
    

    func generateSequence(firstNumberStr:String, lastNumberStr:String)
    {
        if((firstNumberStr.count > 0) && (lastNumberStr.count > 0))
        {
            let firstNumber = Int(firstNumberStr)!
            let lastNumber = Int(lastNumberStr)!
            
            if((lastNumber > firstNumber) && (lastNumber > 0) && (firstNumber > 0))
            {
                for i in firstNumber...lastNumber
                {
                    if((i % firstNumber) == 0 && (i % lastNumber) == 0)
                    {
                        let bipBopModel = MGBipBopModel(modelTitle:String(i) + "Bip Bop", modelPosition: 1)
                        self.resultArray.append(bipBopModel)
                    }
                    else if((i % firstNumber) == 0)
                    {
                        let bipBopModel = MGBipBopModel(modelTitle:String(i) + "Bip", modelPosition: 0)
                        self.resultArray.append(bipBopModel)
                    }
                    else if((i % lastNumber) == 0)
                    {
                        let bipBopModel = MGBipBopModel(modelTitle:String(i) + "Bop", modelPosition: 2)
                        self.resultArray.append(bipBopModel)
                    }
                    else
                    {
                        let bipBopModel = MGBipBopModel(modelTitle:String(i), modelPosition: 1)
                        self.resultArray.append(bipBopModel)
                    }
                }
            }
            else
            {
                    self.resultArray.removeAll()
            }
            
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
