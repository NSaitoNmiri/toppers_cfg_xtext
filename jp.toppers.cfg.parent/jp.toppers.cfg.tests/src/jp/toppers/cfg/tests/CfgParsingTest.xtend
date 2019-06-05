/*
 * generated by Xtext 2.17.0
 */
package jp.toppers.cfg.tests

import com.google.inject.Inject
import jp.toppers.cfg.cfg.CfgFile
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(CfgInjectorProvider)
class CfgParsingTest {
	@Inject extension ParseHelper<CfgFile> parseHelper
	@Inject extension ValidationTestHelper

	@Test
	def void test0_EmptyFile() {
		var cfgFile = ''''''.parse
		Assert.assertNotNull(cfgFile)
		cfgFile.assertNoErrors
		Assert.assertEquals(0, cfgFile.includeLines.length)
	}

	@Test
	def void test1_1_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <test1.h>
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.includeLines.get(0)
		Assert.assertEquals(line.headerName, "<test1.h>");
	}
	
	@Test
	def void test1_2_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <'>
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.includeLines.get(0)
		Assert.assertEquals(line.headerName, "<'>");
	}

	@Test
	def void test2_1_IncludeTwoHHeaderFile() {
		val cfgFile = '''
			#include <test1.h>
			#include <test2.h>
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.includeLines.get(0)
		Assert.assertEquals(line1.headerName, "<test1.h>");
		var line2 = cfgFile.includeLines.get(1)
		Assert.assertEquals(line2.headerName, "<test2.h>");
	}

	@Test
	def void test4_1_IncludeFourHHeaderFile() {
		val cfgFile = '''
			#include <test1.h>
			#include <test2.h>
			#include <test3.h>
			#include <test4.h>
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.includeLines.get(0)
		Assert.assertEquals(line1.headerName, "<test1.h>");
		var line2 = cfgFile.includeLines.get(1)
		Assert.assertEquals(line2.headerName, "<test2.h>");
		var line3 = cfgFile.includeLines.get(2)
		Assert.assertEquals(line3.headerName, "<test3.h>");
		var line4 = cfgFile.includeLines.get(3)
		Assert.assertEquals(line4.headerName, "<test4.h>");
	}

	@Test
	def void test_Err_1_1_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include test1.h
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_2_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <test1.h
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_3_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include test1.h>
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_4_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <>
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_5_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <>>
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test1_1_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include "test1.h"
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.includeLines.get(0)
		Assert.assertEquals(line.headerName, '"test1.h"');
	}
	
	@Test
	def void test1_2_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include "<"
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.includeLines.get(0)
		Assert.assertEquals(line.headerName, '"<"');
	}

	@Test
	def void test2_1_IncludeTwoQHeaderFile() {
		val cfgFile = '''
			#include "test1.h"
			#include "test2.h"
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.includeLines.get(0)
		Assert.assertEquals(line1.headerName, '"test1.h"');
		var line2 = cfgFile.includeLines.get(1)
		Assert.assertEquals(line2.headerName, '"test2.h"');
	}

	@Test
	def void test4_1_IncludeFourQHeaderFile() {
		val cfgFile = '''
			#include "test1.h"
			#include "test2.h"
			#include "test3.h"
			#include "test4.h"
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.includeLines.get(0)
		Assert.assertEquals(line1.headerName, '"test1.h"');
		var line2 = cfgFile.includeLines.get(1)
		Assert.assertEquals(line2.headerName, '"test2.h"');
		var line3 = cfgFile.includeLines.get(2)
		Assert.assertEquals(line3.headerName, '"test3.h"');
		var line4 = cfgFile.includeLines.get(3)
		Assert.assertEquals(line4.headerName, '"test4.h"');
	}

	@Test
	def void test_Err_1_2_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include "test1.h
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_3_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include test1.h"
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_4_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include ""
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_5_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include """
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

}
