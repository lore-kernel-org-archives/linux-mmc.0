From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v13 5/6] mmc: cavium: Support DDR mode for eMMC devices
Date: Thu, 30 Mar 2017 17:31:27 +0200
Message-ID: <20170330153128.22842-6-jglauber@cavium.com>
References: <20170330153128.22842-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170330153128.22842-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Add support for switching to DDR mode for eMMC devices.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index eebb387..d842b69 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -864,6 +864,10 @@ static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+	/* DDR is available for 4/8 bit bus width */
+	if (ios->bus_width && ios->timing == MMC_TIMING_MMC_DDR52)
+		bus_width |= 4;
+
 	/* Change the clock frequency. */
 	clock = ios->clock;
 	if (clock > 52000000)
@@ -1032,8 +1036,14 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 	/* Set up host parameters */
 	mmc->ops = &cvm_mmc_ops;
 
+	/*
+	 * We only have a 3.3v supply, we cannot support any
+	 * of the UHS modes. We do support the high speed DDR
+	 * modes up to 52MHz.
+	 */
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_POWER_OFF_CARD;
+		     MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_POWER_OFF_CARD |
+		     MMC_CAP_3_3V_DDR;
 
 	if (host->use_sg)
 		mmc->max_segs = 16;
-- 
2.9.0.rc0.21.g7777322
