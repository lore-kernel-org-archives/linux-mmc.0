From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2] mmc: sdhci: restore behavior when setting VDD via external regulator
Date: Fri, 11 Dec 2015 21:36:29 +0800
Message-ID: <1449840989-563-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

After commit 52221610dd84 ("mmc: sdhci: Improve external VDD regulator
support"), for the VDD is supplied via external regulators, we ignore
the code to convert a VDD voltage request into one of the standard
SDHCI voltage levels, then program it in the SDHCI_POWER_CONTROL. This
brings two issues:

1. SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk isn't handled properly any
more.

2. What's more, once SDHCI_POWER_ON bit is set, some controllers such
as the sdhci-pxav3 used in marvell berlin SoCs require the voltage
levels programming in the SDHCI_POWER_CONTROL register, even the VDD
is supplied by external regulator. So the host in marvell berlin SoCs
still works fine after the commit. However, commit 3cbc6123a93d ("mmc:
sdhci: Set SDHCI_POWER_ON with external vmmc") sets the SDHCI_POWER_ON
bit, this would make the host in marvell berlin SoCs won't work any
more with external vmmc.

This patch restores the behavior when setting VDD through external
regulator by moving the call of mmc_regulator_set_ocr() to the end
of sdhci_set_power() function.

After this patch, the sdcard on Marvell Berlin SoC boards work again.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Fixes: 52221610dd84 ("mmc: sdhci: Improve external VDD ...")
---
Since v1:
 - add more details about why the sdhci-pxav3 used in marvell berlin
   SoCs need this patch.

 drivers/mmc/host/sdhci.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b48565e..616aa90 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1274,19 +1274,6 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 	struct mmc_host *mmc = host->mmc;
 	u8 pwr = 0;
 
-	if (!IS_ERR(mmc->supply.vmmc)) {
-		spin_unlock_irq(&host->lock);
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-		spin_lock_irq(&host->lock);
-
-		if (mode != MMC_POWER_OFF)
-			sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
-		else
-			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
-
-		return;
-	}
-
 	if (mode != MMC_POWER_OFF) {
 		switch (1 << vdd) {
 		case MMC_VDD_165_195:
@@ -1345,6 +1332,12 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
 			mdelay(10);
 	}
+
+	if (!IS_ERR(mmc->supply.vmmc)) {
+		spin_unlock_irq(&host->lock);
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		spin_lock_irq(&host->lock);
+	}
 }
 
 /*****************************************************************************\
-- 
2.6.3
