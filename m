From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/7 v4] mmc: tmio: add regulator support
Date: Wed, 20 Jun 2012 19:10:33 +0200
Message-ID: <1340212236-647-5-git-send-email-g.liakhovetski@gmx.de>
References: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

Currently the TMIO MMC driver derives the OCR mask from the platform data
and uses a platform callback to turn card power on and off. This patch adds
regulator support to the driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

v4: updated to the new mmc_regulator_get_supply() implementation

 drivers/mmc/host/tmio_mmc_pio.c |   37 +++++++++++++++++++++++++++++--------
 1 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 869ee69..410b8cf 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -767,6 +767,18 @@ static int tmio_mmc_clk_update(struct mmc_host *mmc)
 	return ret;
 }
 
+static void tmio_mmc_set_power(struct tmio_mmc_host *host, struct mmc_ios *ios)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	if (host->set_pwr)
+		host->set_pwr(host->pdev, ios->power_mode != MMC_POWER_OFF);
+	if (!IS_ERR(mmc->supply.vmmc))
+		/* Errors ignored... */
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+				      ios->power_mode ? ios->vdd : 0);
+}
+
 /* Set MMC clock / power.
  * Note: This controller uses a simple divider scheme therefore it cannot
  * run a MMC card at full speed (20MHz). The max clock is 24MHz on SD, but as
@@ -819,13 +831,12 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		tmio_mmc_set_clock(host, ios->clock);
 		/* power up SD bus */
-		if (host->set_pwr)
-			host->set_pwr(host->pdev, 1);
+		tmio_mmc_set_power(host, ios);
 		/* start bus clock */
 		tmio_mmc_clk_start(host);
 	} else if (ios->power_mode != MMC_POWER_UP) {
-		if (host->set_pwr && ios->power_mode == MMC_POWER_OFF)
-			host->set_pwr(host->pdev, 0);
+		if (ios->power_mode == MMC_POWER_OFF)
+			tmio_mmc_set_power(host, ios);
 		if (host->power) {
 			struct tmio_mmc_data *pdata = host->pdata;
 			tmio_mmc_clk_stop(host);
@@ -887,6 +898,19 @@ static const struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
+static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
+{
+	struct tmio_mmc_data *pdata = host->pdata;
+	struct mmc_host *mmc = host->mmc;
+
+	mmc_regulator_get_supply(mmc);
+
+	if (!mmc->ocr_avail)
+		mmc->ocr_avail = pdata->ocr_mask ? : MMC_VDD_32_33 | MMC_VDD_33_34;
+	else if (pdata->ocr_mask)
+		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
+}
+
 int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  struct platform_device *pdev,
 				  struct tmio_mmc_data *pdata)
@@ -932,10 +956,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 		mmc->max_segs;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
-	if (pdata->ocr_mask)
-		mmc->ocr_avail = pdata->ocr_mask;
-	else
-		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	tmio_mmc_init_ocr(_host);
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
-- 
1.7.2.5

