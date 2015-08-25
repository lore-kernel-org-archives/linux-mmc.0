From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 05/11] mmc: host: omap_hsmmc: set clk rate to the max frequency
Date: Tue, 25 Aug 2015 14:35:36 +0530
Message-ID: <1440493542-26150-6-git-send-email-kishon@ti.com>
References: <1440493542-26150-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440493542-26150-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Set the clock rate of the functional clock to the max frequency
that is passed to the driver either using pdata or dt.

Also remove unnecessary setting of host->fclk to NULL.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7dac486..60c1ac2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2149,6 +2149,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
 	int ret, irq;
+	unsigned int freq;
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
@@ -2229,10 +2230,20 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
-		host->fclk = NULL;
 		goto err1;
 	}
 
+	freq = clk_get_rate(host->fclk);
+	if (freq > mmc->f_max) {
+		mmc->f_max = freq;
+	} else {
+		ret = clk_set_rate(host->fclk, mmc->f_max);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to set clock to %d\n", mmc->f_max);
+			goto err1;
+		}
+	}
+
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
 		dev_info(&pdev->dev, "multiblock reads disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\n");
 		omap_hsmmc_ops.multi_io_quirk = omap_hsmmc_multi_io_quirk;
-- 
1.7.9.5
