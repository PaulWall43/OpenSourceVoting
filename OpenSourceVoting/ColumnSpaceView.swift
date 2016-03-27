//
//  ColumnSpaceView.swift
//  OpenSourceVoting
//
//  Created by Paul Wallace on 3/27/16.
//  Copyright © 2016 PaulWallace. All rights reserved.
//

import UIKit

class ColumnSpaceView: UIView {

    
    var votingBar : UILabel!
    var selectButton : UIButton!
    var selectButtonLabel : UILabel!
    var counterLabel : UILabel!
    var barHeight = 0
    
    
    init(frame : CGRect,
         votingBar : UILabel,
         selectButton : UIButton,
         counterLabel : UILabel){
        super.init(frame: frame)
        
        self.votingBar = votingBar
        self.selectButton = selectButton
        self.counterLabel = counterLabel
        
        //Place views on self 
        
        self.addSubview(votingBar)
        self.addSubview(selectButton)
        self.addSubview(counterLabel)
        self.bringSubviewToFront(selectButton)
        
        print("here")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
