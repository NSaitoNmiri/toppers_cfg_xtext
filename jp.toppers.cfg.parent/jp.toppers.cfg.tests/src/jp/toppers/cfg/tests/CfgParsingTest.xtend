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
import jp.toppers.cfg.cfg.C_IncludeLine

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
		Assert.assertEquals(0, cfgFile.c_directives.length())
	}

	@Test
	def void test1_1_C_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <test1.h>
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.c_directives.get(0).line
		Assert.assertTrue(line instanceof C_IncludeLine)
		Assert.assertEquals(line.name, "<test1.h>");
	}
	
	@Test
	def void test1_2_C_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <'>
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.c_directives.get(0).line
		Assert.assertTrue(line instanceof C_IncludeLine)
		Assert.assertEquals(line.name, "<'>");
	}

	@Test
	def void test2_1_C_IncludeTwoHHeaderFile() {
		val cfgFile = '''
			#include <test1.h>
			#include <test2.h>
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.c_directives.get(0).line
		Assert.assertTrue(line1 instanceof C_IncludeLine)
		Assert.assertEquals(line1.name, "<test1.h>");
		var line2 = cfgFile.c_directives.get(1).line
		Assert.assertTrue(line2 instanceof C_IncludeLine)
		Assert.assertEquals(line2.name, "<test2.h>");
	}

	@Test
	def void test2_2_C_IncludeTwoHHeaderFile() {
		val cfgFile = '''
			#include <test1.h>
			
			#include <test2.h>
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.c_directives.get(0).line
		Assert.assertTrue(line1 instanceof C_IncludeLine)
		Assert.assertEquals(line1.name, "<test1.h>");
		var line2 = cfgFile.c_directives.get(1).line
		Assert.assertTrue(line2 instanceof C_IncludeLine)
		Assert.assertEquals(line2.name, "<test2.h>");
	}


	@Test
	def void test4_1_C_IncludeFourHHeaderFile() {
		val cfgFile = '''
			#include <test1.h>
			#include <test2.h>
			#include <test3.h>
			#include <test4.h>
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.c_directives.get(0).line
		Assert.assertTrue(line1 instanceof C_IncludeLine)
		Assert.assertEquals(line1.name, "<test1.h>");
		var line2 = cfgFile.c_directives.get(1).line
		Assert.assertTrue(line2 instanceof C_IncludeLine)
		Assert.assertEquals(line2.name, "<test2.h>");
		var line3 = cfgFile.c_directives.get(2).line
		Assert.assertTrue(line3 instanceof C_IncludeLine)
		Assert.assertEquals(line3.name, "<test3.h>");
		var line4 = cfgFile.c_directives.get(3).line
		Assert.assertTrue(line4 instanceof C_IncludeLine)
		Assert.assertEquals(line4.name, "<test4.h>");
	}

	@Test
	def void test_Err_1_1_C_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include test1.h
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_2_C_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <test1.h
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_3_C_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include test1.h>
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_4_C_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <>
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_5_C_IncludeOneHHeaderFile() {
		val cfgFile = '''
			#include <>>
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test1_1_C_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include "test1.h"
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.c_directives.get(0).line
		Assert.assertTrue(line instanceof C_IncludeLine)
		Assert.assertEquals(line.name, '"test1.h"');
	}
	
	@Test
	def void test1_2_C_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include "<"
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.c_directives.get(0).line
		Assert.assertTrue(line instanceof C_IncludeLine)
		Assert.assertEquals(line.name, '"<"');
	}

	@Test
	def void test2_1_C_IncludeTwoQHeaderFile() {
		val cfgFile = '''
			#include "test1.h"
			#include "test2.h"
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.c_directives.get(0).line
		Assert.assertTrue(line1 instanceof C_IncludeLine)
		Assert.assertEquals(line1.name, '"test1.h"');
		var line2 = cfgFile.c_directives.get(1).line
		Assert.assertTrue(line2 instanceof C_IncludeLine)
		Assert.assertEquals(line2.name, '"test2.h"');
	}

	@Test
	def void test4_1_C_IncludeFourQHeaderFile() {
		val cfgFile = '''
			#include "test1.h"
			#include "test2.h"
			#include "test3.h"
			#include "test4.h"
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.c_directives.get(0).line
		Assert.assertTrue(line1 instanceof C_IncludeLine)
		Assert.assertEquals(line1.name, '"test1.h"');
		var line2 = cfgFile.c_directives.get(1).line
		Assert.assertTrue(line2 instanceof C_IncludeLine)
		Assert.assertEquals(line2.name, '"test2.h"');
		var line3 = cfgFile.c_directives.get(2).line
		Assert.assertTrue(line3 instanceof C_IncludeLine)
		Assert.assertEquals(line3.name, '"test3.h"');
		var line4 = cfgFile.c_directives.get(3).line
		Assert.assertTrue(line4 instanceof C_IncludeLine)
		Assert.assertEquals(line4.name, '"test4.h"');
	}

	@Test
	def void test_Err_1_2_C_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include "test1.h
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_3_C_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include test1.h"
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_4_C_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include ""
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test_Err_1_5_C_IncludeOneQHeaderFile() {
		val cfgFile = '''
			#include """
		'''.parse

		val errors = cfgFile.eResource.errors
		Assert.assertFalse(errors.isEmpty)
	}

	@Test
	def void test1_1_Include() {
		val cfgFile = '''
			INCLUDE("test1.cfg");
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.includeLines.get(0)
		Assert.assertEquals(line.name, '"test1.cfg"');
	}

	@Test
	def void test1_2_Include() {
		val cfgFile = '''
			INCLUDE(<test1.cfg>);
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line = cfgFile.includeLines.get(0)
		Assert.assertEquals(line.name, "<test1.cfg>");
	}

	@Test
	def void test2_1_Include() {
		val cfgFile = '''
			INCLUDE(<test1.cfg>);
			INCLUDE(<test2.cfg>);
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.includeLines.get(0)
		Assert.assertEquals(line1.name, "<test1.cfg>");
		var line2 = cfgFile.includeLines.get(1)
		Assert.assertEquals(line2.name, "<test2.cfg>");
	}

	@Test
	def void test4_1_Include() {
		val cfgFile = '''
			INCLUDE(<test1.cfg>);
			INCLUDE(<test2.cfg>);
			INCLUDE(<test3.cfg>);
			INCLUDE(<test4.cfg>);
		'''.parse

		Assert.assertNotNull(cfgFile)
		val errors = cfgFile.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
		
		var line1 = cfgFile.includeLines.get(0)
		Assert.assertEquals(line1.name, "<test1.cfg>");
		var line2 = cfgFile.includeLines.get(1)
		Assert.assertEquals(line2.name, "<test2.cfg>");
		var line3 = cfgFile.includeLines.get(2)
		Assert.assertEquals(line3.name, "<test3.cfg>");
		var line4 = cfgFile.includeLines.get(3)
		Assert.assertEquals(line4.name, "<test4.cfg>");
	}

}
