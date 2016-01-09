//
//  VotingViewController.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 7/9/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import UIKit

class VotingViewController: UIViewController {

    var firebaseRef : Firebase = Firebase(url: "https://tetheref.firebaseio.com/ClassSessions")
    //var currentStateInfo : CurrentStateInformationObject = CurrentStateInformationObject.SharedInstance
    var studentCounterLabel: UILabel!
    var submitVoteButton: UIButton!
    var firstBar: UILabel!
    var secondBar: UILabel!
    var thirdBar: UILabel!
    var fourthBar: UILabel!
    var firstChoiceCounterLabel: UILabel!
    var secondChoiceCounterLabel: UILabel!
    var thirdChoiceCounterLabel: UILabel!
    var fourthChoiceCounterLabel: UILabel!
    var firstChoiceButton: UIButton!
    var secondChoiceButton: UIButton!
    var thirdChoiceButton: UIButton!
    var fourthChoiceButton: UIButton!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var currentNumberOfVotes : CGFloat = 0
    var percentIncrease : CGFloat!
    var canUpdate : Bool =  false
    var lastButtonPressed : String = ""
    var resetVotingButton : UIButton!
//    var currentStateInfo : CurrentStateInformationObject = CurrentStateInformationObject.SharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load was called")
        //calculate orginal percent incrase
        currentNumberOfVotes = 0
        //Add navigation items
        var backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButtonPressed:")
        var resetButton = UIBarButtonItem(title: "Reset", style: UIBarButtonItemStyle.Plain, target: self, action: "resetClassDatabaseVotes:")
        //var backButton = UIBarButtonItem()
        self.navigationItem.setLeftBarButtonItem(backButton, animated: true)
        self.navigationItem.setRightBarButtonItem(resetButton, animated: true)
        self.navigationItem.title = "Voting"
        //I like a dark grey background
        //view.backgroundColor = UIColor(white: 0.20, alpha: 1)
        //designer suggested light background
        view.backgroundColor = UIColor.whiteColor()
        //get information of the screen
        let choiceButtonHeight = screenSize.height * 0.125
        let submitButtonHeight = choiceButtonHeight
        var choiceButtonWidth = screenSize.width * 0.25 //0.25 will be replaced by a runtime decided value in the future
        var barHeight = 0;
        var barWidth = choiceButtonWidth
        var choiceButtonsPlace = screenSize.height * 0.75
        var submitButtonPlace = screenSize.height * 0.875
        //Add all voting buttons to an array in the future
        firstChoiceButton = UIButton(frame:CGRectMake(0, choiceButtonsPlace, choiceButtonWidth, choiceButtonHeight))
        firstChoiceButton.setTitle("A", forState: UIControlState.Normal) //maybe shouldn't be normal we'll see
        firstChoiceButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 22)
        //firstChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 1.0, brightness: 0.5, alpha: 1.0)
        firstChoiceButton.backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.68, alpha: 1.0)
        firstChoiceButton.addTarget(self, action: "firstChoiceButtonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        secondChoiceButton = UIButton(frame:CGRectMake(choiceButtonWidth, choiceButtonsPlace, choiceButtonWidth, choiceButtonHeight))
        secondChoiceButton.setTitle("B", forState: UIControlState.Normal) //maybe shouldn't be normal we'll see
        secondChoiceButton.addTarget(self, action: "secondChoiceButtonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        //secondChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 1.0, brightness: 0.49, alpha: 1.0)
        secondChoiceButton.backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.66, alpha: 1.0)
        secondChoiceButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 22)
        thirdChoiceButton = UIButton(frame:CGRectMake(choiceButtonWidth * 2, choiceButtonsPlace, choiceButtonWidth, choiceButtonHeight))
        thirdChoiceButton.setTitle("C", forState: UIControlState.Normal) //maybe shouldn't be normal we'll see
        thirdChoiceButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 22)
        thirdChoiceButton.addTarget(self, action: "thirdChoiceButtonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        //thirdChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 0.98, brightness: 0.48, alpha: 1.0)
        thirdChoiceButton.backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.64, alpha: 1.0)
        fourthChoiceButton = UIButton(frame:CGRectMake(choiceButtonWidth * 3, choiceButtonsPlace, choiceButtonWidth, choiceButtonHeight))
        fourthChoiceButton.setTitle("D", forState: UIControlState.Normal) //maybe shouldn't be normal we'll see
        fourthChoiceButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 22)
        fourthChoiceButton.addTarget(self, action: "fourthChoiceButtonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        //fourthChoiceButton.backgroundColor = UIColor(hue: 0.45, saturation: 0.98, brightness: 0.46, alpha: 1.0)
        fourthChoiceButton.backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.62, alpha: 1.0)

        
        //Add submit button
        submitVoteButton = UIButton(frame: CGRect(x: 0, y: submitButtonPlace, width: screenSize.width, height: choiceButtonHeight))
        submitVoteButton.backgroundColor = UIColor(white: 0.20, alpha: 1)
