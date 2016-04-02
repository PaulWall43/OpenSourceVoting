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

let PROMPT_PADDING_LEFT : CGFloat = 0.05
let PROMPT_PADDING_RIGHT : CGFloat = 0.05
let PROMPT_PADDING_UP : CGFloat = 0.05
let PROMPT_PADDING_DOWN : CGFloat = 0.40

class VotingPromptModuleView: UIView {

    var promptString : String!
    var promptLabel : UILabel!
    
    var timer: NSTimer!
    var timerLabel : UILabel!
    
    var voteTotalLabel : UILabel!
    
    var timerInvalid : Bool = false
    
    init(promptString: String, frame: CGRect, time: String){
        super.init(frame: frame)
        
        self.promptString = promptString
        self.promptLabel = configureLabel(promptString, frame: frame) //returns a UILabel
        self.timerLabel = configureTimer(time)
        self.voteTotalLabel = configureVoteTotalLabel()
        self.addSubview(self.promptLabel)
        self.addSubview(self.timerLabel)
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
        return tempPromptLabel
    }
    
    func configureTimer(time: String) -> UILabel{
        let x : CGFloat = 0 //frame.width * PROMPT_PADDING_LEFT
        let y = promptLabel.frame.maxY //frame.height * PROMPT_PADDING_UP + promptLabel.frame.maxY
        let width = (frame.width * (CGFloat(1.0) - (PROMPT_PADDING_RIGHT + PROMPT_PADDING_LEFT))) * 0.50
        let height = (frame.height) * ( CGFloat(1) - (CGFloat(1) - (PROMPT_PADDING_DOWN + PROMPT_PADDING_UP) + PROMPT_PADDING_UP))
        let tempTimerLabel = UILabel(frame: CGRectMake(x, y, width, height))
        tempTimerLabel.text = time
        tempTimerLabel.textAlignment = .Center
        tempTimerLabel.textColor = UIColor.whiteColor()
        print(UIFont.systemFontSize())
        tempTimerLabel.font = UIFont(name: FONT_NAME_BOLD, size: 17)
        return tempTimerLabel
    }
    
    func configureVoteTotalLabel() -> UILabel{
        let x = frame.width * 0.50
        let y = promptLabel.frame.maxY
        let width = (frame.width * (CGFloat(1.0) - (PROMPT_PADDING_RIGHT + PROMPT_PADDING_LEFT))) * 0.50
        let height = (frame.height) * ( CGFloat(1) - (CGFloat(1) - (PROMPT_PADDING_DOWN + PROMPT_PADDING_UP) + PROMPT_PADDING_UP))
        let tempVTL = UILabel(frame: CGRectMake(x, y, width, height))
        tempVTL.text = "0"
        tempVTL.textAlignment = .Center
        tempVTL.textColor = UIColor.whiteColor()
        tempVTL.font = UIFont(name: FONT_NAME_BOLD, size: 17)
        return tempVTL
        
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
                self.timerLabel.textColor = RED
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
