From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH 1/5] OMAP2420: hwmod data: Add HSMMC
Date: Wed,  2 Feb 2011 20:57:38 +0530
Message-ID: <1296660462-28489-2-git-send-email-kishore.kadiyala@ti.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41540 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab1BBPVr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Feb 2011 10:21:47 -0500
In-Reply-To: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

Update the omap2420 hwmod data with the HSMMC info.
Add a device attribute structure which will be used
by the host driver to find whether the HSMMC controller
supports DUAL VOLT cards.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   88 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mmc.h      |    7 ++
 2 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b85c630..1fbb618 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -18,6 +18,7 @@
 #include <plat/serial.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/mmc.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -44,6 +45,7 @@ static struct omap_hwmod omap2420_gpio2_hwmod;
 static struct omap_hwmod omap2420_gpio3_hwmod;
 static struct omap_hwmod omap2420_gpio4_hwmod;
 static struct omap_hwmod omap2420_dma_system_hwmod;
+static struct omap_hwmod omap2420_mmc1_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
@@ -95,6 +97,24 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* L4 CORE -> MMC1 interface */
+static struct omap_hwmod_addr_space omap2420_mmc1_addr_space[] = {
+	{
+		.pa_start	= 0x4809c000,
+		.pa_end		= 0x4809c07f,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_core__mmc1 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_mmc1_hwmod,
+	.clk		= "mmchs1_ick",
+	.addr		= omap2420_mmc1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_mmc1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* L4 CORE -> UART1 interface */
 static struct omap_hwmod_addr_space omap2420_uart1_addr_space[] = {
 	{
@@ -196,6 +216,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
 /* Master interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
 	&omap2420_l4_core__l4_wkup,
+	&omap2420_l4_core__mmc1,
 	&omap2_l4_core__uart1,
 	&omap2_l4_core__uart2,
 	&omap2_l4_core__uart3,
@@ -864,6 +885,72 @@ static struct omap_hwmod omap2420_dma_system_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/* MMC/SD/SDIO common */
+
+static struct omap_hwmod_class_sysconfig mmc_sysc = {
+	.rev_offs	= 0x3c,
+	.sysc_offs	= 0x64,
+	.syss_offs	= 0x68,
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
+static struct mmc_dev_attr mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
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
+static struct omap_hwmod_ocp_if *omap2420_mmc1_slaves[] = {
+	&omap2420_l4_core__mmc1,
+};
+
+static struct omap_hwmod omap2420_mmc1_hwmod = {
+	.name		= "mmc1_hwmod",
+	.mpu_irqs	= mmc1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(mmc1_mpu_irqs),
+	.sdma_reqs	= mmc1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(mmc1_sdma_reqs),
+	.opt_clks	= mmc1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
+	.main_clk	= "mmchs1_fck",
+	.prcm		= {
+	.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit  = OMAP2420_EN_MMC_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP2420_ST_MMC_SHIFT,
+		},
+	},
+	.slaves		= omap2420_mmc1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mmc1_slaves),
+	.class		= &mmc_class,
+	.dev_attr	= &mmc1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -871,6 +958,7 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_mpu_hwmod,
 	&omap2420_iva_hwmod,
 	&omap2420_wd_timer2_hwmod,
+	&omap2420_mmc1_hwmod,
 	&omap2420_uart1_hwmod,
 	&omap2420_uart2_hwmod,
 	&omap2420_uart3_hwmod,
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index f57f36a..7821344 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -43,6 +43,13 @@
 
 #define OMAP_MMC_MAX_SLOTS	2
 
+/* omap_hwmod integration data */
+#define OMAP_HSMMC_SUPPORTS_DUAL_VOLT	BIT(1)
+
+struct mmc_dev_attr {
+	u8 flags;
+};
+
 struct omap_mmc_platform_data {
 	/* back-link to device */
 	struct device *dev;
-- 
1.7.1

