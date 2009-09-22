From: akpm@linux-foundation.org
Subject: [patch 053/232] ARM: OMAP: mmc-twl4030: add context loss counter support
Date: Tue, 22 Sep 2009 16:44:40 -0700
Message-ID: <200909222344.n8MNifUE012663@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56493 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753476AbZIVXpZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 19:45:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ext-denis.2.karpov@nokia.com, adrian.hunter@nokia.com, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org, philipl@overt.org, pierre@ossman.eu, roberto.foglietta@gmail.com

From: Denis Karpov <ext-denis.2.karpov@nokia.com>

PM dynamic OFF state results in context loss.  That is, the host
controller has been powered off at some point, which means the registers
have been reset.  The driver must detect when this happens, and restore
the context.  This patch adds the means to detect context loss.

Note, the PM side is not yet implemented.

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Philip Langdale <philipl@overt.org>
Cc: "Madhusudhan" <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/mach-omap2/mmc-twl4030.c     |   15 +++++++++++++++
 arch/arm/plat-omap/include/mach/mmc.h |    3 +++
 2 files changed, 18 insertions(+)

diff -puN arch/arm/mach-omap2/mmc-twl4030.c~arm-omap-mmc-twl4030-add-context-loss-counter-support arch/arm/mach-omap2/mmc-twl4030.c
--- a/arch/arm/mach-omap2/mmc-twl4030.c~arm-omap-mmc-twl4030-add-context-loss-counter-support
+++ a/arch/arm/mach-omap2/mmc-twl4030.c
@@ -198,6 +198,18 @@ static int twl_mmc_resume(struct device 
 #define twl_mmc_resume	NULL
 #endif
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
+
+static int twl4030_mmc_get_context_loss(struct device *dev)
+{
+	/* FIXME: PM DPS not implemented yet */
+	return 0;
+}
+
+#else
+#define twl4030_mmc_get_context_loss NULL
+#endif
+
 static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
@@ -390,6 +402,9 @@ void __init twl4030_mmc_init(struct twl4
 		} else
 			mmc->slots[0].switch_pin = -EINVAL;
 
+		mmc->get_context_loss_count =
+				twl4030_mmc_get_context_loss;
+
 		/* write protect normally uses an OMAP gpio */
 		if (gpio_is_valid(c->gpio_wp)) {
 			gpio_request(c->gpio_wp, "mmc_wp");
diff -puN arch/arm/plat-omap/include/mach/mmc.h~arm-omap-mmc-twl4030-add-context-loss-counter-support arch/arm/plat-omap/include/mach/mmc.h
--- a/arch/arm/plat-omap/include/mach/mmc.h~arm-omap-mmc-twl4030-add-context-loss-counter-support
+++ a/arch/arm/plat-omap/include/mach/mmc.h
@@ -59,6 +59,9 @@ struct omap_mmc_platform_data {
 	int (*suspend)(struct device *dev, int slot);
 	int (*resume)(struct device *dev, int slot);
 
+	/* Return context loss count due to PM states changing */
+	int (*get_context_loss_count)(struct device *dev);
+
 	u64 dma_mask;
 
 	struct omap_mmc_slot_data {
_
