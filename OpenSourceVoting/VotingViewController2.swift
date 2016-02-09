//
//  VotingViewController2.swift
//  OpenSourceVoting
//
//  Created by Paul Wallace on 2/8/16.
//  Copyright © 2016 PaulWallace. All rights reserved.
//

import UIKit

class VotingViewController2: UIViewController {
    var barsArray : [UILabel] = []
    var counterLabelsArray:[UILabel] = []
    var selectButtonsArray:[UIButton] = []
    var selectButtonStrings : [String] = ["A", "B", "C", "D"]
//    var selectButtonSelectors = ["firstChoiceButtonWasPressed:", "secondChoiceButtonWasPressed:", "thirdChoiceButtonWasPressed:", "fourthChoiceButtonWasPressed:"]
    var barColorsArray : [UIColor] = [UIColor(hue: 0.025, saturation: 0.72, brightness: 0.84, alpha: 1.0),
        UIColor(hue: 0.56, saturation: 0.76, brightness: 0.86, alpha: 1),
        UIColor(hue: 0.786, saturation: 0.51, brightness: 0.71, alpha: 1),
        UIColor(hue: 0.133, saturation: 0.94, brightness: 0.95, alpha: 1)]
    

    //Maybe make a color randomizer
    
    var studentCounterLabel: UILabel!
    var submitVoteButton: UIButton!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var currentNumberOfVotes : CGFloat = 0
    var percentIncrease : CGFloat!
    var canUpdate : Bool =  false
    var lastButtonPressed : String = ""
    var resetVotingButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //**instantiations**//
        let choiceButtonHeight = screenSize.height * 0.125
        let submitButtonHeight = choiceButtonHeight
        var choiceButtonWidth = screenSize.width * 0.25 //0.25 will be replaced by a runtime decided value in the future
        var barHeight = 0;
        var barWidth = choiceButtonWidth
        var choiceButtonsPlace = screenSize.height * 0.75
        var submitButtonPlace = screenSize.height * 0.875

        view.backgroundColor = UIColor.whiteColor()
    
