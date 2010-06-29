From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 3/3] omap: pandora: pass wl1251 information to SDIO core
Date: Tue, 29 Jun 2010 16:49:25 +0300
Message-ID: <1277819365-2761-4-git-send-email-notasas@gmail.com>
References: <1277819365-2761-1-git-send-email-notasas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40737 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab0F2Nth (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2010 09:49:37 -0400
In-Reply-To: <1277819365-2761-1-git-send-email-notasas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Adrian Hunter <adrian.hunter@nokia.com>, Tony Lindgren <tony@atomide.com>, Bob Copeland <me@bobcopeland.com>, Kalle Valo <kvalo@adurom.com>, Grazvydas Ignotas <notasas@gmail.com>

Pandora has TI WL1251 attached on MMC3, which is non-standard SDIO chip.
Make use MMC_QUIRK_NONSTD_SDIO to tell SDIO core about it.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   16 ++++++++++++++++
 arch/arm/mach-omap2/hsmmc.c              |    1 +
 arch/arm/mach-omap2/hsmmc.h              |    4 ++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index db06dc9..ebbfb49 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -29,6 +29,7 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio_keys.h>
+#include <linux/mmc/card.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -227,6 +228,20 @@ static struct platform_device pandora_dss_device = {
 	},
 };
 
+static void pandora_wl1251_init_card(struct mmc_card *card)
+{
+	/*
+	 * We have TI wl1251 attached to MMC3. Pass this information to
+	 * SDIO core because it can't be probed by normal methods.
+	 */
+	card->quirks |= MMC_QUIRK_NONSTD_SDIO;
+	card->cccr.wide_bus = 1;
+	card->cis.vendor = 0x104c;
+	card->cis.device = 0x9066;
+	card->cis.blksize = 512;
+	card->cis.max_dtr = 20000000;
+}
+
 static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	{
 		.mmc		= 1,
@@ -248,6 +263,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.init_card	= pandora_wl1251_init_card,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 1ef54b0..c8f647b 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -268,6 +268,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		mmc->slots[0].gpio_wp = c->gpio_wp;
 
 		mmc->slots[0].remux = c->remux;
+		mmc->slots[0].init_card = c->init_card;
 
 		if (c->cover_only)
 			mmc->slots[0].cover = 1;
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 36f0ba8..1fe6f01 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+struct mmc_card;
+
 struct omap2_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u8	wires;		/* 1/4/8 wires */
@@ -23,6 +25,8 @@ struct omap2_hsmmc_info {
 	int	ocr_mask;	/* temporary HACK */
 	/* Remux (pad configuation) when powering on/off */
 	void (*remux)(struct device *dev, int slot, int power_on);
+	/* init some special card */
+	void (*init_card)(struct mmc_card *card);
 };
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-- 
1.6.3.3

