From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Fixup regulator handling for vqmmc
Date: Tue, 14 May 2013 14:43:22 +0200
Message-ID: <1368535402-8897-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:36507 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751846Ab3ENNMG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 09:12:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

We can not rely on regulator_is_enabled to decide whether to
enable|disable the regulator. It would mean that the reference
counter for it is not balanced properly.

Instead keep track of our internal state by using a new flag in
the host struct, so we can take correct decisions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   10 ++++++----
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f4f3038..2983c15 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1143,9 +1143,10 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 
-		if (!IS_ERR(mmc->supply.vqmmc) &&
-		    regulator_is_enabled(mmc->supply.vqmmc))
+		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
 			regulator_disable(mmc->supply.vqmmc);
+			host->vqmmc_enabled = false;
+		}
 
 		break;
 	case MMC_POWER_UP:
@@ -1161,12 +1162,13 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		break;
 	case MMC_POWER_ON:
-		if (!IS_ERR(mmc->supply.vqmmc) &&
-		    !regulator_is_enabled(mmc->supply.vqmmc)) {
+		if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
 			ret = regulator_enable(mmc->supply.vqmmc);
 			if (ret < 0)
 				dev_err(mmc_dev(mmc),
 					"failed to enable vqmmc regulator\n");
+			else
+				host->vqmmc_enabled = true;
 		}
 
 		pwr |= MCI_PWR_ON;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 1f33ad5..1383c9c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -183,6 +183,7 @@ struct mmci_host {
 	unsigned int		cclk;
 	u32			pwr_reg;
 	u32			clk_reg;
+	bool			vqmmc_enabled;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
 
-- 
1.7.10

