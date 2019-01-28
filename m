From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH v2] mmc: mxs-mmc: Introduce regulator support
Date: Mon, 28 Jan 2019 11:20:22 +0100
Message-ID: <20190128102022.1880-1-martink@posteo.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robin@protonic.nl, ulf.hansson@linaro.org
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-mmc@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

This adds support for explicitly switching the mmc's power on and off
which is needed for example for WL1837 wifi controllers. ip link set wlan0 down
doesn't turn off the VMMC regulator which leads to hangs when loading firmware.

Tested on i.MX28.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

again, this isn't new. it's (rebased and simplified)
https://patchwork.kernel.org/patch/4365751/

Thanks Robin for your input!

revision history
----------------
v1: was just a question why this hasn't gone in earlier.


 drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..fdaca0fcec99 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -66,11 +66,13 @@ struct mxs_mmc_host {
 	struct mmc_request		*mrq;
 	struct mmc_command		*cmd;
 	struct mmc_data			*data;
+	struct regulator		*vmmc;
 
 	unsigned char			bus_width;
 	spinlock_t			lock;
 	int				sdio_irq_en;
 	bool				broken_cd;
+	unsigned char			power_mode;
 };
 
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
@@ -517,6 +519,24 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	if (host->vmmc && ios->power_mode != host->power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			if (regulator_disable(host->vmmc))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to disable vmmc regulator\n");
+			break;
+		case MMC_POWER_UP:
+			if (regulator_enable(host->vmmc))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to enable vmmc regulator\n");
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
