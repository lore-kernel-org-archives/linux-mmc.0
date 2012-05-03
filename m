From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 07/29] mmc: add a function to get a regulator, supplying card's Vdd
Date: Thu,  3 May 2012 17:05:36 +0200
Message-ID: <1336057558-11031-8-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63230 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757346Ab2ECPGD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 May 2012 11:06:03 -0400
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Add a function to get a regulator, supplying card's Vdd on a specific host.
If such a regulator is found, the function checks, whether a valid OCR mask
can be obtained from this regulator, and whether it can switch card's power
on and off.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/core/core.c  |   27 +++++++++++++++++++++++++++
 include/linux/mmc/host.h |    6 ++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7474c47..ccb5c8a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1012,6 +1012,33 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 }
 EXPORT_SYMBOL(mmc_regulator_set_ocr);
 
+struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc)
+{
+	struct device *dev = mmc_dev(mmc);
+	struct regulator *supply = devm_regulator_get(dev, "vmmc");
+	int ret;
+
+	if (IS_ERR(supply))
+		return NULL;
+
+	ret = mmc_regulator_get_ocrmask(supply);
+	if (ret > 0)
+		mmc->ocr_avail = ret;
+
+	if (regulator_can_change_status(supply)) {
+		mmc->caps |= MMC_CAP_POWER_OFF_CARD;
+		return supply;
+	}
+
+	devm_regulator_put(supply);
+
+	if (ret <= 0)
+		dev_warn(dev, "Ignoring useless (dummy?) regulator\n");
+
+	return NULL;
+}
+EXPORT_SYMBOL(mmc_regulator_get_vmmc);
+
 #endif /* CONFIG_REGULATOR */
 
 /*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cbde4b7..bcf5562 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -362,6 +362,7 @@ int mmc_regulator_get_ocrmask(struct regulator *supply);
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
+struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc);
 #else
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
 {
@@ -374,6 +375,11 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 {
 	return 0;
 }
+
+static inline struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc)
+{
+	return NULL;
+}
 #endif
 
 int mmc_card_awake(struct mmc_host *host);
-- 
1.7.2.5