//        if let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? RootViewController {
        
        //Need to implement a submit button here
//        println(currentStateInfo.isTeacher)
//            if(currentStateInfo.isTeacher){
//                submitVoteButton.setTitle("Reset Votes", forState: UIControlState.Normal)
//                submitVoteButton.addTarget(self, action: "resetClassDatabaseVotes:", forControlEvents: UIControlEvents.TouchUpInside)
//            } else {
//                //println("Hey")
//                submitVoteButton.setTitle("Submit Vote", forState: UIControlState.Normal)
//                submitVoteButton.addTarget(self, action: "clickedSubmitVoteButton:", forControlEvents: UIControlEvents.TouchUpInside)
//            }
        submitVoteButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 17)
//        println(UIApplication.sharedApplication().keyWindow?.rootViewController)
//        submitVoteButton = UIButton(frame: CGRect(x: 0, y: submitButtonPlace, width: screenSize.width, height: choiceButtonHeight))
//
//        submitVoteButton.backgroundColor = UIColor(white: 0.20, alpha: 1)
        view.addSubview(submitVoteButton)
        
        //Add all the buttons
        view.addSubview(firstChoiceButton)
        view.addSubview(secondChoiceButton)
        view.addSubview(thirdChoiceButton)
        view.addSubview(fourthChoiceButton)
        
        //Create four back up voting bars used for aesthetics
        firstChoiceCounterLabel = UILabel(frame: CGRect(x: 0, y: choiceButtonsPlace - 20, width: choiceButtonWidth, height: 20))
        firstChoiceCounterLabel.textAlignment = NSTextAlignment.Center
        firstChoiceCounterLabel.font = UIFont(name: "ArialRoundedMTBold", size: 22)
        firstChoiceCounterLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
        secondChoiceCounterLabel = UILabel(frame: CGRect(x: choiceButtonWidth, y: choiceButtonsPlace - 20, width: choiceButtonWidth, height: 20))
        secondChoiceCounterLabel.textAlignment = NSTextAlignment.Center
        secondChoiceCounterLabel.font = UIFont(name: "ArialRoundedMTBold", size: 22)
        secondChoiceCounterLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
        thirdChoiceCounterLabel = UILabel(frame: CGRect(x: choiceButtonWidth * 2, y: choiceButtonsPlace - 20, width: choiceButtonWidth, height: 20))
        thirdChoiceCounterLabel.textAlignment = NSTextAlignment.Center
        thirdChoiceCounterLabel.font = UIFont(name: "ArialRoundedMTBold", size: 22)
        thirdChoiceCounterLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
        fourthChoiceCounterLabel = UILabel(frame: CGRect(x: choiceButtonWidth * 3, y: choiceButtonsPlace - 20, width: choiceButtonWidth, height: 20)) //Later adjust these heights to scaled font size
        fourthChoiceCounterLabel.textAlignment = NSTextAlignment.Center
        fourthChoiceCounterLabel.font = UIFont(name: "ArialRoundedMTBold", size: 22)
        fourthChoiceCounterLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
        firstChoiceCounterLabel.text = "0"
        secondChoiceCounterLabel.text = "0"
        thirdChoiceCounterLabel.text = "0"
        fourthChoiceCounterLabel.text = "0"
        view.addSubview(firstChoiceCounterLabel)
        view.addSubview(secondChoiceCounterLabel)
        view.addSubview(thirdChoiceCounterLabel)
        view.addSubview(fourthChoiceCounterLabel)
        //Create the bars that will grow, this could be made dependent on the buttons for more stability
        firstBar = UILabel(frame: CGRect(x: 0, y: choiceButtonsPlace, width: choiceButtonWidth, height: 0/*firstBar.font.pointSize*/))
        //firstBar.backgroundColor = UIColor(hue: 0.35, saturation: 0.57, brightness: 0.68, alpha: 1)
        //firstBar.backgroundColor = UIColor(hue: 0.46, saturation: 0.59, brightness: 0.68, alpha: 1.0)
        firstBar.backgroundColor = UIColor(hue: 0.025, saturation: 0.72, brightness: 0.84, alpha: 1.0)
        
