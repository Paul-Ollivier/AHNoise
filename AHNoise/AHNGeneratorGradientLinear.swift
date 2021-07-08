//
//  AHNGeneratorGradientLinear.swift
//  Noise Studio
//
//  Created by App Work on 06/07/2016.
//  Copyright © 2016 Andrew Heard. All rights reserved.
//

import UIKit



///Struct used to communicate properties to the GPU.
struct GradientInputs {
  var positions: Float4
  var offsetStrength: Float
  var rotations: Float3
}


///Generates a linear gradient texture between two control points.
///
///*Conforms to the `AHNTextureProvider` protocol.*
open class AHNGeneratorGradientLinear: AHNGenerator {
  
  
  // MARK:- Properties
  
  
  ///The location along the x axis of the first control point. A value of `0.0` corresponds to the left hand edge and a value of `1.0` corresponds to the right hand edge. The default value is `0.0`.
  open var startPositionX: Float = 0{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The location along the y axis of the first control point. A value of `0.0` corresponds to the bottom edge and a value of `1.0` corresponds to the top edge. The default value is `0.0`.
  open var startPositionY: Float = 0{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The location along the x axis of the second control point. A value of `0.0` corresponds to the left hand edge and a value of `1.0` corresponds to the right hand edge. The default value is `1.0`.
  open var endPositionX: Float = 1{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The location along the y axis of the second control point. A value of `0.0` corresponds to the bottom edge and a value of `1.0` corresponds to the top edge. The default value is `1.0`.
  open var endPositionY: Float = 1{
    didSet{
      dirty = true
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Initialiser
  
  
  required public init(){
      super.init(functionName: "linearGradientGenerator", hasDisplacement: true)
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Argument table update
  
  
  ///Encodes the required uniform values for this `AHNGenerator` subclass. This should never be called directly.
  override open func configureArgumentTableWithCommandencoder(_ commandEncoder: MTLComputeCommandEncoder) {
    var uniforms = GradientInputs(positions: Float4(startPositionX, startPositionY, endPositionX, endPositionY), offsetStrength: offsetStrength, rotations: Float3(xRotation, yRotation, zRotation))
    
    if uniformBuffer == nil{
      uniformBuffer = context.device.makeBuffer(length: MemoryLayout<GradientInputs>.stride, options: .storageModeShared)
    }
    
    memcpy(uniformBuffer!.contents(), &uniforms, MemoryLayout<GradientInputs>.stride)
    
    commandEncoder.setBuffer(uniformBuffer, offset: 0, index: 0)
  }
}
