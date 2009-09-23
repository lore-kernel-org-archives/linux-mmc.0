From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] U300 switch MMCI to use regulator
Date: Wed, 23 Sep 2009 16:59:16 +0200
Message-ID: <1253717956-11688-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:45149 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750752AbZIWO73 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Sep 2009 10:59:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@stericsson.com>

This switches the U300 over from using a custom translate_vdd
function (which was just flipping blind bits in the hardware)
to using the regulator that actually controls the MMC voltage.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/mmc.c |   64 +++-------------------------------------------
 1 files changed, 4 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index 70f0ca5..cedc74c 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -40,64 +40,6 @@ static unsigned int mmc_status(struct device *dev)
 	return mmci_card->mmc_inserted;
 }
 
-/*
- * Here follows a large chunk of code which will only be enabled if you
- * have both the AB3100 chip mounted and the MMC subsystem activated.
- */
-
-static u32 mmc_translate_vdd(struct device *dev, unsigned int voltage)
-{
-	int v;
-
-	/*
-	 * MMC Spec:
-	 * bit 7:	1.70 - 1.95V
-	 * bit 8 - 14:	2.0 - 2.6V
-	 * bit 15 - 23:	2.7 - 3.6V
-	 *
-	 * ab3100 voltages:
-	 * 000 - 2.85V
-	 * 001 - 2.75V
-	 * 010 - 1.8V
-	 * 011 - 1.5V
-	 */
-	switch (voltage) {
-	case 8:
-		v = 3;
-		break;
-	case 9:
-	case 10:
-	case 11:
-	case 12:
-	case 13:
-	case 14:
-	case 15:
-		v = 1;
-		break;
-	case 16:
-		v = 1;
-		break;
-	case 17:
-	case 18:
-	case 19:
-	case 20:
-	case 21:
-	case 22:
-	case 23:
-	case 24:
-		v = 0;
-		break;
-	default:
-		v = 0;
-		break;
-	}
-
-	/* PL180 voltage register bits */
-	return v << 2;
-}
-
-
-
 static int mmci_callback(void *data)
 {
 	struct mmci_card_event *mmci_card = data;
@@ -154,9 +96,11 @@ int __devinit mmc_init(struct amba_device *adev)
 	if (!mmci_card)
 		return -ENOMEM;
 
+	/*
+	 * Do not set ocr_mask or voltage translation function,
+	 * we have a regulator we can control instead.
+	 */
 	/* Nominally 2.85V on our platform */
-	mmci_card->mmc0_plat_data.ocr_mask = MMC_VDD_28_29;
-	mmci_card->mmc0_plat_data.translate_vdd = mmc_translate_vdd;
 	mmci_card->mmc0_plat_data.status = mmc_status;
 	mmci_card->mmc0_plat_data.gpio_wp = -1;
 	mmci_card->mmc0_plat_data.gpio_cd = -1;
-- 
1.6.2.1

