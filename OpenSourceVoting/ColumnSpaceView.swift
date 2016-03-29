//
//  ColumnSpaceView.swift
//  OpenSourceVoting
//
//  Created by Paul Wallace on 3/27/16.
//  Copyright © 2016 PaulWallace. All rights reserved.
//

import UIKit

class ColumnSpaceView: UIView {

    
    var selfIndex : Int!
    var votingBar : UILabel!
    var selectButton : UIButton!
    var selectButtonLabel : UILabel!
    var counterLabel : UILabel!
    var barHeight = 0
    var numOfVotes = 0
    
    
    
    init(selfIndex: Int,
         frame : CGRect,
         votingBar : UILabel,
         selectButton : UIButton,
         counterLabel : UILabel){
        super.init(frame: frame)
        
        self.selfIndex = selfIndex
        self.votingBar = votingBar
        self.selectButton = selectButton
        self.counterLabel = counterLabel
        
        
        //give button a delegate method
        selectButton.addTarget(self, action: #selector(ColumnSpaceView.selectButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //Place views on self 
        
        self.addSubview(votingBar)
        self.addSubview(selectButton)
        self.addSubview(counterLabel)
        self.bringSubviewToFront(selectButton)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectButtonPressed(sender: AnyObject){
        print(numOfVotes)
        numOfVotes += 1
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
