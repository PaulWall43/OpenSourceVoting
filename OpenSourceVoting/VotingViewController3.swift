//
//  VotingViewController3.swift
//  OpenSourceVoting
//
//  Created by Paul Wallace on 3/24/16.
//  Copyright © 2016 PaulWallace. All rights reserved.
//

//HOW CAN I USE ENUM'S HERE POSSIBLY

import UIKit

//I want this class to be the real open source class that people will use
//There should be multiple ways to create a VotingViewController 

let SCREEN_SIZE: CGRect = UIScreen.mainScreen().bounds

let FONT_NAME_BOLD = "ArialRoundedMTBold"

let FONT_NAME = "ArialRoundedMT"

let RED = UIColor(hue: 0.025, saturation: 0.72, brightness: 0.84, alpha: 1.0)
let BLUE = UIColor(hue: 0.56, saturation: 0.76, brightness: 0.86, alpha: 1.0)
let PURPLE = UIColor(hue: 0.786, saturation: 0.51, brightness: 0.71, alpha: 1.0)
let YELLOW = UIColor(hue: 0.133, saturation: 0.94, brightness: 0.95, alpha: 1.0)
let GREEN = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.68, alpha: 1.0)
let SELECTED_GRAY = UIColor(white: 0.67, alpha: 1.0)
let SUBMIT_VOTE_BUTTON_COLOR = UIColor(white: 0.20, alpha: 1.0)
let PROMPT_LABEL_COLOR = UIColor(white: 0.95, alpha: 1.0)

let DEFAULT_PROMPT = "What is the best method for traversing a tree in order to delete all the nodes in the tree and prevent memory leaks?"
let DEFAULT_NUM_ANS = 4
let DEFAULT_NUM_TIME = "1:00"
let DEFAULT_ANS_STRING_ARR = ["A", "B", "C", "D"]
let DEFAULT_ANS_COLOR_ARR = [RED, BLUE, PURPLE, YELLOW]
let DEFAULT_OP_COLOR_ARR = [GREEN, GREEN, GREEN, GREEN]

let SELECT_BUTTON_HEIGHT_PROPORTION : CGFloat = 0.125
let SELECT_BUTTON_LOC_PROPORTION : CGFloat = 0.75
let SUBMUT_BUTTON_HIEGHT_PROPORTION : CGFloat = 0.125
let SUBMIT_BUTTON_LOC_PROPORTION : CGFloat = 0.875

let MAX_BAR_HEIGHT_PROP : CGFloat = 0.50

let SELECT_BUTTON_HEIGHT = SCREEN_SIZE.height * SELECT_BUTTON_HEIGHT_PROPORTION
var SELECT_BUTTON_LOC = SCREEN_SIZE.height * SELECT_BUTTON_LOC_PROPORTION
let SUBMIT_BUTTON_HEIGHT = SCREEN_SIZE.height * SUBMUT_BUTTON_HIEGHT_PROPORTION
var SUBMIT_BUTTON_LOC = SCREEN_SIZE.height * SUBMIT_BUTTON_LOC_PROPORTION

let BAR_ANIMATE_TIME = 0.2


class VotingViewController3: UIViewController, VotingColumnDelegate, VotingPromptDelegate, MenuViewChildDelegate {
    /**** Instance Variables ****/
    var prompt : String!
    var numAns : Int!
    var numTime : String!
    var ansStringArr : [String]!
    var ansColorArr : [UIColor]! //Colors for the voting bars
    var opColorArr : [UIColor]! //Colors for the different select buttons
    var votingColumnArr : [ColumnSpaceView] = []
    
    var votingPromptModule : VotingPromptModuleView!
    
    
    var promptLabel : UILabel! //WILL BE DEPRECATED
    var submitVoteButton : UIButton = UIButton()
    
    var lastColumnSelected : ColumnSpaceView?
    var totalVotes : Int = 0
    
    var inNavigationStack : Bool = false
    var navBarOffset : CGFloat!
    
    var menuView : MenuView?
    var menuOpen : Bool = false
    
    var votingEnabled : Bool = true
    //WILL ADD A VOTINGMODULE INSTANCE VARIABLE TO THE PROTOCOL AND THIS CLASS TO TAKE OUT ALL THIS IMPLEMENTATION
    
    /**** Contstructors ****/
    convenience init() {
            self.init(prompt: DEFAULT_PROMPT, numAns: DEFAULT_NUM_ANS, numTime: DEFAULT_NUM_TIME, ansStringArr: DEFAULT_ANS_STRING_ARR, ansColorArr: DEFAULT_ANS_COLOR_ARR, opColorArr: DEFAULT_OP_COLOR_ARR)

    }
    
    init(_ coder: NSCoder? = nil, prompt : String, numAns : Int, numTime : String, ansStringArr : [String], ansColorArr : [UIColor], opColorArr : [UIColor]){
        
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
        
        self.navBarOffset = 0
        
        //either use loadView or viewDidLoad (will use viewDidLoad)
    }
    
