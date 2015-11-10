//
//  AKAUPeakLimiter.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

/** AudioKit version of Apple's PeakLimiter Audio Unit */
public class AKAUPeakLimiter: AKOperation {
    
    private let cd = AudioComponentDescription(
        componentType: kAudioUnitType_Effect,
        componentSubType: kAudioUnitSubType_PeakLimiter,
        componentManufacturer: kAudioUnitManufacturer_Apple,
        componentFlags: 0,
        componentFlagsMask: 0)
    
    private var internalEffect = AVAudioUnitEffect()
    private var internalAU = AudioUnit()
    
    /** Attack Time (Secs) ranges from 0.001 to 0.03 (Default: 0.012) */
    public var attackTime: Float = 0.012 {
        didSet {
            if attackTime < 0.001 {
                attackTime = 0.001
            }
            if attackTime > 0.03 {
                attackTime = 0.03
            }
            AudioUnitSetParameter(internalAU, kLimiterParam_AttackTime, kAudioUnitScope_Global, 0, attackTime, 0)
        }
    }
    
    /** Decay Time (Secs) ranges from 0.001 to 0.06 (Default: 0.024) */
    public var decayTime: Float = 0.024 {
        didSet {
            if decayTime < 0.001 {
                decayTime = 0.001
            }
            if decayTime > 0.06 {
                decayTime = 0.06
            }
            AudioUnitSetParameter(internalAU, kLimiterParam_DecayTime, kAudioUnitScope_Global, 0, decayTime, 0)
        }
    }
    
    /** Pre Gain (dB) ranges from -40 to 40 (Default: 0) */
    public var preGain: Float = 0 {
        didSet {
            if preGain < -40 {
                preGain = -40
            }
            if preGain > 40 {
                preGain = 40
            }
            AudioUnitSetParameter(internalAU, kLimiterParam_PreGain, kAudioUnitScope_Global, 0, preGain, 0)
        }
    }
    
    /** Initialize the peak limiter operation */
    public init(
        _ input: AKOperation,
        attackTime: Float = 0.012,
        decayTime: Float = 0.024,
        preGain: Float = 0)
    {
        self.attackTime = attackTime
        self.decayTime = decayTime
        self.preGain = preGain
        super.init()
        
        internalEffect = AVAudioUnitEffect(audioComponentDescription: cd)
        output = internalEffect
        AKManager.sharedInstance.engine.attachNode(internalEffect)
        AKManager.sharedInstance.engine.connect(input.output!, to: internalEffect, format: nil)
        internalAU = internalEffect.audioUnit
    }
}