package jp.toppers.cfg.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.xbase.testing.CompilationTestHelper
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(CfgInjectorProvider)
class CfgGeneratorTest {
	@Inject extension CompilationTestHelper

	// 生成されたコードが（字面の上で）期待通りかどうか
	@Test
	def void testGeneratedCode() {
		'''
		#include <test1.h>
		#include "test2.h"
		#include <test3.h>
		#include "test4.h"
		'''.assertCompilesTo(
		'''
		#include <test1.h>
		#include "test2.h"
		#include <test3.h>
		#include "test4.h"
		''')
	}
}