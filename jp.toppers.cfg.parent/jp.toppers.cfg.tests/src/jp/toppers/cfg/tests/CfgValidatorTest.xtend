package jp.toppers.cfg.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Test
import org.junit.runner.RunWith
import jp.toppers.cfg.cfg.CfgFile
import jp.toppers.cfg.cfg.CfgPackage
import jp.toppers.cfg.validation.CfgValidator

@RunWith(XtextRunner)
@InjectWith(CfgInjectorProvider)
class CfgValidatorTest {
	@Inject extension ParseHelper<CfgFile>	
	@Inject extension ValidationTestHelper
	
	@Test
	def void test_1_1_CInclude_SharpIsBol() {
		'''
			#include <test1.h>
			  #include <test2.h>
		'''.parse.assertNoErrors
	}

	@Test
	def void test_1_2_CInclude_SharpIsBol() {
		'''
			#include <test1.h>
			
			 #include <test2.h>
		'''.parse.assertNoErrors
	}

	@Test
	def void test_2_1_CInclude_SharpIsBol() {
		'''
		#include <test1.h>#include <test2.h>
		'''.parse.assertSharpIsNotBol("#include <test2.h>")
	}

	@Test
	def void test_2_1_CInclude_SharpIsBol_ErrPos() {
		val testInput =
		'''
		#include <test1.h>#include <test2.h>
		'''
		testInput.parse.assertError(
			CfgPackage.eINSTANCE.c_Directive,
			CfgValidator.NO_BOL_SHARP,
			testInput.lastIndexOf("#"),  // offset
			"#".length      // length
		)
	}

	def private void assertSharpIsNotBol(CfgFile m, String lineString) {
		m.assertError(
			CfgPackage.eINSTANCE.c_Directive,
			CfgValidator.NO_BOL_SHARP,
			"'#' is not the beginning of line."
		)
	}

	@Test
	def void test_1_1_CInclude_NlIsNotEol() {
		'''#include <test1.h>'''.parse.assertNlIsNotEol
	}

	@Test
	def void test_1_2_CInclude_NlIsNotEol() {
		'''#include <test1.h> foo
		'''.parse.assertNlIsNotEol
	}

	@Test
	def void test_1_3_CInclude_NlIsNotEol() {
		'''#include <test1.h>INCLUDE("test2.h");
		'''.parse.assertNlIsNotEol
	}

	@Test
	def void test_1_1_CInclude_NlIsNotEol_ErrPos() {
		val testInput ='''#include <test1.h>'''

		testInput.parse.assertError(
			CfgPackage.eINSTANCE.c_Directive,
			CfgValidator.NO_EOL_NL,
			testInput.indexOf("include"),  // offset
			"include <test1.h>".length      // length
		)
	}

	def private void assertNlIsNotEol(CfgFile m) {
		m.assertError(
			CfgPackage.eINSTANCE.c_Directive,
			CfgValidator.NO_EOL_NL,
			"new-line charactor is required at the end of C preprosessor directives."
		)
	}

	@Test
	def void test_1_1_CDirective_ExtraNlIsInCDirective() {
		'''
			#
			 include <test1.h>
		'''.parse.assertExtraNlIsInCDirective
	}

	def private void assertExtraNlIsInCDirective(CfgFile m) {
		m.assertError(
			CfgPackage.eINSTANCE.c_Directive,
			CfgValidator.EXTRA_NL_IN_CDIRECTIVE,
			"extra new-line charactor is detected in C preprosessor directives."
		)
	}

	@Test
	def void test_1_1_CInclude_ExtraNl() {
		'''
			#include
			 <test1.h>
		'''.parse.assertExtraNlIsInCInclude
	}

	def private void assertExtraNlIsInCInclude(CfgFile m) {
		m.assertError(
			CfgPackage.eINSTANCE.c_IncludeLine,
			CfgValidator.EXTRA_NL_IN_CINCLUDE,
			"extra new-line charactor is detected in C include lines."
		)
	}
}
