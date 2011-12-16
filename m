From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2] ARM: OMAP3: hwmod data: disable multiblock reads on MMC1/2
 on OMAP34xx/35xx <= ES2.1
Date: Fri, 16 Dec 2011 01:04:33 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112152346080.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061453540.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33215 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759703Ab1LPIEe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Dec 2011 03:04:34 -0500
In-Reply-To: <alpine.DEB.2.00.1110061453540.4611@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, Dave Hylands <dhylands@gmail.com>, Steve Sakoman <sakoman@gmail.com>


The HSMMC1/HSMMC2 host controllers on OMAP34xx and
OMAP3503/3515/3525/3530 chips at ES levels prior to 3.0 can't do multiple
block reads[1].  Mark the hwmod data appropriately.

Reported by Dave Hylands <dhylands@gmail.com> and Steve Sakoman
<sakoman@gmail.com>.  Thanks to Steve Sakoman for further help
testing this patch.

1. See for example Advisory 2.1.1.128 "MMC: Multiple Block Read
   Operation Issue" in _OMAP3530/3525/3515/3503 Silicon Errata_
   Revision F (October 2010) (SPRZ278F), available from
   http://focus.ti.com/lit/er/sprz278f/sprz278f.pdf

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Dave Hylands <dhylands@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>
---

The first version of this patch caused MMC hwmods to not be registered on 
36xx/37xx chips.  Thanks to Steve Sakoman for noting this.  This version 
fixes it - tested on 37xx BeagleBoard.

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   94 ++++++++++++++++++++++++++-
 1 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 905fc44..27f2fad 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3125,7 +3125,35 @@ static struct omap_mmc_dev_attr mmc1_dev_attr = {
 	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
 };
 
-static struct omap_hwmod omap3xxx_mmc1_hwmod = {
+/* See 35xx errata 2.1.1.128 in SPRZ278F */
+static struct omap_mmc_dev_attr mmc1_pre_es3_dev_attr = {
+	.flags = (OMAP_HSMMC_SUPPORTS_DUAL_VOLT |
+		  OMAP_HSMMC_BROKEN_MULTIBLOCK_READ),
+};
+
+static struct omap_hwmod omap3xxx_pre_es3_mmc1_hwmod = {
+	.name		= "mmc1",
+	.mpu_irqs	= omap34xx_mmc1_mpu_irqs,
+	.sdma_reqs	= omap34xx_mmc1_sdma_reqs,
+	.opt_clks	= omap34xx_mmc1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc1_opt_clks),
+	.main_clk	= "mmchs1_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MMC1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_MMC1_SHIFT,
+		},
+	},
+	.dev_attr	= &mmc1_pre_es3_dev_attr,
+	.slaves		= omap3xxx_mmc1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc1_slaves),
+	.class		= &omap34xx_mmc_class,
+};
+
+static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod = {
 	.name		= "mmc1",
 	.mpu_irqs	= omap34xx_mmc1_mpu_irqs,
 	.sdma_reqs	= omap34xx_mmc1_sdma_reqs,
@@ -3168,7 +3196,34 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc2_slaves[] = {
 	&omap3xxx_l4_core__mmc2,
 };
 
-static struct omap_hwmod omap3xxx_mmc2_hwmod = {
+/* See 35xx errata 2.1.1.128 in SPRZ278F */
+static struct omap_mmc_dev_attr mmc2_pre_es3_dev_attr = {
+	.flags = OMAP_HSMMC_BROKEN_MULTIBLOCK_READ,
+};
+
+static struct omap_hwmod omap3xxx_pre_es3_mmc2_hwmod = {
+	.name		= "mmc2",
+	.mpu_irqs	= omap34xx_mmc2_mpu_irqs,
+	.sdma_reqs	= omap34xx_mmc2_sdma_reqs,
+	.opt_clks	= omap34xx_mmc2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc2_opt_clks),
+	.main_clk	= "mmchs2_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MMC2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_MMC2_SHIFT,
+		},
+	},
+	.dev_attr	= &mmc2_pre_es3_dev_attr,
+	.slaves		= omap3xxx_mmc2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc2_slaves),
+	.class		= &omap34xx_mmc_class,
+};
+
+static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod = {
 	.name		= "mmc2",
 	.mpu_irqs	= omap34xx_mmc2_mpu_irqs,
 	.sdma_reqs	= omap34xx_mmc2_sdma_reqs,
@@ -3447,8 +3502,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
-	&omap3xxx_mmc1_hwmod,
-	&omap3xxx_mmc2_hwmod,
 	&omap3xxx_mmc3_hwmod,
 	&omap3xxx_mpu_hwmod,
 
@@ -3531,6 +3584,20 @@ static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
 	NULL
 };
 
+/* <= 3430ES3-only hwmods */
+static struct omap_hwmod *omap3430_pre_es3_hwmods[] __initdata = {
+	&omap3xxx_pre_es3_mmc1_hwmod,
+	&omap3xxx_pre_es3_mmc2_hwmod,
+	NULL
+};
+
+/* 3430ES3+-only hwmods */
+static struct omap_hwmod *omap3430_es3plus_hwmods[] __initdata = {
+	&omap3xxx_es3plus_mmc1_hwmod,
+	&omap3xxx_es3plus_mmc2_hwmod,
+	NULL
+};
+
 /* 34xx-only hwmods (all ES revisions) */
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap3xxx_iva_hwmod,
@@ -3551,6 +3618,8 @@ static __initdata struct omap_hwmod *omap36xx_hwmods[] = {
 	&omap3xxx_mailbox_hwmod,
 	&omap3xxx_usb_host_hs_hwmod,
 	&omap3xxx_usb_tll_hs_hwmod,
+	&omap3xxx_es3plus_mmc1_hwmod,
+	&omap3xxx_es3plus_mmc2_hwmod,
 	NULL
 };
 
@@ -3560,6 +3629,8 @@ static __initdata struct omap_hwmod *am35xx_hwmods[] = {
 	&am35xx_uart4_hwmod,
 	&omap3xxx_usb_host_hs_hwmod,
 	&omap3xxx_usb_tll_hs_hwmod,
+	&omap3xxx_es3plus_mmc1_hwmod,
+	&omap3xxx_es3plus_mmc2_hwmod,
 	NULL
 };
 
@@ -3619,6 +3690,21 @@ int __init omap3xxx_hwmod_init(void)
 		h = omap3430es2plus_hwmods;
 	};
 
+	if (h) {
+		r = omap_hwmod_register(h);
+		if (r < 0)
+			return r;
+	}
+
+	h = NULL;
+	if (rev == OMAP3430_REV_ES1_0 || rev == OMAP3430_REV_ES2_0 ||
+	    rev == OMAP3430_REV_ES2_1) {
+		h = omap3430_pre_es3_hwmods;
+	} else if (rev == OMAP3430_REV_ES3_0 || rev == OMAP3430_REV_ES3_1 ||
+		   rev == OMAP3430_REV_ES3_1_2) {
+		h = omap3430_es3plus_hwmods;
+	};
+
 	if (h)
 		r = omap_hwmod_register(h);
 
-- 
1.7.7.3

