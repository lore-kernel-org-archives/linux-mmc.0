From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: modify the variable name from "mmc" to "host"
Date: Fri, 10 Jan 2014 13:31:38 +0900
Message-ID: <52CF77AA.3090203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20432 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaAJEbb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 23:31:31 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZ600BZT4KDFT30@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 10 Jan 2014 13:31:25 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Johan Rudholm <johan.rudholm@stericsson.com>

mmc_host is used the "host" in core.c.
To be consistent, change the variable name from "mmc" to "host".
(Minor fixing)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/core.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 098374b..123f1f9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1265,7 +1265,7 @@ EXPORT_SYMBOL_GPL(mmc_regulator_get_ocrmask);
  * a particular supply voltage.  This would normally be called from the
  * set_ios() method.
  */
-int mmc_regulator_set_ocr(struct mmc_host *mmc,
+int mmc_regulator_set_ocr(struct mmc_host *host,
 			struct regulator *supply,
 			unsigned short vdd_bit)
 {
@@ -1307,42 +1307,42 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 		else
 			result = 0;
 
-		if (result == 0 && !mmc->regulator_enabled) {
+		if (result == 0 && !host->regulator_enabled) {
 			result = regulator_enable(supply);
 			if (!result)
-				mmc->regulator_enabled = true;
+				host->regulator_enabled = true;
 		}
-	} else if (mmc->regulator_enabled) {
+	} else if (host->regulator_enabled) {
 		result = regulator_disable(supply);
 		if (result == 0)
-			mmc->regulator_enabled = false;
+			host->regulator_enabled = false;
 	}
 
 	if (result)
-		dev_err(mmc_dev(mmc),
+		dev_err(mmc_dev(host),
 			"could not set regulator OCR (%d)\n", result);
 	return result;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_ocr);
 
-int mmc_regulator_get_supply(struct mmc_host *mmc)
+int mmc_regulator_get_supply(struct mmc_host *host)
 {
-	struct device *dev = mmc_dev(mmc);
+	struct device *dev = mmc_dev(host);
 	struct regulator *supply;
 	int ret;
 
 	supply = devm_regulator_get(dev, "vmmc");
-	mmc->supply.vmmc = supply;
-	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	host->supply.vmmc = supply;
+	host->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
 
 	if (IS_ERR(supply))
 		return PTR_ERR(supply);
 
 	ret = mmc_regulator_get_ocrmask(supply);
 	if (ret > 0)
-		mmc->ocr_avail = ret;
+		host->ocr_avail = ret;
 	else
-		dev_warn(mmc_dev(mmc), "Failed getting OCR mask: %d\n", ret);
+		dev_warn(mmc_dev(host), "Failed getting OCR mask: %d\n", ret);
 
 	return 0;
 }
-- 
1.7.9.5
