From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Fri, 25 May 2012 17:14:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251230540.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50172 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab2EYPPG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:15:06 -0400
In-Reply-To: <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Add a function to get a regulator, supplying card's Vdd on a specific host.
If such a regulator is found, the function checks, whether a valid OCR mask
can be obtained from this regulator.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: remove bogus attempts to ignore the dummy regulator, drop the check 
for whether the regulator can change status, do not assign 
MMC_CAP_POWER_OFF_CARD automatically. Thanks to Mark and Magnus for 
comments.

 drivers/mmc/core/core.c  |   17 +++++++++++++++++
 include/linux/mmc/host.h |    6 ++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0b6141d..0f92ec0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1013,6 +1013,23 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
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
+	return supply;
+}
+EXPORT_SYMBOL(mmc_regulator_get_vmmc);
+
 #endif /* CONFIG_REGULATOR */
 
 /*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0707d22..368b317 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -364,6 +364,7 @@ int mmc_regulator_get_ocrmask(struct regulator *supply);
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
+struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc);
 #else
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
 {
@@ -376,6 +377,11 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
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

