From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] mmc: mxs-mmc: Introduce regulator support
Date: Fri, 25 Jan 2019 12:34:49 +0100
Message-ID: <20190125113449.10128-1-martink@posteo.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robin@protonic.nl
Cc: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-mmc@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

This adds support for explicitly switching the mmc's power on and off.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

This is not my patch. It's taken from https://patchwork.kernel.org/patch/4365751/
rebased and minimally changed; but we use this.

Are there any objections to this?

Robin, can I still add your Signed-off-by to this? Also, should I set you
as the author?

thanks,

                                martin

 drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..e3c19fabb723 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -517,6 +517,26 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	if (ios->power_mode != host->power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			if ((host->vmmc) && regulator_disable(host->vmmc)) {
+				dev_err(mmc_dev(host->mmc),
+					"Failed to disable vmmc regulator\n");
+			}
+			break;
+		case MMC_POWER_UP:
+			if ((host->vmmc) && regulator_enable(host->vmmc)) {
+				dev_err(mmc_dev(host->mmc),
+					"Failed to enable vmmc regulator\n");
+			}
+			break;
+		default:
+			break;
+		}
+		host->power_mode = ios->power_mode;
+	}
+
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
@@ -613,16 +633,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
+	host->power_mode = MMC_POWER_OFF;
 
 	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
-	if (!IS_ERR(reg_vmmc)) {
-		ret = regulator_enable(reg_vmmc);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vmmc regulator: %d\n", ret);
-			goto out_mmc_free;
-		}
-	}
+	if (!IS_ERR(reg_vmmc))
+		host->vmmc = reg_vmmc;
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
-- 
2.20.1
