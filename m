From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v12 8/9] mmc: cavium: Support DDR mode for eMMC devices
Date: Fri, 10 Mar 2017 14:25:06 +0100
Message-ID: <20170310132507.32025-9-jglauber@cavium.com>
References: <20170310132507.32025-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170310132507.32025-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Add support for switching to DDR mode for eMMC devices.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium-mmc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium-mmc.c b/drivers/mmc/host/cavium-mmc.c
index fb6e1c1..e340b95 100644
--- a/drivers/mmc/host/cavium-mmc.c
+++ b/drivers/mmc/host/cavium-mmc.c
@@ -865,6 +865,10 @@ static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+	/* DDR is available for 4/8 bit bus width */
+	if (ios->bus_width && ios->timing == MMC_TIMING_MMC_DDR52)
+		bus_width |= 4;
+
 	slot->bus_width = bus_width;
 
 	/* Change the clock frequency. */
@@ -1057,8 +1061,14 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
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
