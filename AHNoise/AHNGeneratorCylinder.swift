//
//  AHNGeneratorCylinder.swift
//  Noise Studio
//
//  Created by App Work on 23/06/2016.
//  Copyright © 2016 Andrew Heard. All rights reserved.
//

import UIKit
import simd


///Struct used to communicate properties to the GPU.
internal struct GeometricInputs{
  var offset: Float
  var frequency: Float
  var xPosition: Float
  var yPosition: Float
  var zValue: Float
  var offsetStrength: Float
  var rotations: vector_float3
}


///Generates a texture representing a slice through a field of concentric cylinders.
///
///*Conforms to the `AHNTextureProvider` protocol.*
public class AHNGeneratorCylinder: AHNGenerator {

  
  
  // MARK:- Properties
  
  
  ///The distance to offset the first cylinder from the centre by. The default value is `0.0`. 
  public var offset: Float = 0{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The frequency of the cylinders, higher values result in more, closer packed cylinders. The default value is `1.0`.
  public var frequency: Float = 1{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The position along the x axis that the cylinders are centred on. A value of `0.0` corresponds to the left texture edge, and a value of `1.0` corresponds to the right texture edge. The default value is `0.5`.
  public var xPosition: Float = 0.5{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The position along the y axis that the cylinders are centred on. A value of `0.0` corresponds to the bottom texture edge, and a value of `1.0` corresponds to the top texture edge. The default value is `0.5`.
  public var yPosition: Float = 0.5{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The value along the z axis that the texture slice is taken. The default value is `0.0`.
  public var zValue: Float = 0{
    didSet{
      dirty = true
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Initialiser
  
  
  required public init(){
    super.init(functionName: "cylinderGenerator")
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Argument table update
  
  
  ///Encodes the required uniform values for this `AHNGenerator` subclass. This should never be called directly.
  override public func configureArgumentTableWithCommandencoder(commandEncoder: MTLComputeCommandEncoder) {
    var uniforms = GeometricInputs(offset: offset, frequency: frequency, xPosition: xPosition, yPosition: yPosition, zValue: zValue, offsetStrength: offsetStrength, rotations: vector_float3(xRotation, yRotation, zRotation))
    
    if uniformBuffer == nil{
      uniformBuffer = context.device.newBufferWithLength(strideof(GeometricInputs), options: .CPUCacheModeDefaultCache)
    }
    
    memcpy(uniformBuffer!.contents(), &uniforms, strideof(GeometricInputs))
    
    commandEncoder.setBuffer(uniformBuffer, offset: 0, atIndex: 0)
  }
}