//
//  VotingViewController3.swift
//  OpenSourceVoting
//
//  Created by Paul Wallace on 3/24/16.
//  Copyright © 2016 PaulWallace. All rights reserved.
//

//HOW CAN I USE NUM'S HERE POSSIBLY

import UIKit

//I want this class to be the real open source class that people will use
//There should be multiple ways to create a VotingViewController 

let SCREEN_SIZE: CGRect = UIScreen.mainScreen().bounds

let FONT_NAME = "ArialRoundedMTBold"

let RED = UIColor(hue: 0.025, saturation: 0.72, brightness: 0.84, alpha: 1.0)
let BLUE = UIColor(hue: 0.56, saturation: 0.76, brightness: 0.86, alpha: 1.0)
let PURPLE = UIColor(hue: 0.786, saturation: 0.51, brightness: 0.71, alpha: 1.0)
let YELLOW = UIColor(hue: 0.133, saturation: 0.94, brightness: 0.95, alpha: 1.0)
let GREEN = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.68, alpha: 1.0)

let DEFAULT_PROMPT = "Set a prompt here"
let DEFAULT_NUM_ANS = 4
let DEFAULT_NUM_TIME = 5.00
let DEFAULT_ANS_STRING_ARR = ["A", "B", "C", "D"]
let DEFAULT_ANS_COLOR_ARR = [RED, BLUE, PURPLE, YELLOW]
let DEFAULT_OP_COLOR_ARR = [GREEN, GREEN, GREEN, GREEN]

let SELECT_BUTTON_HEIGHT_PROPORTION : CGFloat = 0.125
let SUBMUT_BUTTON_HIEGHT_PROPORTION : CGFloat = 0.125
let SELECT_BUTTON_LOC_PROPORTION : CGFloat = 0.75
let SUBMIT_BUTTON_LOC_PROPORTION : CGFloat = 0.875

let SELECT_BUTTON_HEIGHT = SCREEN_SIZE.height * SELECT_BUTTON_HEIGHT_PROPORTION
var SELECT_BUTTON_LOC = SCREEN_SIZE.height * SELECT_BUTTON_LOC_PROPORTION
var SUBMIT_BUTTON_LOC = SCREEN_SIZE.height * SUBMIT_BUTTON_LOC_PROPORTION

//let SUBMIT_BUTTON_HEIGHT = SELECT_BUTTON_HEIGHT // Not currently used, can be used for further customization


class VotingViewController3: UIViewController, VotingColumnDelegate {
    /**** Instance Variables ****/
    var prompt : String!
    var numAns : Int!
    var numTime : Double!
    var ansStringArr : [String]!
    var ansColorArr : [UIColor]! //Colors for the voting bars
    var opColorArr : [UIColor]! //Colors for the different select buttons
    var votingColumnArr : [ColumnSpaceView] = []
    var submitVoteButton : UIButton = UIButton()
    var lastColumnSelected : ColumnSpaceView?
    var totalVotes : Int = 0
    
    /**** Contstructors ****/
    convenience init() {
            self.init(prompt: DEFAULT_PROMPT, numAns: DEFAULT_NUM_ANS, numTime: DEFAULT_NUM_TIME, ansStringArr: DEFAULT_ANS_STRING_ARR, ansColorArr: DEFAULT_ANS_COLOR_ARR, opColorArr: DEFAULT_OP_COLOR_ARR)

    }
    
    init(_ coder: NSCoder? = nil, prompt : String, numAns : Int, numTime : Double, ansStringArr : [String], ansColorArr : [UIColor], opColorArr : [UIColor]){
        
        if let coder = coder{
            super.init(coder: coder)! //Seems like it works lol
        } else {
            super.init(nibName: nil, bundle: nil)
        }
        self.prompt = prompt
        self.numAns = numAns
        self.numTime = numTime
        self.ansStringArr = ansStringArr
        self.ansColorArr = ansColorArr
        self.opColorArr = opColorArr
        
        
        //either use loadView or viewDidLoad (will use viewDidLoad)
    }
    