//        firstBar.textAlignment = NSTextAlignment.Center
        firstBar.minimumScaleFactor = 0.5 // Scales the text down
        secondBar = UILabel(frame: CGRect(x: choiceButtonWidth, y: choiceButtonsPlace, width: choiceButtonWidth, height: 0))
        secondBar.backgroundColor = UIColor(hue: 0.56, saturation: 0.76, brightness: 0.86, alpha: 1)
//        secondBar.textAlignment = NSTextAlignment.Center
        thirdBar = UILabel(frame: CGRect(x: choiceButtonWidth * 2, y: choiceButtonsPlace, width: choiceButtonWidth, height: 0))
        //thirdBar.backgroundColor = UIColor(hue: 0.55, saturation: 0.57, brightness: 0.68, alpha: 1)
        thirdBar.backgroundColor = UIColor(hue: 0.786, saturation: 0.51, brightness: 0.71, alpha: 1)
//        thirdBar.textAlignment = NSTextAlignment.Center
        fourthBar = UILabel(frame: CGRect(x: choiceButtonWidth * 3, y: choiceButtonsPlace, width: choiceButtonWidth, height: 0))
        //fourthBar.backgroundColor = UIColor(hue: 0.65, saturation: 0.57, brightness: 0.68, alpha: 1)
        fourthBar.backgroundColor = UIColor(hue: 0.133, saturation: 0.94, brightness: 0.95, alpha: 1)
