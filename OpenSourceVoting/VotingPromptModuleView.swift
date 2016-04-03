//
//  VotingPromptModuleView.swift
//  OpenSourceVoting
//
//  Created by Paul Wallace on 3/31/16.
//  Copyright © 2016 PaulWallace. All rights reserved.
//

import UIKit

//DESIGN CHOICE: HAVE THE FRAME PASSED INTO US, NOT DERIVE OURSELVES
//FOR FRAME CONSTRUCTION START TO LIST OUT THE PARAMS FIRST
//-- SHOULD ADD PROTOCOL FOR THIS CLASS AND THE PARENT CLASS

//LOTS OF REPEATED CODE IN CALCUALTEING THE X AND Y VALUES

//<div>Icons made by <a href="http://www.flaticon.com/authors/elegant-themes" title="Elegant Themes">Elegant Themes</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

let PROMPT_PADDING_LEFT : CGFloat = 0.05
let PROMPT_PADDING_RIGHT : CGFloat = 0.05
let PROMPT_PADDING_UP : CGFloat = 0.05
let PROMPT_PADDING_DOWN : CGFloat = 0.40

let DEFAULT_CORNER_RADIUS : CGFloat = 2.0

let MENU_IMAGE_STRING = "MenuButtonBlack"

class VotingPromptModuleView: UIView {

    var promptString : String!
    var promptLabel : UILabel!
    
    var timer: NSTimer!
    var timerLabel : UILabel!
    
    var voteTotalLabel : UILabel!
    
    var menuButton : UIButton!
    
    var timerInvalid : Bool = false
    
    init(promptString: String, frame: CGRect, time: String){
        super.init(frame: frame)
        
        self.promptString = promptString
        self.promptLabel = configureLabel(promptString, frame: frame) //returns a UILabel
        self.timerLabel = configureTimer(time)
        self.voteTotalLabel = configureVoteTotalLabel()
        self.menuButton = configureMenuButton()
        self.addSubview(self.promptLabel)
        self.addSubview(self.timerLabel)
        self.addSubview(self.menuButton)
        self.addSubview(self.voteTotalLabel)
        self.backgroundColor = SUBMIT_VOTE_BUTTON_COLOR
        
        //Start timer (May change this behavior later)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(VotingPromptModuleView.updateTimer), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel(promptString: String, frame: CGRect) -> UILabel{
        //construct the promptLabel
        let x = frame.width * PROMPT_PADDING_LEFT
        let y = frame.height * PROMPT_PADDING_UP
        let width = frame.width * (CGFloat(1.0) - (PROMPT_PADDING_RIGHT + PROMPT_PADDING_LEFT))
        let height = (frame.height) * (CGFloat(1.0) - (PROMPT_PADDING_DOWN + PROMPT_PADDING_UP))
        let tempPromptLabel = UILabel(frame: CGRectMake(x, y, width, height))
        tempPromptLabel.backgroundColor = PROMPT_LABEL_COLOR
        tempPromptLabel.text = promptString
        tempPromptLabel.textAlignment = .Center
        tempPromptLabel.numberOfLines = 0
        tempPromptLabel.minimumScaleFactor = 0.5
        tempPromptLabel.adjustsFontSizeToFitWidth = true
        tempPromptLabel.layer.cornerRadius = DEFAULT_CORNER_RADIUS
        tempPromptLabel.layer.masksToBounds = true
        return tempPromptLabel
    }
    
    func configureTimer(time: String) -> UILabel{
        let x : CGFloat = frame.width * PROMPT_PADDING_LEFT //frame.width * PROMPT_PADDING_LEFT
        let y = promptLabel.frame.maxY + frame.height * PROMPT_PADDING_UP //frame.height * PROMPT_PADDING_UP + promptLabel.frame.maxY
        let width = ((frame.width * (CGFloat(1.0) - (PROMPT_PADDING_RIGHT + PROMPT_PADDING_LEFT))) * 0.50) - frame.width * 0.1 - frame.width * PROMPT_PADDING_UP
//        let height = (frame.height) * (CGFloat(1) - (CGFloat(1) - (PROMPT_PADDING_DOWN + PROMPT_PADDING_UP) + PROMPT_PADDING_UP)) 
        
        let height = frame.height * PROMPT_PADDING_DOWN - (frame.height * (PROMPT_PADDING_UP * 2))
        let tempTimerLabel = UILabel(frame: CGRectMake(x, y, width, height))
        tempTimerLabel.text = time
        tempTimerLabel.textAlignment = .Center
        tempTimerLabel.textColor = UIColor.whiteColor()
        tempTimerLabel.font = UIFont(name: FONT_NAME_BOLD, size: 17)
        tempTimerLabel.backgroundColor = RED
        tempTimerLabel.layer.cornerRadius = DEFAULT_CORNER_RADIUS
        tempTimerLabel.layer.masksToBounds = true
        return tempTimerLabel
    }
    
