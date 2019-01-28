From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH v4] mmc: mxs-mmc: Introduce regulator support
Date: Mon, 28 Jan 2019 15:41:19 +0100
Message-ID: <20190128144119.10092-1-martink@posteo.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robin@protonic.nl
Cc: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-mmc@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

This adds support for explicitly switching the mmc's power on and off
which is needed for example for WL1837 WL1271 wifi controllers on imx28.

While the wifi's vmmc-supply regulator can be configured in devicetree,
"ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
to hangs when loading firmware, for example.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---


revision history                                                               
----------------                                                               
v4: re-added forgotten regulator_enable() during probe
v3: improve API usage as suggested by Ulf
v2: tested patch with changes suggested by Robin                               
v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in


 drivers/mmc/host/mxs-mmc.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..23d275269d61 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -517,6 +517,22 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(host->mmc,
+					      host->mmc->supply.vmmc, 0);
+		break;
+	case MMC_POWER_UP:
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(host->mmc,
+					      host->mmc->supply.vmmc,
+					      ios->vdd);
+		break;
+	default:
+		break;
+	}
+
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
@@ -588,7 +604,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct resource *iores;
 	int ret = 0, irq_err;
-	struct regulator *reg_vmmc;
 	struct mxs_ssp *ssp;
 
 	irq_err = platform_get_irq(pdev, 0);
@@ -614,14 +629,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
 
-	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
-	if (!IS_ERR(reg_vmmc)) {
-		ret = regulator_enable(reg_vmmc);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vmmc regulator: %d\n", ret);
-			goto out_mmc_free;
-		}
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret == -EPROBE_DEFER)
+		goto out_mmc_free;
+
+	ret = regulator_enable(mmc->supply.vmmc);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable vmmc regulator: %d\n", ret);
+		goto out_mmc_free;
 	}
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.20.1
