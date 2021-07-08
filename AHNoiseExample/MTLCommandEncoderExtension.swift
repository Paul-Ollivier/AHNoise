//
//  MTLCommandEncoderExtension.swift
//  Gestuo
//
//  Created by Paul Ollivier on 02/03/2021.
//

import Metal


extension MTLComputeCommandEncoder {
    
    public func dispatchMaxThreads(pipelineState: MTLComputePipelineState, textureWidth: Int, textureHeight: Int) {
        
        // Let Metal decide maximal thread allocation
        let groupWidth = pipelineState.threadExecutionWidth
        let groupHeight = pipelineState.maxTotalThreadsPerThreadgroup / groupWidth
        
        let threadsPerThreadgroup = MTLSize(
            width: groupWidth,
            height: groupHeight,
            depth: 1
        )
        
        let threadsPerGrid = MTLSize(
            width: textureWidth,
            height: textureHeight,
            depth: 1
        )
        
        self.dispatchThreads(threadsPerGrid, threadsPerThreadgroup: threadsPerThreadgroup)
    }
    
    public func dispatchMaxThreads(pipelineState: MTLComputePipelineState, width: Int) {
        
        let threadsPerThreadgroup = MTLSize(width: pipelineState.maxTotalThreadsPerThreadgroup, height: 1, depth: 1)
        let threadsPerGrid = MTLSize(width: width, height: 1, depth: 1)
        
        self.dispatchThreads(threadsPerGrid, threadsPerThreadgroup: threadsPerThreadgroup)
    }
}
