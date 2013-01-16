From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 11/11] mmc: tmio: add support for the VccQ regulator
Date: Wed, 16 Jan 2013 17:54:46 +0100
Message-ID: <1358355286-26029-12-git-send-email-g.liakhovetski@gmx.de>
References: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Some SD/MMC interfaces use 2 power regulators: one to power the card itself
(Vcc) and another one to pull signal lines up (VccQ). In case of eMMC and
UHS SD cards the regulators also have to be configured to supply different
voltages. The preferred order of turning supply power on and off is to
turn Vcc first on and last off.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |   40 +++++++++++++++++++++++++++++++-------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 84582b3..932579c 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -43,6 +43,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -768,16 +769,39 @@ static int tmio_mmc_clk_update(struct mmc_host *mmc)
 	return ret;
 }
 
-static void tmio_mmc_set_power(struct tmio_mmc_host *host, struct mmc_ios *ios)
+static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
 {
 	struct mmc_host *mmc = host->mmc;
+	int ret = 0;
+
+	/* .set_ios() is returning void, so, no chance to report an error */
 
 	if (host->set_pwr)
-		host->set_pwr(host->pdev, ios->power_mode != MMC_POWER_OFF);
+		host->set_pwr(host->pdev, 1);
+
+	if (!IS_ERR(mmc->supply.vmmc))
+		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+
+	/*
+	 * It seems, VccQ should be switch on after Vcc, this is also what the
+	 * omap_hsmmc.c driver does.
+	 */
+	if (!IS_ERR(mmc->supply.vqmmc) && !ret)
+		regulator_enable(mmc->supply.vqmmc);
+}
+
+static void tmio_mmc_power_off(struct tmio_mmc_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	if (!IS_ERR(mmc->supply.vqmmc))
+		regulator_disable(mmc->supply.vqmmc);
+
 	if (!IS_ERR(mmc->supply.vmmc))
-		/* Errors ignored... */
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
-				      ios->power_mode ? ios->vdd : 0);
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
+	if (host->set_pwr)
+		host->set_pwr(host->pdev, 0);
 }
 
 /* Set MMC clock / power.
@@ -831,13 +855,13 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			host->power = true;
 		}
 		tmio_mmc_set_clock(host, ios->clock);
-		/* power up SD bus */
-		tmio_mmc_set_power(host, ios);
+		/* power up SD card and the bus */
+		tmio_mmc_power_on(host, ios->vdd);
 		/* start bus clock */
 		tmio_mmc_clk_start(host);
 	} else if (ios->power_mode != MMC_POWER_UP) {
 		if (ios->power_mode == MMC_POWER_OFF)
-			tmio_mmc_set_power(host, ios);
+			tmio_mmc_power_off(host);
 		if (host->power) {
 			struct tmio_mmc_data *pdata = host->pdata;
 			tmio_mmc_clk_stop(host);
-- 
1.7.2.5

