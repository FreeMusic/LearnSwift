//
//  CurveDrawVC.swift
//  Swift学习记录
//
//  Created by 橘子 on 2019/2/26.
//  Copyright © 2019年 橘子. All rights reserved.
//

import UIKit

class CurveDrawVC: RYQTableViewVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.ArithmeticMessages = [
            ArithmeticMessage.init(title: "画直线", class: PaintLineViewVC.self),
            ArithmeticMessage.init(title: "画阴影图", class: PaintShadowView.self),
            ArithmeticMessage.init(title: "画三角形", class: PaintTriangleViewVC.self),
            ArithmeticMessage.init(title: "画圆形或椭圆", class: PaintCilcleViewVC.self),
            ArithmeticMessage.init(title: "画圆角矩形", class: PaintRoundedRectangleVC.self),
            ArithmeticMessage.init(title: "画弧线", class: PaintTrajectoryViewVC.self),
            ArithmeticMessage.init(title: "LineCap形状", class: PaintLineCapVC.self),
            ArithmeticMessage.init(title: "二次贝塞尔曲线", class: QuadRaticBezierVC.self),
            ArithmeticMessage.init(title: "三次贝塞尔曲线", class: TripleBezierVC.self),
            ArithmeticMessage.init(title: "绘制饼状图", class: PieChartVC.self),
            ArithmeticMessage.init(title: "Layer动画", class: LayerAnimationVC.self),
            ArithmeticMessage.init(title: "不规则渐变色图形", class: IrregularGradientVC.self),
            ArithmeticMessage.init(title: "CATextLayer", class: TextLayerVC.self),
            ArithmeticMessage.init(title: "贝塞尔曲线计算", class: CalculationVC.self),
            ArithmeticMessage.init(title: "绘制虚线", class: PaintDottedLineVC.self),
            ArithmeticMessage.init(title: "绘制柱状图动画", class: HistogramVC.self),
            ArithmeticMessage.init(title: "蜘蛛网状图", class: SpiderWebVC.self)
        ]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let infoMessage = self.ArithmeticMessages[indexPath.row]
        cell?.textLabel?.text = infoMessage.title
        
        return cell!
    }
}
