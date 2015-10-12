From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 3/7] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch
Date: Mon, 12 Oct 2015 14:48:26 +0200
Message-ID: <1444654110-32293-4-git-send-email-heiko@sntech.de>
References: <1444654110-32293-1-git-send-email-heiko@sntech.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:52057 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbbJLMsg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Oct 2015 08:48:36 -0400
In-Reply-To: <1444654110-32293-1-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org, Heiko Stuebner <heiko@sntech.de>

From: Douglas Anderson <dianders@chromium.org>

We've introduced a new helper in the MMC core:
mmc_regulator_set_vqmmc().  Let's use this in dw_mmc.  Using this new
helper has some advantages:

1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
   VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
   compatibility.

2. We get rid of a few more warnings when probing unsupported
   voltages.

3. We get rid of some non-dw_mmc specific code in dw_mmc.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fcbf552..b1b7e7f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1279,7 +1279,6 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	u32 uhs;
 	u32 v18 = SDMMC_UHS_18V << slot->id;
-	int min_uv, max_uv;
 	int ret;
 
 	if (drv_data && drv_data->switch_voltage)
@@ -1291,22 +1290,18 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
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
2.6.1

