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
	def void test2_1_1_includeHeaderFile() {
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
	def void test2_1_2_includeHeaderFile() {
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
	def void test2_1_3_includeHeaderFile() {
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
	def void test2_2_1_includeHeaderFile() {
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
	def void test2_2_2_includeHeaderFile() {
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
	def void test4_1_includeHeaderFile() {
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
	def void test4_2_includeHeaderFile() {
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