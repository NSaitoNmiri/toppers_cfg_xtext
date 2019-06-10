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
	def void test1_1_NlIsNotEol() {
		'''#include <test1.h>'''.parse.assertNlIsNotEol
	}

	@Test
	def void test1_2_NlIsNotEol() {
		'''#include <test1.h> foo
		'''.parse.assertNlIsNotEol
	}


	@Test
	def void test2_1_SharpIsNotBol() {
		'''
		#include <test1.h>#include <test2.h>
		'''.parse.assertSharpIsNotBol("#include <test2.h>")
	}
	
	def private void assertSharpIsNotBol(CfgFile m, String lineString) {
		m.assertError(
			CfgPackage.eINSTANCE.c_IncludeLine,
			CfgValidator.NO_BOL_SHARP,
			"'#' is not the beginning of line."
		)
	}

	def private void assertNlIsNotEol(CfgFile m) {
		m.assertError(
			CfgPackage.eINSTANCE.c_IncludeLine,
			CfgValidator.NO_EOL_NL,
			"new-line charactor is required at the end of C preprosessor directives."
		)
	}

	@Test
	def void test1_2_NlIsNotEol_ErrorPosition() {
		val testInput ='''#include <test1.h>'''

		testInput.parse.assertError(
			CfgPackage.eINSTANCE.c_IncludeLine,
			CfgValidator.NO_EOL_NL,
			testInput.indexOf("<"),  // offset
			"<test1.h>".length      // length
		)
	}
	@Test
	def void test2_2_SharpIsNotBol_ErrorPosition() {
		val testInput =
		'''
		#include <test1.h>#include <test2.h>
		'''
		testInput.parse.assertError(
			CfgPackage.eINSTANCE.c_IncludeLine,
			CfgValidator.NO_BOL_SHARP,
			testInput.lastIndexOf("#"),  // offset
			"#".length      // length
		)
	}

	@Test
	def void testSharpIsBOL() {
		'''
			#include <test1.h>
			  #include <test2.h>
		'''.parse.assertNoErrors
	}
}
