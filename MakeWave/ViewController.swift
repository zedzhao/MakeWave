//
//  ViewController.swift
//  MakeWave
//
//  Created by Kun on 16/9/25.
//  Copyright © 2016年 Kun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var waveLayer1: CAShapeLayer?
    var waveLayer2: CAShapeLayer?
    var centerLayer: CALayer?
    var offset: Float = 0 //一次波动的范围
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let y: CGFloat = 100
        let height:CGFloat = 100
        let width = CGRectGetWidth(self.view.bounds)
        let frame = CGRect(x: 0, y:y , width: width, height: height)
        
        waveLayer1 = CAShapeLayer()
        waveLayer1?.frame = frame
        waveLayer1?.fillColor = UIColor.lightGrayColor().CGColor
        self.view.layer.addSublayer(waveLayer1!)
        
        waveLayer2 = CAShapeLayer()
        waveLayer2?.frame = frame
        waveLayer2?.fillColor = UIColor.lightGrayColor().CGColor
        waveLayer2?.opacity = 0.3
        self.view.layer.addSublayer(waveLayer2!)
        
        centerLayer = CALayer()
        centerLayer?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        centerLayer?.borderWidth = 2
        centerLayer?.borderColor = UIColor.blueColor().CGColor
        
        self.view.layer.addSublayer(centerLayer!)
        
        let timer = CADisplayLink(target: self, selector: #selector(wave))
		timer.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func wave() {
        
        let size = CGSize(width: self.view.bounds.width, height: 5)
        let width = CGRectGetWidth(self.view.bounds)
        let height = size.height
        
        offset += 0.5
 
        //起始位置,  +height 表示动画是用layer的中间部分开始。
        var y = height
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x:0, y: y))
        
        
        let path2 = UIBezierPath()
        path2.moveToPoint(CGPoint(x:0, y: y))

        
        for x in 0..<Int(width) {
             y =  height * CGFloat( sinf( Float(x) * 2 * Float(M_PI) / Float(width) + offset * 2 * Float( M_PI) / Float(width)) )
            path.addLineToPoint(CGPoint(x: CGFloat(x), y: y))
            path2.addLineToPoint(CGPoint(x: CGFloat(x), y: -y))	//这里取反刚好造成峰谷和峰底是重叠在一起的，
		
        }
        path.addLineToPoint(CGPoint(x: width, y: size.height))
        path.addLineToPoint(CGPoint(x: 0, y: size.height))
		path.closePath()
        
        waveLayer1?.path = path.CGPath
        
        path2.addLineToPoint(CGPoint(x:width, y: size.height))
        path2.addLineToPoint(CGPoint(x:0, y: size.height))
        path2.closePath()
        
        waveLayer2?.path = path2.CGPath
        
        
        let centerX = width / 2
        //计算中间的Y值，  只要把x换成需要求值的点就可以了。
        let centerY = height * CGFloat( sinf( Float(centerX) * 2 * Float(M_PI) / Float(width) + offset * 2 * Float(M_PI) / Float(width)))
//        var frame = centerLayer!.frame
        
        centerLayer!.position = CGPoint(x: centerX, y : centerY + 100 - centerLayer!.bounds.size.height / 2)
        
    }

}

