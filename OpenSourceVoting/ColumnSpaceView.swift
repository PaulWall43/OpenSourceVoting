//
//  ColumnSpaceView.swift
//  OpenSourceVoting
//
//  Created by Paul Wallace on 3/27/16.
//  Copyright © 2016 PaulWallace. All rights reserved.
//

import UIKit

class ColumnSpaceView: UIView, VotingColumn {

    
    var selfIndex : Int!
    var votingBar : UILabel!
    var selectButton : UIButton!
    var selectButtonLabel : UILabel!
    var counterLabel : UILabel!
    var barHeight : CGFloat = 0
    var numOfVotes = 0
    
    var delegate: VotingColumnDelegate?
    
    
    
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
        self.selectButtonLabel = selectButton.titleLabel
        
        //give button a delegate method
        selectButton.addTarget(self, action: #selector(ColumnSpaceView.selectButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //Place views on self 
        
        self.addSubview(votingBar)
        self.addSubview(selectButton)
        self.addSubview(counterLabel)
        self.bringSubviewToFront(selectButton)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func getVotingBarFrame() -> CGRect{
        return votingBar.frame
    }
    
    func getSelectButtonFrame() -> CGRect{
        return selectButton.frame
    }
    
    func getBarHeight() -> CGFloat{
        return self.barHeight
    }
    
    
    func setNewBarHeight(barHeight : CGFloat){
        self.barHeight = barHeight
    }
    
    func setVotingBarFrame(frame: CGRect){
        votingBar.frame = frame
    }
    
    func setCounterLabel(){
        counterLabel.text = String(numOfVotes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectButtonPressed(sender: AnyObject){
        delegate?.ansSelected(self.selfIndex)
    }
    
    func getNumOfVotes() -> Int {
        return numOfVotes
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

protocol VotingColumn {
    var numOfVotes : Int { get }
    func selectButtonPressed(sender: AnyObject)
}

protocol VotingColumnDelegate {
    func ansSelected(index: Int) //not necessarily voted yet
    func voteSubmitted()
    func updateBarHeightsAndCount()
}
