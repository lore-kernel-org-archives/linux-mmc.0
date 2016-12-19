From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v10 7/8] mmc: thunderx: Support DDR mode for eMMC devices
Date: Mon, 19 Dec 2016 13:15:51 +0100
Message-ID: <20161219121552.18316-8-jglauber@cavium.com>
References: <20161219121552.18316-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219121552.18316-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Add support for switching to DDR mode for eMMC devices.
Although the host controller only supports 3.3 Volt
and DDR52 uses 1.8 Volt according to the specification
it is possible to use DDR also with 3.3 Volt for eMMC chips.

To switch to DDR mode MMC_CAP_1_8V_DDR is required.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium_core_mmc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium_core_mmc.c b/drivers/mmc/host/cavium_core_mmc.c
index 3cd4849..ca0748c 100644
--- a/drivers/mmc/host/cavium_core_mmc.c
+++ b/drivers/mmc/host/cavium_core_mmc.c
@@ -841,6 +841,10 @@ static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+	/* DDR is available for 4/8 bit bus width */
+	if (ios->bus_width && ios->timing == MMC_TIMING_MMC_DDR52)
+		bus_width |= 4;
+
 	slot->bus_width = bus_width;
 
 	if (!ios->clock)
@@ -1065,8 +1069,15 @@ int cvm_mmc_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 	/* Set up host parameters */
 	mmc->ops = &cvm_mmc_ops;
 
+	/*
+	 * We only have a 3.3v supply, we cannot support any
+	 * of the UHS modes. We do support the high speed DDR
+	 * modes up to 52MHz. And we need to lie about 1.8v support,
+	 * otherwise the MMC layer will not switch to DDR.
+	 */
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_ERASE | MMC_CAP_CMD23;
+		     MMC_CAP_ERASE | MMC_CAP_CMD23 |
+		     MMC_CAP_1_8V_DDR;
 
 	if (host->use_sg)
 		mmc->max_segs = 16;
-- 
2.9.0.rc0.21.g7777322
