From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/9] mmc: sh_mobile_sdhi: improve prerequisites for tuning
Date: Mon, 12 Dec 2016 20:51:22 +0100
Message-ID: <20161212195128.16633-4-wsa+renesas@sang-engineering.com>
References: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Prerequisites for tuning are the same as for hw_reset. We need an SCC
and a supported mode. Populate the tuning related functions only when
those conditions are met. This also removes a tiny race window.
Previously, the functions were populated when the SCC offset was not
initialized which could have led to an OOPS.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index f3ea2c8b12040c..96ebe985d5cdc6 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -611,11 +611,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		host->card_busy	= sh_mobile_sdhi_card_busy;
 		host->start_signal_voltage_switch =
 			sh_mobile_sdhi_start_signal_voltage_switch;
-		host->init_tuning	= sh_mobile_sdhi_init_tuning;
-		host->prepare_tuning	= sh_mobile_sdhi_prepare_tuning;
-		host->select_tuning	= sh_mobile_sdhi_select_tuning;
-		host->check_scc_error	= sh_mobile_sdhi_check_scc_error;
-		host->hw_reset		= sh_mobile_sdhi_hw_reset;
 	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
@@ -656,6 +651,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto efree;
 
+	/* Enable tuning iff we have an SCC and a supported mode */
 	if (of_data && of_data->scc_offset && host->mmc->caps & MMC_CAP_UHS_SDR104) {
 		const struct sh_mobile_sdhi_scc *taps = of_data->taps;
 		bool hit = false;
@@ -675,6 +671,11 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 			dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104\n");
 
 		priv->scc_ctl = host->ctl + of_data->scc_offset;
+		host->init_tuning = sh_mobile_sdhi_init_tuning;
+		host->prepare_tuning = sh_mobile_sdhi_prepare_tuning;
+		host->select_tuning = sh_mobile_sdhi_select_tuning;
+		host->check_scc_error = sh_mobile_sdhi_check_scc_error;
+		host->hw_reset = sh_mobile_sdhi_hw_reset;
 	}
 
 	i = 0;
-- 
2.10.2
