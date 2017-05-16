From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 3/5] mmc: cavium: Prevent crash with incomplete DT
Date: Tue, 16 May 2017 11:36:53 +0200
Message-ID: <20170516093655.17746-4-jglauber@cavium.com>
References: <20170516093655.17746-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170516093655.17746-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>
List-Id: linux-mmc@vger.kernel.org

In case the DT specifies neither a regulator nor a gpio
for the shared power the driver will crash accessing the regulator.
Prevent the crash by checking the regulator before use.

As the MMC devices would likely not be usable without power
check for that condition during probe and print a warning.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 58b51ba..63f96dc 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -839,14 +839,14 @@ static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		cvm_mmc_reset_bus(slot);
 		if (host->global_pwr_gpiod)
 			host->set_shared_power(host, 0);
-		else
+		else if (mmc->supply.vmmc)
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 		break;
 
 	case MMC_POWER_UP:
 		if (host->global_pwr_gpiod)
 			host->set_shared_power(host, 1);
-		else
+		else if (mmc->supply.vmmc)
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 		break;
 	}
@@ -976,6 +976,7 @@ static int cvm_mmc_of_parse(struct device *dev, struct cvm_mmc_slot *slot)
 		 * Legacy Octeon firmware has no regulator entry, fall-back to
 		 * a hard-coded voltage to get a sane OCR.
 		 */
+		mmc->supply.vmmc = NULL;
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 	} else {
 		ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
@@ -983,6 +984,9 @@ static int cvm_mmc_of_parse(struct device *dev, struct cvm_mmc_slot *slot)
 			mmc->ocr_avail = ret;
 	}
 
+	if (!mmc->supply.vmmc && !slot->host->global_pwr_gpiod)
+		dev_warn(dev, "Missing power regulator or gpio, device may not work.\n");
+
 	/* Common MMC bindings */
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.9.0.rc0.21.g7777322
