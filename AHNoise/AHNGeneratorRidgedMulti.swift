//
//  AHNRidgedMultiGenerator.swift
//  AHNoise
//
//  Created by Andrew Heard on 24/02/2016.
//  Copyright © 2016 Andrew Heard. All rights reserved.
//


import Metal



///Generates cohesive ridges, useful as height maps for mountainous regions. The noise created lies within the range `0.0 - 1.0`.
///
///*Conforms to the `AHNTextureProvider` protocol.*
open class AHNGeneratorRidgedMulti: AHNGeneratorCoherent {

  
  // MARK:- Initialiser
  
  
  required public init(){
      super.init(functionName: "ridgedMultiGenerator", hasDisplacement: true)
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Argument table update
  
  
  ///Encodes the required uniform values for this `AHNGenerator` subclass. This should never be called directly.
  override open func configureArgumentTableWithCommandencoder(_ commandEncoder: MTLComputeCommandEncoder) {
    super.configureArgumentTableWithCommandencoder(commandEncoder)
    var uniforms = CoherentInputs(pos: Float2(xValue, yValue), rotations: Float3(xRotation, yRotation, zRotation), octaves: Int32(octaves), persistence: persistence, frequency: frequency, lacunarity: lacunarity,  zValue: zValue, wValue: wValue, offsetStrength: offsetStrength, use4D: Int32(use4D || seamless || sphereMap ? 1 : 0), sphereMap: Int32(sphereMap ? 1 : 0), seamless: Int32(seamless ? 1 : 0))
    
    if uniformBuffer == nil{
      uniformBuffer = context.device.makeBuffer(length: MemoryLayout<CoherentInputs>.stride, options: .storageModeShared)
    }

    memcpy(uniformBuffer!.contents(), &uniforms, MemoryLayout<CoherentInputs>.stride)
    
    commandEncoder.setBuffer(uniformBuffer, offset: 0, index: 4)
  }
}
