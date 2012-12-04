From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v1 3/3] mmc: sdio: print correct UHS mode during card detection
Date: Tue,  4 Dec 2012 17:06:20 +0530
Message-ID: <1354620980-23764-4-git-send-email-subhashj@codeaurora.org>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

When SDIO3.0 card is detected, incorrect bus speed mode
is printed as part of card detection print in kernel logs.

This change fixes it so that user won't be confused by
looking at incorrect card detection message in logs.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/core/sdio.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 9565d38..3a64933 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -485,23 +485,27 @@ static int sdio_set_bus_speed_mode(struct mmc_card *card)
 			bus_speed = SDIO_SPEED_SDR104;
 			timing = MMC_TIMING_UHS_SDR104;
 			card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
+			card->sd_bus_speed = UHS_SDR104_BUS_SPEED;
 	} else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
 		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_DDR50)) {
 			bus_speed = SDIO_SPEED_DDR50;
 			timing = MMC_TIMING_UHS_DDR50;
 			card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
+			card->sd_bus_speed = UHS_DDR50_BUS_SPEED;
 	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
 		    MMC_CAP_UHS_SDR50)) && (card->sw_caps.sd3_bus_mode &
 		    SD_MODE_UHS_SDR50)) {
 			bus_speed = SDIO_SPEED_SDR50;
 			timing = MMC_TIMING_UHS_SDR50;
 			card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
+			card->sd_bus_speed = UHS_SDR50_BUS_SPEED;
 	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
 		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
 		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25)) {
 			bus_speed = SDIO_SPEED_SDR25;
 			timing = MMC_TIMING_UHS_SDR25;
 			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
+			card->sd_bus_speed = UHS_SDR25_BUS_SPEED;
 	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
 		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25 |
 		    MMC_CAP_UHS_SDR12)) && (card->sw_caps.sd3_bus_mode &
@@ -509,6 +513,7 @@ static int sdio_set_bus_speed_mode(struct mmc_card *card)
 			bus_speed = SDIO_SPEED_SDR12;
 			timing = MMC_TIMING_UHS_SDR12;
 			card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
+			card->sd_bus_speed = UHS_SDR12_BUS_SPEED;
 	}
 
 	err = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_SPEED, 0, &speed);
-- 
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
