/*
 * generated by Xtext 2.17.0
 */
package jp.toppers.cfg.generator

import jp.toppers.cfg.cfg.C_IncludeLine
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class CfgGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		fsa.generateFile("kernel_cfg.c",'''
			«FOR i: resource.allContents.toIterable.filter(C_IncludeLine)»
				#include «i.headerName»
			«ENDFOR»
			''')
	}
}
