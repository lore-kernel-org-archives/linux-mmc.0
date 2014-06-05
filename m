From: Markus Mayer <markus.mayer@linaro.org>
Subject: [PATCH v2 2/3] mmc: sdhci: Use existing mmc pointer calling mmc_regulator_set_ocr()
Date: Thu, 5 Jun 2014 15:00:04 -0700
Message-ID: <1402005605-24197-3-git-send-email-markus.mayer@linaro.org>
References: <1402005605-24197-1-git-send-email-markus.mayer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:44951 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbaFEWBG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 18:01:06 -0400
In-Reply-To: <1402005605-24197-1-git-send-email-markus.mayer@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tim Kryger <tim.kryger@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>, Andrew Bresticker <abrestic@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Use the existing "mmc" pointer rather than host->mmc as first argument
to mmc_regulator_set_ocr().

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <mporter@linaro.org>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ee524b0..f15720e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1287,7 +1287,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 
 	if (!IS_ERR(mmc->supply.vmmc)) {
 		spin_unlock_irq(&host->lock);
-		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 		spin_lock_irq(&host->lock);
 	}
 }
@@ -1449,7 +1449,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		spin_unlock_irqrestore(&host->lock, flags);
 		if (!IS_ERR(mmc->supply.vmmc) &&
 		    ios->power_mode == MMC_POWER_OFF)
-			mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 		return;
 	}
 
-- 
1.9.1

