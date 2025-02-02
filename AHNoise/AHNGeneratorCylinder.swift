//
//  AHNGeneratorCylinder.swift
//  Noise Studio
//
//  Created by App Work on 23/06/2016.
//  Copyright © 2016 Andrew Heard. All rights reserved.
//

import UIKit



///Struct used to communicate properties to the GPU.
internal struct GeometricInputs{
  var offset: Float
  var frequency: Float
  var xPosition: Float
  var yPosition: Float
  var zValue: Float
  var offsetStrength: Float
  var rotations: Float3
}


///Generates a texture representing a slice through a field of concentric cylinders.
///
///*Conforms to the `AHNTextureProvider` protocol.*
open class AHNGeneratorCylinder: AHNGenerator {

  
  
  // MARK:- Properties
  
  
  ///The distance to offset the first cylinder from the centre by. The default value is `0.0`. 
  open var offset: Float = 0{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The frequency of the cylinders, higher values result in more, closer packed cylinders. The default value is `1.0`.
  open var frequency: Float = 1{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The position along the x axis that the cylinders are centred on. A value of `0.0` corresponds to the left texture edge, and a value of `1.0` corresponds to the right texture edge. The default value is `0.5`.
  open var xPosition: Float = 0.5{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The position along the y axis that the cylinders are centred on. A value of `0.0` corresponds to the bottom texture edge, and a value of `1.0` corresponds to the top texture edge. The default value is `0.5`.
  open var yPosition: Float = 0.5{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The value along the z axis that the texture slice is taken. The default value is `0.0`.
  open var zValue: Float = 0{
    didSet{
      dirty = true
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Initialiser
  
  
  required public init(){
      super.init(functionName: "cylinderGenerator", hasDisplacement: true)
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Argument table update
  
  
  ///Encodes the required uniform values for this `AHNGenerator` subclass. This should never be called directly.
  override open func configureArgumentTableWithCommandencoder(_ commandEncoder: MTLComputeCommandEncoder) {
    var uniforms = GeometricInputs(offset: offset, frequency: frequency, xPosition: xPosition, yPosition: yPosition, zValue: zValue, offsetStrength: offsetStrength, rotations: Float3(xRotation, yRotation, zRotation))
    
    if uniformBuffer == nil{
      uniformBuffer = context.device.makeBuffer(length: MemoryLayout<GeometricInputs>.stride, options: .storageModeShared)
    }
    
    memcpy(uniformBuffer!.contents(), &uniforms, MemoryLayout<GeometricInputs>.stride)
    
    commandEncoder.setBuffer(uniformBuffer, offset: 0, index: 0)
  }
}
