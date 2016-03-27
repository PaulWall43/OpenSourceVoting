//
//  VotingViewController3.swift
//  OpenSourceVoting
//
//  Created by Paul Wallace on 3/24/16.
//  Copyright © 2016 PaulWallace. All rights reserved.
//

import UIKit

//I want this class to be the real open source class that people will use
//There should be multiple ways to create a VotingViewController 

let SCREEN_SIZE: CGRect = UIScreen.mainScreen().bounds

let RED = UIColor(hue: 0.025, saturation: 0.72, brightness: 0.84, alpha: 1.0)
let BLUE = UIColor(hue: 0.56, saturation: 0.76, brightness: 0.86, alpha: 1.0)
let PURPLE = UIColor(hue: 0.786, saturation: 0.51, brightness: 0.71, alpha: 1.0)
let YELLOW = UIColor(hue: 0.133, saturation: 0.94, brightness: 0.95, alpha: 1.0)
let GREEN = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.68, alpha: 1.0)

let SELECT_BUTTON_HEIGHT_PROPORTION : CGFloat = 0.125
let SUBMUT_BUTTON_HIEGHT_PROPORTION : CGFloat = 0.125
let SELECT_BUTTON_LOC_PROPORTION : CGFloat = 0.75
let SUBMIT_BUTTON_LOC_PROPORTION : CGFloat = 0.875

let SELECT_BUTTON_HEIGHT = SCREEN_SIZE.height * SELECT_BUTTON_HEIGHT_PROPORTION
var SELECT_BUTTON_LOC = SCREEN_SIZE.height * SELECT_BUTTON_LOC_PROPORTION
var SUBMIT_BUTTON_LOC = SCREEN_SIZE.height * SUBMIT_BUTTON_LOC_PROPORTION

//let SUBMIT_BUTTON_HEIGHT = SELECT_BUTTON_HEIGHT // Not currently used, can be used for further customization


class VotingViewController3: UIViewController {
    /**** Instance Variables ****/
    var prompt : String!
    var numAns : Int!
    var numTime : Double!
    var ansStringArr : [String]!
    var ansColorArr : [UIColor]! //Colors for the voting bars
    var opColorArr : [UIColor]! //Colors for the different select buttons
    var votingColumnArr : [ColumnSpaceView] = []
    var submitVoteButton : UIButton = UIButton()
    
    /**** Contstructors ****/
    convenience init() {
            self.init(prompt: "Set a prompt here", numAns: 4, numTime: 5.00, ansStringArr: ["A", "B", "C", "D"], ansColorArr: [RED, BLUE, PURPLE, YELLOW], opColorArr: [GREEN, GREEN, GREEN, GREEN])

    }
    
    init( prompt : String, numAns : Int, numTime : Double, ansStringArr : [String], ansColorArr : [UIColor], opColorArr : [UIColor]){
        super.init(nibName: nil, bundle: nil)
        self.prompt = prompt
        self.numAns = numAns
        self.numTime = numTime
        self.ansStringArr = ansStringArr
        self.ansColorArr = ansColorArr
        self.opColorArr = opColorArr
        
        
        //either use loadView or viewDidLoad (will use viewDidLoad)
    }
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        self.prompt = "Set a prompt here"
        self.numAns = 4
        self.numTime = 5.00
        self.ansStringArr = ["A", "B", "C", "D"]
        self.ansColorArr = [RED, BLUE, PURPLE, YELLOW]
        self.opColorArr = [GREEN, GREEN, GREEN, GREEN]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.constructVotingModule()
        // Do any additional setup after loading the view.
    }

    
    func constructVotingModule(){
        //Voting proportions

        
        //calculate the numbers according to the parameters of the constructor
        //let selectButtonWidth = SCREEN_SIZE.width * CGFloat(1/numAns) //Could be a let
        let selectButtonWidth = SCREEN_SIZE.width * 0.25
        //Add navigation components
        
        for i in 0...numAns - 1{
            //construct the pieces that you need
            
            //selectButtonWidth * CGFloat(i)
            
            //Configure the columnSpace Frame
            var columnFrame : CGRect = CGRectMake(selectButtonWidth * CGFloat(i), 0, selectButtonWidth, SCREEN_SIZE.height)
            
            //Configure the voting bar
            var votingBar : UILabel = UILabel(frame: CGRect(x: 0, y: SELECT_BUTTON_LOC, width: selectButtonWidth, height: 0))
            votingBar.backgroundColor = getAnsColorArr()[i]
            votingBar.minimumScaleFactor = 0.5 //What is this for??
            
            
            //Configure the counter label for number of votes
            var counterLabel : UILabel = UILabel(frame: CGRect(x: 0, y: SELECT_BUTTON_LOC - 20, width: selectButtonWidth, height: 20))
            counterLabel.font = UIFont(name: "ArialRoundedMTBold", size: 22)
            counterLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
            counterLabel.text = "0"
            counterLabel.textAlignment = .Center
            
            //Configure the select button for this answer
            var selectButton : UIButton = UIButton(frame: CGRectMake(0, SELECT_BUTTON_LOC, selectButtonWidth, SELECT_BUTTON_HEIGHT))
            selectButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 22)
            selectButton.setTitle(getAnsStringArr()[i], forState: .Normal) //Make getters setters
            selectButton.backgroundColor = getOpColorArr()[i]
            
            var columnSpaceView : ColumnSpaceView = ColumnSpaceView(frame: columnFrame, votingBar: votingBar, selectButton: selectButton, counterLabel: counterLabel)
            
            view.addSubview(columnSpaceView)
        }
        
        //Submit Button
        submitVoteButton = UIButton(frame: CGRect(x: 0, y: SUBMIT_BUTTON_LOC, width: SCREEN_SIZE.width, height: SELECT_BUTTON_HEIGHT))
        submitVoteButton.backgroundColor = UIColor(white: 0.20, alpha: 1)
        submitVoteButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        submitVoteButton.setTitle("Submit Vote", forState: UIControlState.Normal)
        view.addSubview(submitVoteButton)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /****GETTERS****/
    func getPrompt() -> String{
        return prompt
    }
    
    func getNumAns() -> Int{
        return numAns
    }
    
    func getNumTime() -> Double{
        return numTime
    }
    
    func getAnsStringArr() -> [String]{
        return ansStringArr
    }
    
    func getAnsColorArr() -> [UIColor]{
        return ansColorArr
    }
    
    func getOpColorArr() -> [UIColor]{
        return opColorArr
    }
    
    func getVotingColumnArr() -> [ColumnSpaceView]{
        return votingColumnArr
    }
    
    /**** SETTERS ****/
    //Incomplete..
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
