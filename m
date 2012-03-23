From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v1 1/1] mmc: bus: print bus speed mode of UHS-I card
Date: Fri, 23 Mar 2012 11:26:36 +0530
Message-ID: <1332482196-22572-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, arindam.nath@amd.com, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

When UHS-I card is detected also print the bus speed mode
in which UHS-I card will be running.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/core/bus.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 5d011a3..0517a91 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -267,6 +267,7 @@ int mmc_add_card(struct mmc_card *card)
 {
 	int ret;
 	const char *type;
+	const char *uhs_bus_speed_mode = "";
 
 	dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host), card->rca);
 
@@ -296,6 +297,28 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	}
 
+	if (mmc_sd_card_uhs(card)) {
+		switch (card->sd_bus_speed) {
+		case UHS_SDR104_BUS_SPEED:
+			uhs_bus_speed_mode = "SDR104 ";
+			break;
+		case UHS_SDR50_BUS_SPEED:
+			uhs_bus_speed_mode = "SDR50 ";
+			break;
+		case UHS_DDR50_BUS_SPEED:
+			uhs_bus_speed_mode = "DDR50 ";
+			break;
+		case UHS_SDR25_BUS_SPEED:
+			uhs_bus_speed_mode = "SDR25 ";
+			break;
+		case UHS_SDR12_BUS_SPEED:
+			uhs_bus_speed_mode = "SDR12 ";
+			break;
+		default:
+			uhs_bus_speed_mode = "";
+			break;
+		}
+	}
 	if (mmc_host_is_spi(card->host)) {
 		pr_info("%s: new %s%s%s card on SPI\n",
 			mmc_hostname(card->host),
@@ -303,12 +326,13 @@ int mmc_add_card(struct mmc_card *card)
 			mmc_card_ddr_mode(card) ? "DDR " : "",
 			type);
 	} else {
-		pr_info("%s: new %s%s%s%s card at address %04x\n",
+		pr_info("%s: new %s%s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
 			mmc_card_uhs(card) ? "ultra high speed " :
 			(mmc_card_highspeed(card) ? "high speed " : ""),
 			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_ddr_mode(card) ? "DDR " : "",
+			uhs_bus_speed_mode,
 			type, card->rca);
 	}
 
-- 
1.7.1.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