//        fourthBar.textAlignment = NSTextAlignment.Center
//        firstBar.text = "0"
//        secondBar.text = "0"
//        thirdBar.text = "0"
//        fourthBar.text = "0"
        view.addSubview(firstBar)
        view.addSubview(secondBar)
        view.addSubview(thirdBar)
        view.addSubview(fourthBar)
        //for animations
        self.view.bringSubviewToFront(firstChoiceButton)
        self.view.bringSubviewToFront(secondChoiceButton)
        self.view.bringSubviewToFront(thirdChoiceButton)
        self.view.bringSubviewToFront(fourthChoiceButton)
        self.view.bringSubviewToFront(submitVoteButton)
        self.view.bringSubviewToFront(firstChoiceCounterLabel)
        self.view.bringSubviewToFront(secondChoiceCounterLabel)
        self.view.bringSubviewToFront(thirdChoiceCounterLabel)
        self.view.bringSubviewToFront(fourthChoiceCounterLabel)
        //set up live updates
        // Read data and react to changes
        var updateRemoteRef = firebaseRef.childByAppendingPath("\(currentStateInfo.currentClassTitle)/voting")
        updateRemoteRef.observeEventType(.Value, withBlock: { snapshot in
                var a  = snapshot.value["A"] as! Int
                self.firstChoiceCounterLabel.text = String(a)
                var b = snapshot.value["B"] as! Int
                self.secondChoiceCounterLabel.text = String(b)
                var c = snapshot.value["C"] as! Int
                self.thirdChoiceCounterLabel.text = String(c)
                var d = snapshot.value["D"] as! Int
                self.fourthChoiceCounterLabel.text = String(d)
                var e = snapshot.value["numberOfVotes"] as! CGFloat
                self.currentNumberOfVotes = e
                self.resizeAllBarLabels()
            })
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    class func newInstance() -> VotingViewController {
        return VotingViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickedSubmitVoteButton(sender: AnyObject) {
        currentNumberOfVotes = currentNumberOfVotes + 1
        if(lastButtonPressed == "" ){
            return
        }
        else if(lastButtonPressed == "1"){
            let toIncrement = (Int((firstChoiceCounterLabel.text)!))! + 1
            firstChoiceCounterLabel.text = String(toIncrement)
            //For now here but may refactor out later, the database update
            updateNumberOfVotesForLetter("A")
            updateNumberOfTotalVotes()
        }
        else if(lastButtonPressed == "2"){
            let toIncrement = (Int((secondChoiceCounterLabel.text)!))! + 1
            secondChoiceCounterLabel.text = String(toIncrement)
            updateNumberOfVotesForLetter("B")
            updateNumberOfTotalVotes()
        }
        else if(lastButtonPressed == "3"){
            let toIncrement = (Int(thirdChoiceCounterLabel.text!))! + 1
            thirdChoiceCounterLabel.text = String(toIncrement)
            updateNumberOfVotesForLetter("C")
            updateNumberOfTotalVotes()
        }
        else{
            let toIncrement = (Int(fourthChoiceCounterLabel.text!))! + 1
            fourthChoiceCounterLabel.text = String(toIncrement)
            updateNumberOfVotesForLetter("D")
            updateNumberOfTotalVotes()

        }
        resizeAllBarLabels()
        //submitVoteButton.enabled = false
    }
    
    func resetLastButtonColor(){
        if(lastButtonPressed == "" ){
            return
        }
        else if(lastButtonPressed == "1"){
            //firstChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 1.0, brightness: 0.5, alpha: 1.0)
            firstChoiceButton.backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.68, alpha: 1.0)
        }
        else if(lastButtonPressed == "2"){
            //secondChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 1.0, brightness: 0.49, alpha: 1.0)
            secondChoiceButton.backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.66, alpha: 1.0)
        }
        else if(lastButtonPressed == "3"){
            //thirdChoiceButton.backgroundColor = UIColor(hue: 0.44, saturation: 0.98, brightness: 0.48, alpha: 1.0)
            thirdChoiceButton.backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.64, alpha: 1.0)
        }
        else{
            //fourthChoiceButton.backgroundColor = UIColor(hue: 0.45, saturation: 0.98, brightness: 0.46, alpha: 1.0)
            fourthChoiceButton.backgroundColor = UIColor(hue: 0.402, saturation: 0.78, brightness: 0.62, alpha: 1.0)
        }
    }
    
    @IBAction func firstChoiceButtonWasPressed(sender: AnyObject) {
        resetLastButtonColor()
        lastButtonPressed = "1"
        firstChoiceButton.backgroundColor = UIColor(white: 0.67, alpha: 1.0)
    }
    
    @IBAction func secondChoiceButtonWasPressed(sender: AnyObject) {
        resetLastButtonColor()
        lastButtonPressed = "2"
        secondChoiceButton.backgroundColor = UIColor(white: 0.67, alpha: 1.0)
    }
    
    @IBAction func thirdChoiceButtonWasPressed(sender: AnyObject) {
        resetLastButtonColor()
        lastButtonPressed = "3"
        thirdChoiceButton.backgroundColor = UIColor(white: 0.67, alpha: 1.0)
    }
    
    @IBAction func fourthChoiceButtonWasPressed(sender: AnyObject) {
        resetLastButtonColor()
        lastButtonPressed = "4"
        fourthChoiceButton.backgroundColor = UIColor(white: 0.67, alpha: 1.0)
    }
    
    /*override*/ func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        resetLastButtonColor()
        lastButtonPressed = ""
    }
    
    //Currently no need for this
    func backButtonPressed(sender :AnyObject){
        //self.dismissViewControllerAnimated(true, completion: nil)
//        var storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        var rootViewController : RootViewController = storyboard.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
//        rootViewController.goToClassroom()
//        UIApplication.sharedApplication().keyWindow?.rootViewController = rootViewController
        //classroomView is using a fake data, the 'nil' below should be changed to real data in the future
//        var classroomView : LessonMenuView = LessonMenuView(frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height),andData : rootViewController.lessonsRecord)
//        self.view.addSubview(classroomView)
//        var realPoint : CGPoint = CGPointMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height / 2 + 10)
//        classroomView.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
//            classroomView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//            }, completion: nil)

        //println("Hey")
    }
    
    func resizeAllBarLabels(){
        print("Resize all bar labels done")
        let newFirstBarHeight = calculateNewBarHeight(firstChoiceCounterLabel.text!)
        let choiceButtonWidth = screenSize.width * 0.25
        let newSecondBarHeight = calculateNewBarHeight(secondChoiceCounterLabel.text!)
        let newThirdBarHeight = calculateNewBarHeight(thirdChoiceCounterLabel.text!)
        let newFourthBarHeight = calculateNewBarHeight(fourthChoiceCounterLabel.text!)

            if(!newFirstBarHeight.isNaN ){
                UIView.animateWithDuration(0.2 , animations: {
                    self.firstBar.frame = (CGRectMake(0, self.firstChoiceButton.frame.minY - newFirstBarHeight /*+ (self.firstChoiceButton.frame.height * 0.50)*/, self.firstBar.frame.width, newFirstBarHeight + (self.firstChoiceButton.frame.height + self.submitVoteButton.frame.height)))
                })
                
            }

            if(!newSecondBarHeight.isNaN){
                
                UIView.animateWithDuration(0.2 , animations: {
                    self.secondBar.frame = CGRectMake(choiceButtonWidth, self.secondChoiceButton.frame.minY - newSecondBarHeight , self.secondBar.frame.width, newSecondBarHeight + (self.secondChoiceButton.frame.height + self.submitVoteButton.frame.height))
                })
            }
        
            if(!newThirdBarHeight.isNaN){
                
                UIView.animateWithDuration(0.2 , animations: {
                        self.thirdBar.frame = CGRectMake(choiceButtonWidth * 2, self.thirdChoiceButton.frame.minY - newThirdBarHeight , self.thirdBar.frame.width, newThirdBarHeight + (self.thirdChoiceButton.frame.height + self.submitVoteButton.frame.height))
                })
            }
        
            if(!newFourthBarHeight.isNaN){

                UIView.animateWithDuration(0.2 , animations: {
                    self.fourthBar.frame = CGRectMake(choiceButtonWidth * 3, self.fourthChoiceButton.frame.minY - newFourthBarHeight, self.fourthBar.frame.width, newFourthBarHeight  + (self.fourthChoiceButton.frame.height + self.submitVoteButton.frame.height))
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
    
    func resetClassDatabaseVotes(sender:AnyObject){
        var resetAlert : UIAlertController = UIAlertController(title: "Warning", message: "Are you sure you want to reset?", preferredStyle: UIAlertControllerStyle.Alert)
        var defaultAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            action in
            var votingRef = self.firebaseRef.childByAppendingPath("\(self.currentStateInfo.currentClassTitle)/voting")
            votingRef.updateChildValues(["A" : 0])
            votingRef.updateChildValues(["B" : 0])
            votingRef.updateChildValues(["C" : 0])
            votingRef.updateChildValues(["D" : 0])
            votingRef.updateChildValues(["numberOfVotes" : 0])
        })
        var oopsAction : UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            action in
            return
        })
        resetAlert.addAction(defaultAction)
        resetAlert.addAction(oopsAction)
        self.presentViewController(resetAlert, animated: true, completion: nil)
        //Learn how tos et all children to 0 at once

    }
    
    func updateNumberOfVotesForLetter(letterToIncrement:String){
        var votesRef = firebaseRef.childByAppendingPath("\(self.currentStateInfo.currentClassTitle)/voting/\(letterToIncrement)")
        votesRef.runTransactionBlock({
            (currentData:FMutableData!) in
            var value = currentData.value as? Int
            if !(value != nil) {
                value = 0
            }
            currentData.value = value! + 1
            return FTransactionResult.successWithValue(currentData)
        })
    }
    
    func updateNumberOfTotalVotes(){
        var numberOfVotesRef = firebaseRef.childByAppendingPath("\(self.currentStateInfo.currentClassTitle)/voting/numberOfVotes")
        numberOfVotesRef.runTransactionBlock({
            (currentData:FMutableData!) in
            var value = currentData.value as? Int
            if !(value != nil) {
                value = 0
            }
            currentData.value = value! + 1
            self.currentNumberOfVotes = currentData.value as! CGFloat
            return FTransactionResult.successWithValue(currentData)
        })
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
