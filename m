From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 1/3] mmc: cavium: Prevent crash with incomplete DT
Date: Mon, 22 May 2017 13:09:19 +0200
Message-ID: <20170522110921.15395-2-jglauber@cavium.com>
References: <20170522110921.15395-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36535 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754079AbdEVLJj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 07:09:39 -0400
In-Reply-To: <20170522110921.15395-1-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

In case the DT specifies neither a regulator nor a gpio
for the shared power the driver will crash accessing the regulator.
Prevent the crash by checking the regulator before use.

Use mmc_regulator_get_supply() instead of open coding the same
logic.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 58b51ba..b8aaf0f 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -839,14 +839,14 @@ static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		cvm_mmc_reset_bus(slot);
 		if (host->global_pwr_gpiod)
 			host->set_shared_power(host, 0);
-		else
+		else if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 		break;
 
 	case MMC_POWER_UP:
 		if (host->global_pwr_gpiod)
 			host->set_shared_power(host, 1);
-		else
+		else if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 		break;
 	}
@@ -968,20 +968,15 @@ static int cvm_mmc_of_parse(struct device *dev, struct cvm_mmc_slot *slot)
 		return -EINVAL;
 	}
 
-	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
-	if (IS_ERR(mmc->supply.vmmc)) {
-		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		/*
-		 * Legacy Octeon firmware has no regulator entry, fall-back to
-		 * a hard-coded voltage to get a sane OCR.
-		 */
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	/*
+	 * Legacy Octeon firmware has no regulator entry, fall-back to
+	 * a hard-coded voltage to get a sane OCR.
+	 */
+	if (IS_ERR(mmc->supply.vmmc))
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-	} else {
-		ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
-		if (ret > 0)
-			mmc->ocr_avail = ret;
-	}
 
 	/* Common MMC bindings */
 	ret = mmc_of_parse(mmc);
-- 
2.9.0.rc0.21.g7777322

