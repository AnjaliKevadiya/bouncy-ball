//
//  ViewController.swift
//  BouncyBall
//
//  Created by Anjali Kevadiya on 2/15/19.
//  Copyright © 2019 Anjali Kevadiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollisionBehaviorDelegate,UIGestureRecognizerDelegate {
    
    var animator = UIDynamicAnimator()
    @IBOutlet weak var ball: UIView!
    @IBOutlet weak var bar: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var collision = UICollisionBehavior()
    var isFail: Bool = false
    var scoreValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpLayouts()
        initAnimation()
    }
    
    //MARK: UICollisionBehavior Delegate Methods
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        if( identifier as! String ==  "bottomEdge") {
            
            animator.removeAllBehaviors()
            
            let startAgainVC = storyboard?.instantiateViewController(withIdentifier: "StartAgainVC") as! StartAgainVC
            navigationController?.pushViewController(startAgainVC, animated: true)
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        if item1.isEqual(ball) && item2.isEqual(bar) {
            
            scoreValue += 1
            scoreLabel.text = "Score : \(scoreValue)"
        }
    }
    
    @objc func movingBar(_ panGesture: UIPanGestureRecognizer)  {
        
        let point = panGesture.location(in: self.view);
        
        if point.x < bar.frame.size.width/2 {
            return
        }
        
        if point.x > ((view.frame.origin.x + view.frame.size.width) - (bar.frame.size.width / 2)) {
            return
        }
        
        bar.center.x = point.x
        animator.updateItem(usingCurrentState: bar)
    }
    
    func initAnimation() {
        
        let dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        collision = UICollisionBehavior(items: [ball,bar])
        collision.collisionDelegate = self
        collision.collisionMode = .everything
        //        collision.translatesReferenceBoundsIntoBoundary = true
        
        let pusher: UIPushBehavior = UIPushBehavior(items: [ball], mode: .instantaneous)
        pusher.setAngle( CGFloat(Double.pi/3.0) , magnitude: 0.75);
        pusher.active = true
        dynamicAnimator.addBehavior(pusher)
        
        let ballProperties = UIDynamicItemBehavior(items: [ball])
        ballProperties.allowsRotation = false
        ballProperties.elasticity = 1
        ballProperties.friction = 0.0
        ballProperties.resistance = 0.0
        dynamicAnimator.addBehavior(ballProperties)
        
        let barProperties = UIDynamicItemBehavior(items: [bar])
        barProperties.allowsRotation = false
        barProperties.density = 1000.0
        dynamicAnimator.addBehavior(barProperties)
        
        settingBoundary()
        
        dynamicAnimator.addBehavior(collision)
        animator = dynamicAnimator
    }
    
    func setUpLayouts() {
        
        ball.layer.cornerRadius = ball.frame.size.height / 2
        bar.layer.cornerRadius = 5
        
        let screenWidth: Int = Int(view.frame.width)
        let randomXvalue = Int.random(in: 0..<screenWidth)
        ball.frame = CGRect(x: randomXvalue, y: 0, width: 30, height: 30)
        
        isFail = false
        scoreValue = 0
        scoreLabel.text = "Score : \(scoreValue)"
        
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(movingBar(_:)))
        bar.addGestureRecognizer(panGesture)
    }
    
    func settingBoundary() {
        
        let topEdge = CGPoint(x: view.frame.origin.x + view.frame.size.width, y: view.frame.origin.y)
        collision.addBoundary(withIdentifier: "topEdge" as NSCopying, from: view.frame.origin, to: topEdge)
        
        let rightEdge = CGPoint(x: view.frame.width, y: view.frame.height)
        collision.addBoundary(withIdentifier: "rightEdge" as NSCopying,
                              from: CGPoint(x: view.frame.width, y: 0),
                              to:  rightEdge)
        
        let leftEdge = CGPoint(x: view.frame.origin.x, y: view.frame.height)
        collision.addBoundary(withIdentifier: "leftEdge" as NSCopying,
                              from: CGPoint(x: view.frame.origin.x, y: 0),
                              to: leftEdge)
        
        let bottomEdge = CGPoint(x: view.frame.origin.x + view.frame.width, y: view.frame.origin.y + view.frame.height + 100)
        collision.addBoundary(withIdentifier: "bottomEdge" as NSCopying,
                              from: CGPoint(x: view.frame.origin.x, y: view.frame.origin.y + view.frame.height + 100),
                              to: bottomEdge)
    }
}


