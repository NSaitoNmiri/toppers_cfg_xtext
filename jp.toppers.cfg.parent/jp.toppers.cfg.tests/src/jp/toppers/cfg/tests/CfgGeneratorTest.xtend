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

	@Test
	def void test_0_1_CInclude() {
		'''
		'''.assertCompilesTo(
		'''
		''')
	}

	@Test
	def void test_1_1_CInclude() {
		'''
		#include <test1.h>
		'''.assertCompilesTo(
		'''
		#include <test1.h>
		''')
	}

	@Test
	def void test_1_2_CInclude() {
		'''
		
		#include <test1.h>
		'''.assertCompilesTo(
		'''
		#include <test1.h>
		''')
	}

	@Test
	def void test_1_3_CInclude() {
		'''
		   #include <test1.h>
		'''.assertCompilesTo(
		'''
		#include <test1.h>
		''')
	}

	@Test
	def void test_2_1_CInclude() {
		'''
		#include <test1.h>
		#include <test2.h>
		'''.assertCompilesTo(
		'''
		#include <test1.h>
		#include <test2.h>
		''')
	}

	@Test
	def void test_2_2_CInclude() {
		'''
		#include "test1.h"
		#include "test2.h"
		'''.assertCompilesTo(
		'''
		#include "test1.h"
		#include "test2.h"
		''')
	}

	@Test
	def void test_2_3_CInclude() {
		'''
		#include <test1.h>
		#include "test2.h"
		'''.assertCompilesTo(
		'''
		#include <test1.h>
		#include "test2.h"
		''')
	}

	@Test
	def void test_2_4_CInclude() {
		'''
		#include <test1.h>
		
		#include <test2.h>
		'''.assertCompilesTo(
		'''
		#include <test1.h>
		#include <test2.h>
		''')
	}

	@Test
	def void test_2_5_CInclude() {
		'''
		#include "test1.h"
		
		#include "test2.h"
		'''.assertCompilesTo(
		'''
		#include "test1.h"
		#include "test2.h"
		''')
	}

	@Test
	def void test_4_1_CInclude() {
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

	@Test
	def void test_4_2_CInclude() {
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