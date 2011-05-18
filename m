From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] mmc: fix handling NULL returned from regulator_get()
Date: Wed, 18 May 2011 23:37:44 +0200
Message-ID: <1305754664-2917-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:47035 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755936Ab1ERVig (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 May 2011 17:38:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Rabin Vincent <rabin.vincent@stericsson.com>, Sascha Hauer <s.hauer@pengutronix.de>, Madhusudhan Chikkature <madhu.cr@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

When regulator_get() is stubbed down it returns NULL, handle this case
when deciding whether the driver can use the regulator or not.

Remember: IS_ERR(NULL) is false, see also this discussion for more
insight: http://comments.gmane.org/gmane.linux.kernel.mmc/7934

Now that regulator_get() is handled correctly, the ifdef on
CONFIG_REGULATOR in mmci.c can go away as well.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

 drivers/mmc/host/dw_mmc.c     |    2 +-
 drivers/mmc/host/mmci.c       |    4 +---
 drivers/mmc/host/mxcmmc.c     |    2 +-
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 drivers/mmc/host/sdhci.c      |    2 +-
 5 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 87e1f57..5be1325 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1442,7 +1442,7 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 #endif /* CONFIG_MMC_DW_IDMAC */
 
 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
-	if (IS_ERR(host->vmmc)) {
+	if (IS_ERR_OR_NULL(host->vmmc)) {
 		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
 	} else
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b4a7e4f..6fac353 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1058,10 +1058,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		mmc->f_max = min(host->mclk, fmax);
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
-#ifdef CONFIG_REGULATOR
 	/* If we're using the regulator framework, try to fetch a regulator */
 	host->vcc = regulator_get(&dev->dev, "vmmc");
-	if (IS_ERR(host->vcc))
+	if (IS_ERR_OR_NULL(host->vcc))
 		host->vcc = NULL;
 	else {
 		int mask = mmc_regulator_get_ocrmask(host->vcc);
@@ -1077,7 +1076,6 @@ static int __devinit mmci_probe(struct amba_device *dev,
 				 "(using regulator instead)\n");
 		}
 	}
-#endif
 	/* Fall back to platform data if no regulator is found */
 	if (host->vcc == NULL)
 		mmc->ocr_avail = plat->ocr_mask;
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index cc20e02..a9152da 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -155,7 +155,7 @@ static inline void mxcmci_init_ocr(struct mxcmci_host *host)
 {
 	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
 
-	if (IS_ERR(host->vcc)) {
+	if (IS_ERR_OR_NULL(host->vcc)) {
 		host->vcc = NULL;
 	} else {
 		host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 259ece0..45fd4fe 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -405,7 +405,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	}
 
 	reg = regulator_get(host->dev, "vmmc");
-	if (IS_ERR(reg)) {
+	if (IS_ERR_OR_NULL(reg)) {
 		dev_dbg(host->dev, "vmmc regulator missing\n");
 		/*
 		* HACK: until fixed.c regulator is usable,
@@ -433,7 +433,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 		/* Allow an aux regulator */
 		reg = regulator_get(host->dev, "vmmc_aux");
-		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
+		host->vcc_aux = IS_ERR_OR_NULL(reg) ? NULL : reg;
 
 		/*
 		* UGLY HACK:  workaround regulator framework bugs.
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5d20661..d3585d4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2004,7 +2004,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		goto untasklet;
 
 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
-	if (IS_ERR(host->vmmc)) {
+	if (IS_ERR_OR_NULL(host->vmmc)) {
 		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
 	} else {
-- 
1.7.5.1

