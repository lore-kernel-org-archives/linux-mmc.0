From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v4 1/6] OMAP2430: hwmod data: Add HSMMC
Date: Fri, 25 Feb 2011 00:56:49 +0530
Message-ID: <1298575614-9388-2-git-send-email-kishore.kadiyala@ti.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36793 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756280Ab1BXTTW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 14:19:22 -0500
In-Reply-To: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Update the omap2430 hwmod data with the HSMMC info.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  146 ++++++++++++++++++++++++++++
 1 files changed, 146 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index de0015d..9c99083 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -54,6 +54,8 @@ static struct omap_hwmod omap2430_dma_system_hwmod;
 static struct omap_hwmod omap2430_mcspi1_hwmod;
 static struct omap_hwmod omap2430_mcspi2_hwmod;
 static struct omap_hwmod omap2430_mcspi3_hwmod;
+static struct omap_hwmod omap2430_mmc1_hwmod;
+static struct omap_hwmod omap2430_mmc2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
@@ -250,6 +252,42 @@ static struct omap_hwmod_ocp_if *omap2430_usbhsotg_slaves[] = {
 	&omap2430_l4_core__usbhsotg,
 };
 
+/* L4 CORE -> MMC1 interface */
+static struct omap_hwmod_addr_space omap2430_mmc1_addr_space[] = {
+	{
+		.pa_start	= 0x4809c000,
+		.pa_end		= 0x4809c1ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mmc1_hwmod,
+	.clk		= "mmchs1_ick",
+	.addr		= omap2430_mmc1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_mmc1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> MMC2 interface */
+static struct omap_hwmod_addr_space omap2430_mmc2_addr_space[] = {
+	{
+		.pa_start	= 0x480b4000,
+		.pa_end		= 0x480b41ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mmc2_hwmod,
+	.addr		= omap2430_mmc2_addr_space,
+	.clk		= "mmchs2_ick",
+	.addr_cnt	= ARRAY_SIZE(omap2430_mmc2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
 	&omap2430_l3_main__l4_core,
@@ -258,6 +296,8 @@ static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
 /* Master interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_masters[] = {
 	&omap2430_l4_core__l4_wkup,
+	&omap2430_l4_core__mmc1,
+	&omap2430_l4_core__mmc2,
 };
 
 /* L4 CORE */
@@ -1508,6 +1548,110 @@ static struct omap_hwmod omap2430_usbhsotg_hwmod = {
 
 
 
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
+static struct omap_hwmod_irq_info mmc1_mpu_irqs[] = {
+	{ .irq = 83 },
+};
+
+static struct omap_hwmod_dma_info mmc1_sdma_reqs[] = {
+	{ .name = "tx",	.dma_req = 61 }, /* DMA_MMC1_TX */
+	{ .name = "rx",	.dma_req = 62 }, /* DMA_MMC1_RX */
+};
+
+static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
+	{ .role = "dbck", .clk = "mmchsdb_fck" },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mmc1_slaves[] = {
+	&omap2430_l4_core__mmc1,
+};
+
+static struct omap_hwmod omap2430_mmc1_hwmod = {
+	.name		= "mmc1",
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
+			.prcm_reg_id = 2,
+			.module_bit  = OMAP2430_EN_MMCHS1_SHIFT,
+			.idlest_reg_id = 2,
+			.idlest_idle_bit = OMAP2430_ST_MMCHS1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mmc1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc1_slaves),
+	.class		= &mmc_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* MMC/SD/SDIO2 */
+
+static struct omap_hwmod_irq_info mmc2_mpu_irqs[] = {
+	{ .irq = 86 },
+};
+
+static struct omap_hwmod_dma_info mmc2_sdma_reqs[] = {
+	{ .name = "tx",	.dma_req = 47 }, /* DMA_MMC2_TX */
+	{ .name = "rx",	.dma_req = 48 }, /* DMA_MMC2_RX */
+};
+
+static struct omap_hwmod_opt_clk mmc2_opt_clks[] = {
+	{ .role = "dbck", .clk = "mmchsdb_fck" },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mmc2_slaves[] = {
+	&omap2430_l4_core__mmc2,
+};
+
+static struct omap_hwmod omap2430_mmc2_hwmod = {
+	.name		= "mmc2",
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
+			.prcm_reg_id = 2,
+			.module_bit  = OMAP2430_EN_MMCHS2_SHIFT,
+			.idlest_reg_id = 2,
+			.idlest_idle_bit = OMAP2430_ST_MMCHS2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mmc2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc2_slaves),
+	.class		= &mmc_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
@@ -1526,6 +1670,8 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	/* i2c class */
 	&omap2430_i2c1_hwmod,
 	&omap2430_i2c2_hwmod,
+	&omap2430_mmc1_hwmod,
+	&omap2430_mmc2_hwmod,
 
 	/* gpio class */
 	&omap2430_gpio1_hwmod,
-- 
1.7.1

