//
//  MenuView.swift
//  OpenSourceVoting
//
//  Created by Paul Wallace on 4/2/16.
//  Copyright © 2016 PaulWallace. All rights reserved.
//

import UIKit

let NUMBER_OF_OPTIONS = 8

let ACTION_OPTIONS = ["Pause time", "Pause voting", "Pause both", "Reset all", "Edit time", "New question", "Close poll", "Edit prompt"]

let ACTIONS_FUNCTIONS = ["pauseTime", "pauseVoting", "pauseBoth", "resetAll", "editTime", "newQuestion", "closePoll", "editPrompt"]

class MenuView: UIView, MenuViewChild {

    var optionsArr : [UIButton] = []
    var delegate: MenuViewChildDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.frame = frame
        self.layer.cornerRadius = 10
        //Add the eight options
        constructOptionButtons(frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constructOptionButtons(frame: CGRect){
        for i in 0 ... NUMBER_OF_OPTIONS - 1{
            let x : CGFloat = 0
            let y = CGFloat(i) * (frame.height / CGFloat(NUMBER_OF_OPTIONS))
            let width = frame.width
            let height = frame.height / CGFloat(NUMBER_OF_OPTIONS)
            if (optionsArr.count - 1 >= i){
                optionsArr[i].frame = CGRectMake(x, y, width, height)
            } else {
                optionsArr.append(UIButton(frame: CGRectMake(x, y, width, height)))
                optionsArr[i].setTitle(ACTION_OPTIONS[i], forState: .Normal)
                optionsArr[i].backgroundColor = BLUE
                optionsArr[i].layer.borderWidth = 1.0
                optionsArr[i].layer.borderColor = UIColor.blackColor().CGColor
                #selector(VotingViewController3.voteSubmitted)
                addSubview(optionsArr[i])
            }
        }
        
        optionsArr[0].addTarget(self, action: #selector(MenuView.pauseTime), forControlEvents: .TouchUpInside)
        optionsArr[1].addTarget(self, action: #selector(MenuView.pauseVoting), forControlEvents: .TouchUpInside)
        optionsArr[2].addTarget(self, action: #selector(MenuView.pauseBoth), forControlEvents: .TouchUpInside)
        optionsArr[3].addTarget(self, action: #selector(MenuView.resetAll), forControlEvents: .TouchUpInside)
        optionsArr[4].addTarget(self, action: #selector(MenuView.editTime), forControlEvents: .TouchUpInside)
        optionsArr[5].addTarget(self, action: #selector(MenuView.newQuestion), forControlEvents: .TouchUpInside)
        optionsArr[6].addTarget(self, action: #selector(MenuView.closePoll), forControlEvents: .TouchUpInside)
        optionsArr[7].addTarget(self, action: #selector(MenuView.editPrompt), forControlEvents: .TouchUpInside)
        
    }
    
    
    func pauseTime(){delegate?.pauseTime()}
    
    func pauseVoting(){delegate?.pauseVoting()}
    
    func pauseBoth(){delegate?.pauseBoth()}
    
    func resetAll(){delegate?.resetAll()}
    
    func editTime(){delegate?.editTime()}
    
    func newQuestion(){delegate?.newQuestion()}
    
    func closePoll(){delegate?.closePoll()}
    
    func editPrompt(){delegate?.editPrompt()}
    
    func resetFrame(frame: CGRect){
        self.frame = frame
        constructOptionButtons(frame)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

protocol MenuViewChild{
    
}

protocol MenuViewChildDelegate {
    func pauseTime()
    
    func pauseVoting()
    
    func pauseBoth()
    
    func resetAll()
    
    func editTime()
    
    func newQuestion()
    
    func closePoll()
    
    func editPrompt()
}
