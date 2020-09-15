//
//  Conversions.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-31.
//

import SwiftUI

var imperialFormatterMeasurement: LengthFormatter {
    let formatter = LengthFormatter()
    formatter.isForPersonHeightUse = true
    formatter.unitStyle = .short
    
    let numFormat = NumberFormatter()
    numFormat.maximumFractionDigits = 0
    formatter.numberFormatter = numFormat
    return formatter
}


func getCentimeters(from value: Double) -> Measurement<UnitLength> {
    return Measurement(value: Double(value), unit: UnitLength.centimeters)
}

func getFeet(from value: Double) -> Measurement<UnitLength> {
    return Measurement(value: Double(value), unit: UnitLength.feet)
}

func getInches(from value: Double) -> Measurement<UnitLength> {
    return Measurement(value: Double(value), unit: UnitLength.inches)
}

func getKilograms(from value: Double) -> Measurement<UnitMass> {
    return Measurement(value: Double(value), unit: UnitMass.kilograms)
}


func getPounds(from value: Double) -> Measurement<UnitMass> {
    return Measurement(value: Double(value), unit: UnitMass.pounds)
}



func convertCentimeterToFeet(from mesure: Measurement<UnitLength>) -> Measurement<UnitLength> {
    return mesure.converted(to: .feet)
}

func convertFeetToCentimeter(from mesure: Measurement<UnitLength>) -> Measurement<UnitLength> {
    return mesure.converted(to: .centimeters)
}


func convertCentimeterToInches(from mesure: Measurement<UnitLength>) -> Measurement<UnitLength> {
    return mesure.converted(to: .inches)
}

func convertInchesToCentimeter(from mesure: Measurement<UnitLength>) -> Measurement<UnitLength> {
    return mesure.converted(to: .centimeters)
}

func convertKilogramsToPounds(from mesure: Measurement<UnitMass>) -> Measurement<UnitMass> {
    return mesure.converted(to: .pounds)
}

func convertPoundsToKilograms(from mesure: Measurement<UnitMass>) -> Measurement<UnitMass> {
    return mesure.converted(to: .kilograms)
}



func getFormattedCentimeters(from mesure: Measurement<UnitLength>) -> String {
    return String("\(String(format: "%.f", mesure.value)) \(mesure.unit.symbol)")
}

func getFormattedFeet(from mesure: Measurement<UnitLength>) -> String {
    return imperialFormatterMeasurement.string(fromMeters: mesure.converted(to: .meters).value)
}

func getFormattedKilograms(from mesure: Measurement<UnitMass>) -> String {
    return String("\(String(format: "%.f", mesure.value)) \(mesure.unit.symbol)")
}

func getFormattedPounds(from mesure: Measurement<UnitMass>) -> String {
    return String("\(String(format: "%.f", mesure.value)) \(mesure.unit.symbol)")
}
