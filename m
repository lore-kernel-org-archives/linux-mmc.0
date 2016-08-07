From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/6] mmc: dw_mmc: cleanup power setting of set_ios callback
Date: Sun,  7 Aug 2016 09:34:20 +0800
Message-ID: <1470533660-16398-1-git-send-email-shawn.lin@rock-chips.com>
References: <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:52470 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbcHGBhy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Aug 2016 21:37:54 -0400
In-Reply-To: <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Remove the ret variable and combine the condition check
to simplify the code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 32380d5..59a5e9c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1281,7 +1281,6 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 regs;
-	int ret;
 
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_4:
@@ -1319,15 +1318,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
-		if (!IS_ERR(mmc->supply.vmmc)) {
-			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
-					ios->vdd);
-			if (ret) {
-				dev_err(slot->host->dev,
-					"failed to enable vmmc regulator\n");
-				/*return, if failed turn on vmmc*/
-				return;
-			}
+		if (!IS_ERR(mmc->supply.vmmc) &&
+		    mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd)) {
+			dev_err(slot->host->dev,
+				"failed to enable vmmc regulator\n");
+			/*return, if failed turn on vmmc*/
+			return;
 		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
 		regs = mci_readl(slot->host, PWREN);
@@ -1336,14 +1332,10 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	case MMC_POWER_ON:
 		if (!slot->host->vqmmc_enabled) {
-			if (!IS_ERR(mmc->supply.vqmmc)) {
-				ret = regulator_enable(mmc->supply.vqmmc);
-				if (ret < 0)
-					dev_err(slot->host->dev,
-						"failed to enable vqmmc\n");
-				else
-					slot->host->vqmmc_enabled = true;
-
+			if (!IS_ERR(mmc->supply.vqmmc) &&
+			    regulator_enable(mmc->supply.vqmmc)) {
+				dev_err(slot->host->dev,
+					"failed to enable vqmmc\n");
 			} else {
 				/* Keep track so we don't reset again */
 				slot->host->vqmmc_enabled = true;
-- 
2.3.7


