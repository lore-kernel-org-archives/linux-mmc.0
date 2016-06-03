From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 01/20] [v2] x86, intel: Introduce macros for Intel family numbers
Date: Thu, 02 Jun 2016 17:19:27 -0700
Message-ID: <20160603001927.F2A7D828@viggo.jf.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, jacob.jun.pan@intel.com, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, adrian.hunter@intel.com, ak@linux.intel.com, luto@kernel.org, bp@alien8.de, dvhart@infradead.org, dougthompson@xmission.com, edubezval@gmail.com, hpa@zytor.com, mingo@redhat.com, jacob.jun.pan@linux.intel.com, kan.liang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, mchehab@osg.samsung.com, peterz@infradead.org, platform-driver-x86@vger.kernel.org, rafael.j.wysocki@intel.com, rajneesh.bhardwaj@intel.com, souvik.k.chakravarty@intel.com, srinivas.pandruvada@linux.intel.com, eranian@google.com, tglx@linutronix.de, tony.luck@intel.com, ulf.hansson@linaro.org, viresh.kumar@linaro.org, vishwanath.somayaji@intel.com, rui.zhang@intel.com
List-Id: linux-mmc@vger.kernel.org


Changes from v1:
 * added acks from a few folks
 * Took the redundant "MODEL_" out of the macro names (Suggested
   by Borislav Petkov and acked by others)

From: Dave Hansen <dave.hansen@linux.intel.com>

If you are cc'd on this code, please check _your_ code vs. the
model list in "intel-family.h".  Please make sure you have all
the models listed that you intend to.

Also, rather than trickling these in via all the various
maintainers, should these just get pulled in to the x86 tree in
one go?

Problem:

We have a boatload of open-coded family-6 model numbers.  Half of
them have these model numbers in hex and the other half in
decimal.  This makes grepping for them tons of fun, if you were
to try.

Solution:

Consolidate all the magic numbers.  Put all the definitions in
one header.

The names here are closely derived from the comments describing
the models from arch/x86/events/intel/core.c.  We could easily
make them shorter by doing things like s/SANDYBRIDGE/SNB/, but
they seemed fine even with the longer versions to me.

Do not take any of these names too literally, like "DESKTOP"
or "MOBILE".  These are all colloquial names and not precise
descriptions of everywhere a given model will show up.

These have all been compile-tested.  I also made a stab at
dumping .o files and looking for unexpected deltas when I was
just replacing magic numbers with equivalent macros.

World-record-attempt at cc list length follows.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vishwanath Somayaji <vishwanath.somayaji@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---

 b/arch/x86/include/asm/intel-family.h |   62 ++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff -puN /dev/null arch/x86/include/asm/intel-family.h
--- /dev/null	2016-04-04 09:40:43.435149254 -0700
+++ b/arch/x86/include/asm/intel-family.h	2016-06-02 17:17:24.254885108 -0700
@@ -0,0 +1,62 @@
+#ifndef _ASM_X86_INTEL_FAMILY_H
+#define _ASM_X86_INTEL_FAMILY_H
+
+/*
+ * "Big Core" Processors (Branded as Core, Xeon, etc...)
+ *
+ * The "_X" parts are generally the EP and EX Xeons, or the
+ * "Extreme" ones, like Broadwell-E.
+ */
+
+#define INTEL_FAM6_CORE_YONAH		0x0E
+#define INTEL_FAM6_CORE2_MEROM		0x0F
+#define INTEL_FAM6_CORE2_MEROM_L	0x16
+#define INTEL_FAM6_CORE2_PENRYN		0x17
+#define INTEL_FAM6_CORE2_DUNNINGTON	0x1D
+
+#define INTEL_FAM6_NEHALEM		0x1E
+#define INTEL_FAM6_NEHALEM_EP		0x1A
+#define INTEL_FAM6_NEHALEM_EX		0x2E
+#define INTEL_FAM6_WESTMERE		0x25
+#define INTEL_FAM6_WESTMERE_EP		0x2C
+#define INTEL_FAM6_WESTMERE_EX		0x2F
+
+#define INTEL_FAM6_SANDYBRIDGE		0x2A
+#define INTEL_FAM6_SANDYBRIDGE_X	0x2D
+#define INTEL_FAM6_IVYBRIDGE		0x3A
+#define INTEL_FAM6_IVYBRIDGE_X		0x3E
+
+#define INTEL_FAM6_HASWELL_CORE		0x3C
+#define INTEL_FAM6_HASWELL_X		0x3F
+#define INTEL_FAM6_HASWELL_ULT		0x45
+#define INTEL_FAM6_HASWELL_GT3E		0x46
+
+#define INTEL_FAM6_BROADWELL_CORE	0x3D
+#define INTEL_FAM6_BROADWELL_XEON_D	0x56
+#define INTEL_FAM6_BROADWELL_GT3E	0x47
+#define INTEL_FAM6_BROADWELL_X		0x4F
+
+#define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
+#define INTEL_FAM6_SKYLAKE_DESKTOP	0x5E
+#define INTEL_FAM6_SKYLAKE_X		0x55
+#define INTEL_FAM6_KABYLAKE_MOBILE	0x8E
+#define INTEL_FAM6_KABYLAKE_DESKTOP	0x9E
+
+/* "Small Core" Processors (Atom) */
+
+#define INTEL_FAM6_ATOM_PINEVIEW	0x1C
+#define INTEL_FAM6_ATOM_LINCROFT	0x26
+#define INTEL_FAM6_ATOM_PENWELL		0x27
+#define INTEL_FAM6_ATOM_CLOVERVIEW	0x35
+#define INTEL_FAM6_ATOM_CEDARVIEW	0x36
+#define INTEL_FAM6_ATOM_SILVERMONT1	0x37
+#define INTEL_FAM6_ATOM_SILVERMONT2	0x4D /* Avaton/Rangely */
+#define INTEL_FAM6_ATOM_AIRMONT		0x4C
+#define INTEL_FAM6_ATOM_GOLDMONT	0x5C
+#define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
+
+/* Xeon Phi */
+
+#define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
+
+#endif /* _ASM_X86_INTEL_FAMILY_H */
_
