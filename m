From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] mmci: supply per-instance regulator name
Date: Thu, 2 Dec 2010 12:35:07 +0100
Message-ID: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:59037 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756515Ab0LBLfu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 06:35:50 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@stericsson.com>

On the Ux500 we have different regulators to different card slots
and eMMCs, and some have no regulator. Move the hardcoded "vmmc"
regulator name to platform data and supply it that way for the
platforms that use it. Remove the ugly and unneeded #ifdef around
the regulator fetch code at the same time.

Regression tested on Ux500, U300 and the ARM RealView PB1176.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/mmc.c               |    1 +
 arch/arm/mach-ux500/board-mop500-sdi.c |    3 +++
 drivers/mmc/host/mmci.c                |   25 +++++++++++++++++--------
 include/linux/amba/mmci.h              |    2 ++
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index de1ac9a..82e4843 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -102,6 +102,7 @@ int __devinit mmc_init(struct amba_device *adev)
 	 * we have a regulator we can control instead.
 	 */
 	/* Nominally 2.85V on our platform */
+	mmci_card->mmc0_plat_data.vcard = "vmmc";
 	mmci_card->mmc0_plat_data.f_max = 24000000;
 	mmci_card->mmc0_plat_data.status = mmc_status;
 	mmci_card->mmc0_plat_data.gpio_wp = -1;
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index be5e8cc..6f8d828 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -87,6 +87,7 @@ static u32 mop500_sdi0_vdd_handler(struct device *dev, unsigned int vdd,
 }
 
 static struct mmci_platform_data mop500_sdi0_data = {
+	.vcard		= "V-MMC-SD",
 	.vdd_handler	= mop500_sdi0_vdd_handler,
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 100000000,
@@ -117,6 +118,7 @@ void mop500_sdi_tc35892_init(void)
  */
 
 static struct mmci_platform_data mop500_sdi2_data = {
+	/* This is always on so needs no vcard regulator */
 	.ocr_mask	= MMC_VDD_165_195,
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
@@ -129,6 +131,7 @@ static struct mmci_platform_data mop500_sdi2_data = {
  */
 
 static struct mmci_platform_data mop500_sdi4_data = {
+	.vcard		= "V-eMMC1",
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3709ab3..23e6ebd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -844,14 +844,22 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		mmc->f_max = min(host->mclk, fmax);
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
-#ifdef CONFIG_REGULATOR
-	/* If we're using the regulator framework, try to fetch a regulator */
-	host->vcc = regulator_get(&dev->dev, "vmmc");
-	if (IS_ERR(host->vcc))
-		host->vcc = NULL;
-	else {
-		int mask = mmc_regulator_get_ocrmask(host->vcc);
+	/* Use a host regulator for card power if one is supplied */
+	if (plat->vcard) {
+		int mask;
+
+		/*
+		 * If getting the regulators fails, or if the
+		 * regulator framework is disabled (yields a NULL
+		 * regulator) we leave this.
+		 */
+		host->vcc = regulator_get(&dev->dev, plat->vcard);
+		if (IS_ERR(host->vcc))
+			host->vcc = NULL;
+		if (host->vcc == NULL)
+			goto no_regulator;
 
+		mask = mmc_regulator_get_ocrmask(host->vcc);
 		if (mask < 0)
 			dev_err(&dev->dev, "error getting OCR mask (%d)\n",
 				mask);
@@ -863,8 +871,9 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 				 "(using regulator instead)\n");
 		}
 	}
-#endif
+
 	/* Fall back to platform data if no regulator is found */
+no_regulator:
 	if (host->vcc == NULL)
 		mmc->ocr_avail = plat->ocr_mask;
 	mmc->caps = plat->capabilities;
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index f4ee9ac..614c2b6 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -9,6 +9,7 @@
 /**
  * struct mmci_platform_data - platform configuration for the MMCI
  * (also known as PL180) block.
+ * @vcard: name of regulator for card
  * @f_max: the maximum operational frequency for this host in this
  * platform configuration. When this is specified it takes precedence
  * over the module parameter for the same frequency.
@@ -29,6 +30,7 @@
  * this platform, signify anything MMC_CAP_* from mmc/host.h
  */
 struct mmci_platform_data {
+	char *vcard;
 	unsigned int f_max;
 	unsigned int ocr_mask;
 	u32 (*vdd_handler)(struct device *, unsigned int vdd,
-- 
1.7.3.2

