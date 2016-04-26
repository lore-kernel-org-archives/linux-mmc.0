From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP2+: n900 needs MMC slot names for legacy user space
Date: Tue, 26 Apr 2016 16:46:22 -0700
Message-ID: <1461714383-9956-2-git-send-email-tony@atomide.com>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52315 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754798AbcDZXqh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2016 19:46:37 -0400
In-Reply-To: <1461714383-9956-1-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Let's pass the slot names in pdata like the legacy code does.
Once we have a generic DT binding for the slot names we can
switch to that.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index a935d28..cfaf45f 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -21,6 +21,7 @@
 #include <linux/regulator/fixed.h>
 
 #include <linux/platform_data/pinctrl-single.h>
+#include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/wkup_m3.h>
 #include <linux/platform_data/pwm_omap_dmtimer.h>
@@ -35,6 +36,8 @@
 #include "soc.h"
 #include "hsmmc.h"
 
+static struct __maybe_unused omap_hsmmc_platform_data mmc_pdata[2];
+
 struct pdata_init {
 	const char *compatible;
 	void (*fn)(void);
@@ -271,6 +274,8 @@ static struct platform_device omap3_rom_rng_device = {
 static void __init nokia_n900_legacy_init(void)
 {
 	hsmmc2_internal_input_clk();
+	mmc_pdata[0].name = "external";
+	mmc_pdata[1].name = "internal";
 
 	if (omap_type() == OMAP2_DEVICE_TYPE_SEC) {
 		if (IS_ENABLED(CONFIG_ARM_ERRATA_430973)) {
@@ -497,6 +502,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
 		       &omap3_iommu_pdata),
+	OF_DEV_AUXDATA("ti,omap3-hsmmc", 0x4809c000, "4809c000.mmc", &mmc_pdata[0]),
+	OF_DEV_AUXDATA("ti,omap3-hsmmc", 0x480b4000, "480b4000.mmc", &mmc_pdata[1]),
 	/* Only on am3517 */
 	OF_DEV_AUXDATA("ti,davinci_mdio", 0x5c030000, "davinci_mdio.0", NULL),
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
-- 
2.8.1