    required convenience init?(coder : NSCoder) {
        self.init(coder, prompt: DEFAULT_PROMPT, numAns: DEFAULT_NUM_ANS, numTime: DEFAULT_NUM_TIME, ansStringArr: DEFAULT_ANS_STRING_ARR, ansColorArr: DEFAULT_ANS_COLOR_ARR, opColorArr: DEFAULT_OP_COLOR_ARR)
    }
    
    
    /****VIEW FUNCITONS****/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constructVotingModule()
    }

    
    func constructVotingModule(){
        //Voting proportions

        //calculate the numbers according to the parameters of the constructor
        //let selectButtonWidth = SCREEN_SIZE.width * CGFloat(1/numAns) //Could be a let
        let selectButtonWidth = SCREEN_SIZE.width * CGFloat(1/CGFloat(numAns))
        //Add navigation components
        
        for i in 0...numAns - 1{
            //construct the pieces that you need
            //Configure the columnSpace Frame
            let columnFrame : CGRect = configureColumnFrame(selectButtonWidth, index: i)
            //Configure the voting bar
            let votingBar : UILabel = configureVotingBar(selectButtonWidth, index: i)
            //Configure the select button for this answer
            let selectButton : UIButton = configureSelectButton(selectButtonWidth, index: i)
            //Configure the counter label for number of votes
            let counterLabel : UILabel = configureCounterLabel(selectButtonWidth, index: i)
            let columnSpaceView : ColumnSpaceView = configureColumnSpaceView(i, frame: columnFrame, votingBar: votingBar, selectButton: selectButton, counterLabel: counterLabel)
            votingColumnArr.append(columnSpaceView)
            view.addSubview(columnSpaceView)
            columnSpaceView.delegate = self
        }
        //Submit Button
        submitVoteButton = configureSubmitVoteButton()
        view.addSubview(submitVoteButton)
        
    }
    
    /****CONFIGURATION FUNCTIONS****/
    func configureColumnFrame(selectButtonWidth : CGFloat, index : Int) -> CGRect{
        return CGRectMake(selectButtonWidth * CGFloat(index), 0, selectButtonWidth, SCREEN_SIZE.height)
    }
    
    func configureVotingBar(selectButtonWidth : CGFloat, index : Int) -> UILabel{
        let tempVotingBar = UILabel(frame: CGRectMake( 0, SELECT_BUTTON_LOC, selectButtonWidth, 0))
        tempVotingBar.backgroundColor = getAnsColorArr()[index]
        //tempVotingBar.minimumScaleFactor = 0.5 //What is this for??
        return tempVotingBar
    }
    
    func configureSelectButton(selectButtonWidth : CGFloat, index : Int) -> UIButton{
        let tempSelectButton = UIButton(frame: CGRectMake(0, SELECT_BUTTON_LOC, selectButtonWidth, SELECT_BUTTON_HEIGHT))
        tempSelectButton.titleLabel?.font = UIFont(name: FONT_NAME, size: 22)
        tempSelectButton.setTitle(getAnsStringArr()[index], forState: .Normal) //Make getters setters
        tempSelectButton.backgroundColor = getOpColorArr()[index]
        return tempSelectButton
    }
    
    func configureCounterLabel(selectButtonWidth : CGFloat, index : Int) -> UILabel{
        let tempCounterLabel = UILabel(frame: CGRectMake(0, SELECT_BUTTON_LOC - 20, selectButtonWidth, 20))
        tempCounterLabel.font = UIFont(name: FONT_NAME, size: 22)
        tempCounterLabel.textColor = UIColor.blackColor()//UIColor(white: 0.0, alpha: 1.0)
        tempCounterLabel.text = "0"
        tempCounterLabel.textAlignment = .Center
        return tempCounterLabel
    }
    
    func configureColumnSpaceView(selfIndex: Int,
                                  frame: CGRect,
                                  votingBar: UILabel,
                                  selectButton: UIButton,
                                  counterLabel: UILabel) -> ColumnSpaceView{
        return ColumnSpaceView(selfIndex: selfIndex,
                               frame: frame,
                               votingBar: votingBar,
                               selectButton: selectButton,
                               counterLabel: counterLabel)
        
    }
    
    func configureSubmitVoteButton() -> UIButton{
        let toReturn = UIButton(frame: CGRect(x: 0, y: SUBMIT_BUTTON_LOC, width: SCREEN_SIZE.width, height: SELECT_BUTTON_HEIGHT))
        toReturn.backgroundColor = UIColor(white: 0.20, alpha: 1)//UIColor.clearColor()//
        toReturn.titleLabel?.font = UIFont(name: FONT_NAME, size: 17)
        toReturn.setTitle("Submit Vote", forState: UIControlState.Normal)
        toReturn.addTarget(self, action: #selector(VotingViewController3.voteSubmitted), forControlEvents: .TouchUpInside)
        return toReturn
    }
    

    /****DELEGATE METHODS****/
    func voteSubmitted() {
        //implement here
        if lastColumnSelected != nil {
            lastColumnSelected?.numOfVotes += 1
        }
        totalVotes += 1
        updateBarHeightsAndCount()
    }
    
    
    //holdCol.getVotingBarFrame().minY - (newBarHeight - holdCol.getBarHeight())
    func updateBarHeightsAndCount(){
        for i in 0...votingColumnArr.count - 1{
            let holdCol = votingColumnArr[i]
            let newBarHeight = calcNewBarHeights(holdCol)
            if(newBarHeight != holdCol.getBarHeight()){
                let newFrame = CGRectMake(0, SCREEN_SIZE.height - newBarHeight - holdCol.getSelectButtonFrame().height - getSubmitVoteButtonFrame().height, holdCol.getVotingBarFrame().width, newBarHeight + holdCol.getSelectButtonFrame().height + getSubmitVoteButtonFrame().height)
                UIView.animateWithDuration(0.2 , animations: {
                    holdCol.setVotingBarFrame(newFrame)
                })
                
                if holdCol == lastColumnSelected{
                    holdCol.setCounterLabel()
                }
                
                holdCol.setNewBarHeight(newBarHeight) //useless for now
            }

        }
    }
    
    func calcNewBarHeights(column : ColumnSpaceView) -> CGFloat{
        var newBarHeight : CGFloat = 0
        if (totalVotes != 0){
            newBarHeight = (CGFloat(column.getNumOfVotes())/CGFloat(totalVotes) * SCREEN_SIZE.height * 0.50)
        }
        if (newBarHeight > (SCREEN_SIZE.height * 0.50)){
            newBarHeight = SCREEN_SIZE.height * 0.50
        }
        return newBarHeight
    }
    
    func ansSelected(index: Int) {
        lastColumnSelected = votingColumnArr[index]
        print("\(votingColumnArr[index].selectButtonLabel.text) was selected")
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
    
    func getSubmitVoteButtonFrame() -> CGRect{
        return submitVoteButton.frame
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
