From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v4 3/4] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch
Date: Wed, 11 Mar 2015 15:15:16 -0700
Message-ID: <1426112117-18220-3-git-send-email-dianders@chromium.org>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35791 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbbCKWQD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2015 18:16:03 -0400
Received: by ieclw3 with SMTP id lw3so2382119iec.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2015 15:16:02 -0700 (PDT)
In-Reply-To: <1426112117-18220-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, javier.martinez@collabora.co.uk, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Doug Anderson <dianders@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

We've introduced a new helper in the MMC core:
mmc_regulator_set_vqmmc().  Let's use this in dw_mmc.  Using this new
helper has some advantages:

1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
   VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
   compatibility.

2. We get rid of a few more warnings when probing unsupported
   voltages.

3. We get rid of some non-dw_mmc specific code in dw_mmc.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes in v4: None
Changes in v3:
- Continue to check for errors if VQMMC is not an error as per Andrew.

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e2811cf..615d1d9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1214,7 +1214,6 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct dw_mci *host = slot->host;
 	u32 uhs;
 	u32 v18 = SDMMC_UHS_18V << slot->id;
-	int min_uv, max_uv;
 	int ret;
 
 	/*
@@ -1223,22 +1222,18 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	 * does no harm but you need to set the regulator directly.  Try both.
 	 */
 	uhs = mci_readl(host, UHS_REG);
-	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
-		min_uv = 2700000;
-		max_uv = 3600000;
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
 		uhs &= ~v18;
-	} else {
-		min_uv = 1700000;
-		max_uv = 1950000;
+	else
 		uhs |= v18;
-	}
+
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
+		ret = mmc_regulator_set_vqmmc(mmc, ios);
 
 		if (ret) {
 			dev_dbg(&mmc->class_dev,
-					 "Regulator set error %d: %d - %d\n",
-					 ret, min_uv, max_uv);
+					 "Regulator set error %d - %s V\n",
+					 ret, uhs & v18 ? "1.8" : "3.3");
 			return ret;
 		}
 	}
-- 
2.2.0.rc0.207.ga3a616c

