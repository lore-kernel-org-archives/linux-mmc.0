From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH 3/5] OMAP3: hwmod data: Add HSMMC
Date: Wed,  2 Feb 2011 20:57:40 +0530
Message-ID: <1296660462-28489-4-git-send-email-kishore.kadiyala@ti.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42584 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265Ab1BBPVw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Feb 2011 10:21:52 -0500
In-Reply-To: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Update the omap3 hwmod data with the HSMMC info.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  221 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |    2 +
 arch/arm/mach-omap2/prm-regbits-34xx.h     |    4 +
 3 files changed, 227 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8d81813..47ca2ee 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -21,6 +21,7 @@
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/mmc.h>
 #include <plat/smartreflex.h>
 
 #include "omap_hwmod_common_data.h"
@@ -107,6 +108,9 @@ static struct omap_hwmod omap3xxx_uart1_hwmod;
 static struct omap_hwmod omap3xxx_uart2_hwmod;
 static struct omap_hwmod omap3xxx_uart3_hwmod;
 static struct omap_hwmod omap3xxx_uart4_hwmod;
+static struct omap_hwmod omap3xxx_mmc1_hwmod;
+static struct omap_hwmod omap3xxx_mmc2_hwmod;
+static struct omap_hwmod omap3xxx_mmc3_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
@@ -301,6 +305,63 @@ static struct omap_hwmod_ocp_if omap3_l4_core__sr2 = {
 	.user		= OCP_USER_MPU,
 };
 