    required convenience init?(coder : NSCoder) {
        self.init(coder, prompt: DEFAULT_PROMPT, numAns: DEFAULT_NUM_ANS, numTime: DEFAULT_NUM_TIME, ansStringArr: DEFAULT_ANS_STRING_ARR, ansColorArr: DEFAULT_ANS_COLOR_ARR, opColorArr: DEFAULT_OP_COLOR_ARR)
    }
    
    
    /****VIEW FUNCITONS****/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.navigationController?.navigationBar
        if nav != nil{
            inNavigationStack = true
            navBarOffset = self.navigationController?.navigationBar.frame.height
        }
        self.constructVotingModule()
        //Check for navigationBar

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
        //Prompt Label (DEPRECATED)
//        self.promptLabel = configurePromptLabel(self.getPrompt()) //prompt should be passed in
//        view.addSubview(promptLabel)
        
        
        //VotingPromptModule
        //Check for navigation bar
        let votingPromptModule = configureVotingPromptModule()
        view.addSubview(votingPromptModule)
        votingPromptModule.delegate = self
        
        //Submit Button
        self.submitVoteButton = configureSubmitVoteButton()
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
        tempSelectButton.titleLabel?.font = UIFont(name: FONT_NAME_BOLD, size: 22)
        tempSelectButton.setTitle(getAnsStringArr()[index], forState: .Normal) //Make getters setters
        tempSelectButton.backgroundColor = getOpColorArr()[index]
        return tempSelectButton
    }
    
    func configureCounterLabel(selectButtonWidth : CGFloat, index : Int) -> UILabel{
        let tempCounterLabel = UILabel(frame: CGRectMake(0, SELECT_BUTTON_LOC - 20, selectButtonWidth, 20))
        tempCounterLabel.font = UIFont(name: FONT_NAME_BOLD, size: 22)
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
    
    //DEPRECATED
    func configurePromptLabel(prompt: String) -> UILabel{
        let tempPromptLabel = UILabel(frame: CGRectMake(0, 20, SCREEN_SIZE.width, SCREEN_SIZE.height - ((SCREEN_SIZE.height * 0.50) + SUBMIT_BUTTON_HEIGHT + SELECT_BUTTON_HEIGHT + 20))) //kinda weird numbers here, there should be a constant for submitVoteButton
//        print (SCREEN_SIZE.height * 0.50)
//        print (SELECT_BUTTON_HEIGHT)
//        print (SUBMIT_BUTTON_HEIGHT)
        tempPromptLabel.backgroundColor = PROMPT_LABEL_COLOR
        tempPromptLabel.text = prompt
        tempPromptLabel.font = UIFont(name: FONT_NAME, size: 17)
        tempPromptLabel.textAlignment = .Center
        tempPromptLabel.numberOfLines = 0
        tempPromptLabel.layer.borderColor = SUBMIT_VOTE_BUTTON_COLOR.CGColor
        tempPromptLabel.layer.borderWidth = 30.0
        return tempPromptLabel
    }
    
    func configureVotingPromptModule() -> VotingPromptModuleView{
        
        let x : CGFloat = 0
        var y : CGFloat = 20.0
        let width = SCREEN_SIZE.width
        let height = SCREEN_SIZE.height - ((SCREEN_SIZE.height * MAX_BAR_HEIGHT_PROP) + SUBMIT_BUTTON_HEIGHT + SELECT_BUTTON_HEIGHT + 20)
        
        if (inNavigationStack){ //I guess?
            y = y + CGFloat((self.navigationController?.navigationBar.frame.height)!)
        }
        let tempFrame : CGRect = CGRectMake(x, y, width, height)
        
        //THIS IS CLASS SPECIFIC, ASSUMES CLASS HAS VOTINGPROMPTMODULE, CONSIDER REMOVING OR ADDING TO PROTOCOL
        self.votingPromptModule = VotingPromptModuleView(promptString: self.getPrompt(), frame: tempFrame, time: numTime)
        return self.votingPromptModule
    }
    
    func configureSubmitVoteButton() -> UIButton{
        let toReturn = UIButton(frame: CGRect(x: 0, y: SUBMIT_BUTTON_LOC, width: SCREEN_SIZE.width, height: SELECT_BUTTON_HEIGHT))
        toReturn.backgroundColor = SUBMIT_VOTE_BUTTON_COLOR//UIColor.clearColor()//
        toReturn.titleLabel?.font = UIFont(name: FONT_NAME_BOLD, size: 17)
        toReturn.setTitle("Submit Vote", forState: UIControlState.Normal)
        toReturn.addTarget(self, action: #selector(VotingViewController3.voteSubmitted), forControlEvents: .TouchUpInside)
        return toReturn
    }
    

    /****DELEGATE METHODS****/
    func voteSubmitted() {
        
        
        //implement here
        if(votingPromptModule.isTimerInvalid() || !votingEnabled){
            return //SHOULD PROVIDE SOME NOTIFICATION IN THE FUTURE
        }
        if lastColumnSelected != nil {
            lastColumnSelected?.numOfVotes += 1
        } else {
            
        }
        totalVotes += 1
        votingPromptModule.updateVoteTotalLabel(totalVotes)
        updateBarHeightsAndCount()
        
    }
    
    
    //holdCol.getVotingBarFrame().minY - (newBarHeight - holdCol.getBarHeight())
    func updateBarHeightsAndCount(){
        for i in 0...votingColumnArr.count - 1{
            let holdCol = votingColumnArr[i]
            let newBarHeight = calcNewBarHeights(holdCol)
            if(newBarHeight != holdCol.getBarHeight()){
                let newFrame = CGRectMake(0, (SCREEN_SIZE.height) - newBarHeight - holdCol.getSelectButtonFrame().height - getSubmitVoteButtonFrame().height, holdCol.getVotingBarFrame().width, newBarHeight + holdCol.getSelectButtonFrame().height + getSubmitVoteButtonFrame().height )
                
//                print ("HEY: \(holdCol.getSelectButtonFrame().height)")
//                print ("HEY: \(newBarHeight)")
//                print ("HEY: \(getSubmitVoteButtonFrame().height)")
                UIView.animateWithDuration(BAR_ANIMATE_TIME , animations: {
                    holdCol.setVotingBarFrame(newFrame)
                })
            }
            if holdCol == lastColumnSelected{
                holdCol.setCounterLabel()
            }
            holdCol.setNewBarHeight(newBarHeight) //useless for now
        }
    }
    
    func calcNewBarHeights(column : ColumnSpaceView) -> CGFloat{
        var newBarHeight : CGFloat = 0
        if (totalVotes != 0){
            newBarHeight = (CGFloat(column.getNumOfVotes())/CGFloat(totalVotes) * ((SCREEN_SIZE.height) * (MAX_BAR_HEIGHT_PROP - (navBarOffset/SCREEN_SIZE.height))))
        }
        if (newBarHeight > ((SCREEN_SIZE.height) * (MAX_BAR_HEIGHT_PROP - (navBarOffset/SCREEN_SIZE.height)))){
            newBarHeight = (SCREEN_SIZE.height) * (MAX_BAR_HEIGHT_PROP - (navBarOffset/SCREEN_SIZE.height))
        }
//        if (newBarHeight - navBarOffset > 0){
//            newBarHeight = newBarHeight - navBarOffset
//        }
        return newBarHeight
    }
    
    func ansSelected(index: Int) {
        if(lastColumnSelected != nil){
            lastColumnSelected?.setSelectButtonColor(opColorArr[(lastColumnSelected?.getIndex())!])
        }
        lastColumnSelected = votingColumnArr[index]
        
        lastColumnSelected!.setSelectButtonColor(SELECTED_GRAY)
    }
    
    
    /****VOTING PROMPT DELEGATE METHODS****/
    func displayOptions(){
        //make the frame
        //We want the frame a below the votingPromptModule
        let x = self.view.frame.width * 0.10
        let y = (SCREEN_SIZE.height - ((SCREEN_SIZE.height * MAX_BAR_HEIGHT_PROP) + SUBMIT_BUTTON_HEIGHT + SELECT_BUTTON_HEIGHT + 20)) + 20 + PROMPT_PADDING_UP * self.view.frame.width
        let width = self.view.frame.width * 0.80
        let height = SCREEN_SIZE.height * MAX_BAR_HEIGHT_PROP - 20 - (PROMPT_PADDING_UP * self.view.frame.width) * 2
        
        if (!menuOpen){
            
            let tempFrame = CGRectMake(x,y,width,0)
            let tempMenuView = MenuView(frame: tempFrame)
            UIView.animateWithDuration(0.2, animations: {
                tempMenuView.resetFrame(CGRectMake(x,y,width,height), isPaused: self.votingPromptModule.isPaused, isPausedVote: !self.votingEnabled) //!votingEnabled == votingPaused
            })
            tempMenuView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
            self.view.addSubview(tempMenuView)
            
            tempMenuView.delegate = self
            menuView = tempMenuView
            menuOpen = true
        } else {
            //close the menu
            menuView?.removeFromSuperview()
            menuView = nil
            menuOpen = false
        }
        
    }
    
    
    /****MenuView Delegate methods****/
    func pauseTime(){
        self.votingPromptModule.pauseOrStartTime()
        self.menuView?.updatePauseLabel()
    }
    
    func pauseVoting(){
        self.updateVotingEnabled()
        //change the label of the menu
        self.menuView!.updateVoteLabel()
    }
    
    func pauseBoth(){
        sVotingEnabled(false) //setVotingEnabled
        self.menuView!.updateVoteLabel()
        
        self.votingPromptModule.setVoteTimer(false)
        self.menuView?.updatePauseLabel()
        
    }
    
    func resetAll(){print("here")}
    
    func editTime(){print("here")}
    
    func newQuestion(){print("here")}
    
    func closePoll(){print("here")}
    
    func editPrompt(){print("here")}
    
    
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
    
    func getNumTime() -> String{
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
    
    func updateVotingEnabled(){
        self.votingEnabled = !self.votingEnabled
        
        
    }
    
    func sVotingEnabled(val : Bool){
        self.votingEnabled = val
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