        //Add navigation items
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "backButtonPressed:")
        let resetButton = UIBarButtonItem(title: "Reset", style: .Plain, target: self, action: "resetClassDatabaseVotes:")
        
        self.navigationItem.setLeftBarButtonItem(backButton, animated: true)
        self.navigationItem.setRightBarButtonItem(resetButton, animated: true)
        self.navigationItem.title = "Voting"
        
        //Fill component arrays
        for i in 0...3{
            barsArray.append(UILabel(frame: CGRect(x: choiceButtonWidth * CGFloat(i), y: choiceButtonsPlace, width: choiceButtonWidth, height: 0)))
            print(barsArray[i])
            barsArray[i].backgroundColor = barColorsArray[i]
            barsArray[i].minimumScaleFactor = 0.5
            

            
            view.addSubview(barsArray[i])
        }
        for i in 0...3{
            counterLabelsArray.append(UILabel(frame: CGRect(x: CGFloat(i) * choiceButtonWidth, y: choiceButtonsPlace - 20, width: choiceButtonWidth, height: 20)))
            counterLabelsArray[i].textAlignment = NSTextAlignment.Center
            counterLabelsArray[i].font = UIFont(name: "ArialRoundedMTBold", size: 22)
            counterLabelsArray[i].textColor = UIColor(white: 0.0, alpha: 1.0)
            counterLabelsArray[i].text = "0"
            view.addSubview(counterLabelsArray[i])
            view.bringSubviewToFront(counterLabelsArray[i])
        }
        

        for i in 0...3{
            selectButtonsArray.append(UIButton(frame:CGRectMake(choiceButtonWidth * CGFloat(i), choiceButtonsPlace, choiceButtonWidth, choiceButtonHeight)))
            selectButtonsArray[i].setTitle(selectButtonStrings[i], forState: UIControlState.Normal)
            selectButtonsArray[i].titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 22)
            //firstChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 1.0, brightness: 0.5, alpha: 1.0)
            selectButtonsArray[i].backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.68, alpha: 1.0)
            view.addSubview(selectButtonsArray[i])
            view.bringSubviewToFront(selectButtonsArray[i])
        }
        selectButtonsArray[0].addTarget(self, action: "firstChoiceButtonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        selectButtonsArray[1].addTarget(self, action: "secondChoiceButtonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        selectButtonsArray[2].addTarget(self, action: "thirdChoiceButtonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        selectButtonsArray[3].addTarget(self, action: "fourthChoiceButtonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        submitVoteButton = UIButton(frame: CGRect(x: 0, y: submitButtonPlace, width: screenSize.width, height: choiceButtonHeight))
        submitVoteButton.backgroundColor = UIColor(white: 0.20, alpha: 1)
        submitVoteButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        submitVoteButton.setTitle("Submit Vote", forState: UIControlState.Normal)
        submitVoteButton.addTarget(self, action: "clickedSubmitVoteButton:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(submitVoteButton)
        
        view.bringSubviewToFront(submitVoteButton)
        currentNumberOfVotes = 0

    }
    
    func firstChoiceButtonWasPressed(sender: AnyObject) {
        resetLastButtonColor()
        lastButtonPressed = "1"
        selectButtonsArray[0].backgroundColor = UIColor(white: 0.67, alpha: 1.0)
    }
    
    func secondChoiceButtonWasPressed(sender: AnyObject) {
        resetLastButtonColor()
        lastButtonPressed = "2"
        selectButtonsArray[1].backgroundColor = UIColor(white: 0.67, alpha: 1.0)
    }
    
    func thirdChoiceButtonWasPressed(sender: AnyObject) {
        resetLastButtonColor()
        lastButtonPressed = "3"
        selectButtonsArray[2].backgroundColor = UIColor(white: 0.67, alpha: 1.0)
    }
    
    func fourthChoiceButtonWasPressed(sender: AnyObject) {
        resetLastButtonColor()
        lastButtonPressed = "4"
        selectButtonsArray[3].backgroundColor = UIColor(white: 0.67, alpha: 1.0)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resetLastButtonColor()
        lastButtonPressed = ""
    }
    
    func clickedSubmitVoteButton(sender: AnyObject) {
        currentNumberOfVotes = currentNumberOfVotes + 1
        if(lastButtonPressed == "" ){
            return
        }
        else if(lastButtonPressed == "1"){
            let toIncrement = (Int((counterLabelsArray[0].text)!))! + 1
            counterLabelsArray[0].text = String(toIncrement)
            //For now here but may refactor out later, the database update
//            updateNumberOfVotesForLetter("A")
//            updateNumberOfTotalVotes()
        }
        else if(lastButtonPressed == "2"){
            let toIncrement = (Int((counterLabelsArray[1].text)!))! + 1
            counterLabelsArray[1].text = String(toIncrement)
//            updateNumberOfVotesForLetter("B")
//            updateNumberOfTotalVotes()
        }
        else if(lastButtonPressed == "3"){
            let toIncrement = (Int(counterLabelsArray[2].text!))! + 1
            counterLabelsArray[2].text = String(toIncrement)
//            updateNumberOfVotesForLetter("C")
//            updateNumberOfTotalVotes()
        }
        else{
            let toIncrement = (Int(counterLabelsArray[3].text!))! + 1
            counterLabelsArray[3].text = String(toIncrement)
//            updateNumberOfVotesForLetter("D")
//            updateNumberOfTotalVotes()
            
        }
        resizeAllBarLabels()
        //submitVoteButton.enabled = false
    }

    func resizeAllBarLabels(){
        print("Resize all bar labels done")
        let newFirstBarHeight = calculateNewBarHeight(counterLabelsArray[0].text!)
        let choiceButtonWidth = screenSize.width * 0.25
        let newSecondBarHeight = calculateNewBarHeight(counterLabelsArray[1].text!)
        let newThirdBarHeight = calculateNewBarHeight(counterLabelsArray[2].text!)
        let newFourthBarHeight = calculateNewBarHeight(counterLabelsArray[3].text!)
        
        if(!newFirstBarHeight.isNaN ){
            UIView.animateWithDuration(0.2 , animations: {
                self.barsArray[0].frame = (CGRectMake(0, self.selectButtonsArray[0].frame.minY - newFirstBarHeight /*+ (self.firstChoiceButton.frame.height * 0.50)*/, self.barsArray[0].frame.width, newFirstBarHeight + (self.selectButtonsArray[0].frame.height + self.submitVoteButton.frame.height)))
            })
            
        }
        
        if(!newSecondBarHeight.isNaN){
            
            UIView.animateWithDuration(0.2 , animations: {
                self.barsArray[1].frame = CGRectMake(choiceButtonWidth, self.selectButtonsArray[1].frame.minY - newSecondBarHeight , self.barsArray[1].frame.width, newSecondBarHeight + (self.selectButtonsArray[1].frame.height + self.submitVoteButton.frame.height))
            })
        }
        
        if(!newThirdBarHeight.isNaN){
            
            UIView.animateWithDuration(0.2 , animations: {
                self.barsArray[2].frame = CGRectMake(choiceButtonWidth * 2, self.selectButtonsArray[2].frame.minY - newThirdBarHeight , self.barsArray[2].frame.width, newThirdBarHeight + (self.selectButtonsArray[2].frame.height + self.submitVoteButton.frame.height))
            })
        }
        
        if(!newFourthBarHeight.isNaN){
            
            UIView.animateWithDuration(0.2 , animations: {
                self.barsArray[3].frame = CGRectMake(choiceButtonWidth * 3, self.selectButtonsArray[3].frame.minY - newFourthBarHeight, self.barsArray[3].frame.width, newFourthBarHeight  + (self.selectButtonsArray[3].frame.height + self.submitVoteButton.frame.height))
            })
        }
    }
    
    func calculateNewBarHeight(numberOfVotes: String) -> CGFloat{
        var newBarHeight : CGFloat = 0
        if let n = NSNumberFormatter().numberFromString(numberOfVotes) {
            let numberOfVotes = CGFloat(n)
            //println(numberOfVotes)
            if(currentNumberOfVotes != 0){
                newBarHeight = (numberOfVotes/currentNumberOfVotes) * (screenSize.height * 0.50)
            }
        }
        if(newBarHeight > (screenSize.height * 0.50)){
            newBarHeight = screenSize.height * 0.50
        }
        return newBarHeight
    }
    
    func resetLastButtonColor(){
        if(lastButtonPressed == "" ){
            return
        }
        else if(lastButtonPressed == "1"){
            //firstChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 1.0, brightness: 0.5, alpha: 1.0)
            selectButtonsArray[0].backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.68, alpha: 1.0)
        }
        else if(lastButtonPressed == "2"){
            //secondChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 1.0, brightness: 0.49, alpha: 1.0)
            selectButtonsArray[1].backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.66, alpha: 1.0)
        }
        else if(lastButtonPressed == "3"){
            //thirdChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 0.98, brightness: 0.48, alpha: 1.0)
            selectButtonsArray[2].backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.64, alpha: 1.0)
        }
        else{
            //fourthChoiceButton.backgroundColor = UIColor(hue: 0.45, saturation: 0.98, brightness: 0.46, alpha: 1.0)
            selectButtonsArray[3].backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.62, alpha: 1.0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
