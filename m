From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2 11/11] mmc: tmio: add support for the VccQ regulator
Date: Wed, 23 Jan 2013 16:32:38 +0100
Message-ID: <1358955158-1510-12-git-send-email-g.liakhovetski@gmx.de>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

Some SD/MMC interfaces use 2 power regulators: one to power the card itself
(Vcc) and another one to pull signal lines up (VccQ). In case of eMMC and
UHS SD cards the regulators also have to be configured to supply different
voltages. The preferred order of turning supply power on and off is to
turn Vcc first on and last off.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2:
1. delays are necessary for reliable SDIO card probing
2. balance calls to tmio_mmc_power_on() and tmio_mmc_power_off()

 drivers/mmc/host/tmio_mmc_pio.c |   56 ++++++++++++++++++++++++++++++++-------
 1 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 13729b6..cd3b777 100644
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
@@ -155,6 +156,7 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host, int new_clock)
 		host->set_clk_div(host->pdev, (clk>>22) & 1);
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & 0x1ff);
+	msleep(10);
 }
 
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
@@ -768,16 +770,48 @@ static int tmio_mmc_clk_update(struct mmc_host *mmc)
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
+	if (!IS_ERR(mmc->supply.vmmc)) {
+		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		/*
+		 * Attention: empiric value. With a b43 WiFi SDIO card this
+		 * delay proved necessary for reliable card-insertion probing.
+		 * 100us were not enough. Is this the same 140us delay, as in
+		 * tmio_mmc_set_ios()?
+		 */
+		udelay(200);
+	}
+	/*
+	 * It seems, VccQ should be switched on after Vcc, this is also what the
+	 * omap_hsmmc.c driver does.
+	 */
+	if (!IS_ERR(mmc->supply.vqmmc) && !ret) {
+		regulator_enable(mmc->supply.vqmmc);
+		udelay(200);
+	}
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
@@ -828,18 +862,20 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!host->power) {
 			tmio_mmc_clk_update(mmc);
 			pm_runtime_get_sync(dev);
-			host->power = true;
 		}
 		tmio_mmc_set_clock(host, ios->clock);
-		/* power up SD bus */
-		tmio_mmc_set_power(host, ios);
+		if (!host->power) {
+			/* power up SD card and the bus */
+			tmio_mmc_power_on(host, ios->vdd);
+			host->power = true;
+		}
 		/* start bus clock */
 		tmio_mmc_clk_start(host);
 	} else if (ios->power_mode != MMC_POWER_UP) {
-		if (ios->power_mode == MMC_POWER_OFF)
-			tmio_mmc_set_power(host, ios);
 		if (host->power) {
 			struct tmio_mmc_data *pdata = host->pdata;
+			if (ios->power_mode == MMC_POWER_OFF)
+				tmio_mmc_power_off(host);
 			tmio_mmc_clk_stop(host);
 			host->power = false;
 			pm_runtime_put(dev);
-- 
1.7.2.5

