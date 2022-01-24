//
//  GraphVC.swift
//  UpaxTest
//
//  Created by Daniel iOS on 22/01/22.
//

import UIKit
import Charts

class GraphVC: UIViewController {
    
    var viewModel = RequestViewModel()
    var databaseViewModel = DatabaseViewModel()
    var chartViews: [PieChartView] = []
    var spinner: UIView?
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        
        //Obteninedo datos de Api
        showSpinner(onView: self.view)
        //Obteniendo datos de API
        viewModel.getData()
        //Enlazando ViewModel
        bind()
    }
    
    func bind() {
        //Cambio de color desde Firebase
        databaseViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                //Cambiando Fondo
                self?.view.backgroundColor = self!.databaseViewModel.dataColor
            }
        }
        //Resultado de datos de API
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.removeSpinner()
                //Configurando vista de gráficas
                self!.setupViews(numOfGraphs: self!.viewModel.dataArray)
                //Configurando Data
                self!.setData(dataToGraph: self!.viewModel.dataArray)
            }
        }
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupViews(numOfGraphs: DataModel){
        
        for (item,_) in numOfGraphs.questions.enumerated() {
            let chartView = PieChartView()
            chartView.legend.font = UIFont.systemFont(ofSize: 20)
            chartView.backgroundColor = .systemGray5
            chartView.layer.cornerRadius = 20
            chartView.clipsToBounds = true
            chartView.translatesAutoresizingMaskIntoConstraints = false
            
            if item == numOfGraphs.questions.startIndex {//For FirstView
                contentView.addSubview(chartView)
                chartView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                chartView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
                chartView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
                chartView.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            } else if item == numOfGraphs.questions.endIndex - 1 {//For last View
                contentView.addSubview(chartView)
                chartView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                chartView.topAnchor.constraint(equalTo: chartViews[item - 1].bottomAnchor, constant: 25).isActive = true
                chartView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
                chartView.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
                chartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            } else {
                contentView.addSubview(chartView)
                chartView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                chartView.topAnchor.constraint(equalTo: chartViews[item - 1].bottomAnchor, constant: 25).isActive = true
                chartView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
                chartView.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            }
            
            chartViews.append(chartView)
            
        }
        
    }
    
    
    func setData(dataToGraph: DataModel){
        
        //Array para colores en graph
        var colors:[UIColor] = []
        for color in dataToGraph.colors {
            colors.append(hexStringToUIColor(hex: color))
        }
        
        for (item,graph) in dataToGraph.questions.enumerated() {
            var arrayChartDataEntry: [PieChartDataEntry] = []
            for data in graph.chartData{
                let chartDataEntry = PieChartDataEntry(value: Double(data.percetnage), label: data.text)
                arrayChartDataEntry.append(chartDataEntry)
            }
            
            let set1 = PieChartDataSet(entries: arrayChartDataEntry, label: graph.text)
            set1.colors = colors
            let data = PieChartData(dataSet: set1)
            chartViews[item].data = data
        }
        
    }
    
    //MARK: - String to UIColor
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    //MARK: - Spinner
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        spinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
            self.spinner = nil
        }
    }
    
}