    func configureVoteTotalLabel() -> UILabel{
        let x = frame.width * 0.50 + frame.width * 0.1 + frame.width * PROMPT_PADDING_UP

        let y = promptLabel.frame.maxY + frame.height * PROMPT_PADDING_UP
        let width = ((frame.width * (CGFloat(1.0) - (PROMPT_PADDING_RIGHT + PROMPT_PADDING_LEFT))) * 0.50)  - frame.width * 0.1 - frame.width * PROMPT_PADDING_UP
        //let height = (frame.height) * ( CGFloat(1) - (CGFloat(1) - (PROMPT_PADDING_DOWN + PROMPT_PADDING_UP) + PROMPT_PADDING_UP))
        let height = frame.height * PROMPT_PADDING_DOWN - (frame.height * (PROMPT_PADDING_UP * 2))
        let tempVTL = UILabel(frame: CGRectMake(x, y, width, height))
        tempVTL.text = "0"
        tempVTL.textAlignment = .Center
        tempVTL.textColor = UIColor.whiteColor()
        tempVTL.font = UIFont(name: FONT_NAME_BOLD, size: 17)
        tempVTL.backgroundColor = BLUE
        tempVTL.layer.cornerRadius = DEFAULT_CORNER_RADIUS
        tempVTL.layer.masksToBounds = true
        return tempVTL
    }
    
    func configureMenuButton() -> UIButton{
        
        let x = frame.width * 0.50 - frame.width * 0.1
        let y = promptLabel.frame.maxY + frame.height * PROMPT_PADDING_UP //SHOULD BE CHANGED TO SOMETHING NOT RELATIVE
        let width = frame.width * 0.2
//        let height = (frame.height) * ( CGFloat(1) - (CGFloat(1) - (PROMPT_PADDING_DOWN + PROMPT_PADDING_UP) + PROMPT_PADDING_UP))
        let height = frame.height * PROMPT_PADDING_DOWN - (frame.height * (PROMPT_PADDING_UP * 2))
        let tempMB = UIButton(frame: CGRectMake(x, y, width, height)) //temp menu button
        tempMB.backgroundColor = UIColor.whiteColor()
        tempMB.setImage(UIImage(named: MENU_IMAGE_STRING), forState: .Normal)
        tempMB.addTarget(self, action: #selector(VotingPromptModuleView.menuButtonPressed), forControlEvents: .TouchUpInside)
        tempMB.layer.cornerRadius = DEFAULT_CORNER_RADIUS
        tempMB.layer.masksToBounds = true
        return tempMB
    }
    
    func updateTimer(){
        //parse seconds
        let parsedArr : [String] = (self.timerLabel.text?.componentsSeparatedByString(":"))!
        var seconds : Int = Int(parsedArr[1])!
        var minutes : Int = Int(parsedArr[0])!
        seconds -= 1
        if(seconds == 0){
            if(minutes == 0){
                self.timer.invalidate()
                //self.timerLabel.textColor = RED
                self.timerLabel.text = "0:00"
                self.timerInvalid = true
                return
            }
        }
        if(seconds < 0){
            minutes -= 1
            seconds = 59
        }
        let sM = String(minutes)
        var sS = String(seconds)
        if(seconds < 10){
            sS = "0" + sS
        }
        self.timerLabel.text = sM + ":" + sS
    }
    
    func menuButtonPressed(){
        
    }
    
    func updateVoteTotalLabel(numOfVotes : Int){
        self.voteTotalLabel.text = String(numOfVotes)
    }
    
    func isTimerInvalid() -> Bool{
        return timerInvalid
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}


protocol VotingPrompt {
    func menuButtonPressed()
}

protocol VotingPromptDelegate {
    func displayOptions(menuView : MenuView)
}