+/* L4 CORE -> MMC1 interface */
+static struct omap_hwmod_addr_space omap3xxx_mmc1_addr_space[] = {
+	{
+		.pa_start	= 0x4809c000,
+		.pa_end		= 0x4809c1ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_mmc1_hwmod,
+	.clk		= "mmchs1_ick",
+	.addr		= omap3xxx_mmc1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mmc1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+/* L4 CORE -> MMC2 interface */
+static struct omap_hwmod_addr_space omap3xxx_mmc2_addr_space[] = {
+	{
+		.pa_start	= 0x480b4000,
+		.pa_end		= 0x480b41ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc2 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_mmc2_hwmod,
+	.clk		= "mmchs2_ick",
+	.addr		= omap3xxx_mmc2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mmc2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+/* L4 CORE -> MMC3 interface */
+static struct omap_hwmod_addr_space omap3xxx_mmc3_addr_space[] = {
+	{
+		.pa_start	= 0x480ad000,
+		.pa_end		= 0x480ad1ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc3 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_mmc3_hwmod,
+	.clk		= "mmchs3_ick",
+	.addr		= omap3xxx_mmc3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mmc3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
@@ -1356,11 +1417,171 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
+/* MMC/SD/SDIO common */
+
+static struct omap_hwmod_class_sysconfig mmc_sysc = {
+	.rev_offs	= 0x1fc,
+	.sysc_offs	= 0x10,
+	.syss_offs	= 0x14,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class mmc_class = {
+	.name = "mmc",
+	.sysc = &mmc_sysc,
+};
+
+/* MMC/SD/SDIO1 */
+
+static struct mmc_dev_attr omap_mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
+static struct omap_hwmod_irq_info mmc1_mpu_irqs[] = {
+	{ .irq = 83, },
+};
+
+static struct omap_hwmod_dma_info mmc1_sdma_reqs[] = {
+	{ .name = "tx",	.dma_req = 61, },
+	{ .name = "rx",	.dma_req = 62, },
+};
+
+static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
+	{ .role = "dbck", .clk = "omap_32k_fck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_mmc1_slaves[] = {
+	&omap3xxx_l4_core__mmc1,
+};
+
+static struct omap_hwmod omap3xxx_mmc1_hwmod = {
+	.name		= "mmc1_hwmod",
+	.mpu_irqs	= mmc1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(mmc1_mpu_irqs),
+	.sdma_reqs	= mmc1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(mmc1_sdma_reqs),
+	.opt_clks	= mmc1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
+	.main_clk	= "mmchs1_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_GRPSEL_MMC1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_MMC1_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mmc1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc1_slaves),
+	.class		= &mmc_class,
+	.dev_attr	= &omap_mmc1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* MMC/SD/SDIO2 */
+
+static struct mmc_dev_attr omap_mmc2_dev_attr;
+
+static struct omap_hwmod_irq_info mmc2_mpu_irqs[] = {
+	{ .irq = INT_24XX_MMC2_IRQ, },
+};
+
+static struct omap_hwmod_dma_info mmc2_sdma_reqs[] = {
+	{ .name = "tx",	.dma_req = 47, },
+	{ .name = "rx",	.dma_req = 48, },
+};
+
+static struct omap_hwmod_opt_clk mmc2_opt_clks[] = {
+	{ .role = "dbck", .clk = "omap_32k_fck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_mmc2_slaves[] = {
+	&omap3xxx_l4_core__mmc2,
+};
+
+static struct omap_hwmod omap3xxx_mmc2_hwmod = {
+	.name		= "mmc2_hwmod",
+	.mpu_irqs	= mmc2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(mmc2_mpu_irqs),
+	.sdma_reqs	= mmc2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(mmc2_sdma_reqs),
+	.opt_clks	= mmc2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mmc2_opt_clks),
+	.main_clk	= "mmchs2_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_GRPSEL_MMC2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_MMC2_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mmc2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc2_slaves),
+	.class		= &mmc_class,
+	.dev_attr	= &omap_mmc2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* MMC/SD/SDIO3 */
+
+static struct mmc_dev_attr omap_mmc3_dev_attr;
+
+static struct omap_hwmod_irq_info mmc3_mpu_irqs[] = {
+	{ .irq = 94, },
+};
+
+static struct omap_hwmod_dma_info mmc3_sdma_reqs[] = {
+	{ .name = "tx",	.dma_req = 77, },
+	{ .name = "rx",	.dma_req = 78, },
+};
+
+static struct omap_hwmod_opt_clk mmc3_opt_clks[] = {
+	{ .role = "dbck", .clk = "omap_32k_fck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_mmc3_slaves[] = {
+	&omap3xxx_l4_core__mmc3,
+};
+
+static struct omap_hwmod omap3xxx_mmc3_hwmod = {
+	.name		= "mmc3_hwmod",
+	.mpu_irqs	= mmc3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(mmc3_mpu_irqs),
+	.sdma_reqs	= mmc3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(mmc3_sdma_reqs),
+	.opt_clks	= mmc3_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mmc3_opt_clks),
+	.main_clk	= "mmchs3_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430ES2_GRPSEL_MMC3_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_MMC3_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mmc3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc3_slaves),
+	.class		= &mmc_class,
+	.dev_attr	= &omap_mmc3_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
+	&omap3xxx_mmc1_hwmod,
+	&omap3xxx_mmc2_hwmod,
+	&omap3xxx_mmc3_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
 	&omap3xxx_wd_timer2_hwmod,
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 87486f5..944916d 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -231,6 +231,8 @@
 #define OMAP3430_EN_HSOTGUSB_SHIFT			4
 
 /* PM_WKST1_CORE, CM_IDLEST1_CORE shared bits */
+#define OMAP3430_ST_MMC3_SHIFT				30
+#define OMAP3430_ST_MMC3_MASK				(1 << 30)
 #define OMAP3430_ST_MMC2_SHIFT				25
 #define OMAP3430_ST_MMC2_MASK				(1 << 25)
 #define OMAP3430_ST_MMC1_SHIFT				24
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 64c087a..71be429 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -95,7 +95,11 @@
 #define OMAP3430_WKUP_EN_MASK				(1 << 0)
 
 /* PM_MPUGRPSEL1_CORE, PM_IVA2GRPSEL1_CORE shared bits */
+#define OMAP3430ES2_GRPSEL_MMC3_SHIFT			30
+#define OMAP3430ES2_GRPSEL_MMC3_MASK			(1 << 30)
+#define OMAP3430_GRPSEL_MMC2_SHIFT			25
 #define OMAP3430_GRPSEL_MMC2_MASK			(1 << 25)
+#define OMAP3430_GRPSEL_MMC1_SHIFT			24
 #define OMAP3430_GRPSEL_MMC1_MASK			(1 << 24)
 #define OMAP3430_GRPSEL_MCSPI4_MASK			(1 << 21)
 #define OMAP3430_GRPSEL_MCSPI3_MASK			(1 << 20)
-- 
1.7.1

