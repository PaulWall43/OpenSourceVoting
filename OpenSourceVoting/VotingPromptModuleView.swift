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

let PROMPT_PADDING_LEFT : CGFloat = 0.05
let PROMPT_PADDING_RIGHT : CGFloat = 0.05
let PROMPT_PADDING_UP : CGFloat = 0.05
let PROMPT_PADDING_DOWN : CGFloat = 0.40

class VotingPromptModuleView: UIView {

    var promptString : String!
    var promptLabel : UILabel!
    
    init(promptString: String, frame: CGRect){
        super.init(frame: frame)
        
        self.promptString = promptString
        self.promptLabel = constructLabel(promptString, frame: frame) //returns a UILabel
        self.addSubview(self.promptLabel)
        self.backgroundColor = SUBMIT_VOTE_BUTTON_COLOR //REPLACE WITH CONSTANT
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constructLabel(promptString: String, frame: CGRect) -> UILabel{
        //construct the promptLabel
        let tempPromptLabel = UILabel(frame: CGRectMake(frame.width * PROMPT_PADDING_LEFT, frame.height * PROMPT_PADDING_UP, frame.width * (CGFloat(1.0) - (PROMPT_PADDING_RIGHT + PROMPT_PADDING_LEFT)), (frame.height) * (CGFloat(1.0) - (PROMPT_PADDING_DOWN + PROMPT_PADDING_UP))))
        tempPromptLabel.backgroundColor = PROMPT_LABEL_COLOR
        tempPromptLabel.text = promptString
        tempPromptLabel.textAlignment = .Center
        tempPromptLabel.numberOfLines = 0
        tempPromptLabel.minimumScaleFactor = 0.5
        tempPromptLabel.adjustsFontSizeToFitWidth = true
        return tempPromptLabel
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
