From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 05/41] mmc: host: omap_hsmmc: Set clk rate to the max frequency
Date: Fri, 19 May 2017 13:45:05 +0530
Message-ID: <20170519081541.26753-6-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Set the clock rate of the functional clock to the max frequency
that is passed to the driver either using pdata or dt.

Also remove unnecessary setting of host->fclk to NULL.

This is in preparation for supporting high frequency modes
of operation.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4dbf75ad2376..77be27c8e18c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2244,22 +2244,29 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	mmc->ops	= &omap_hsmmc_ops;
 
-	mmc->f_min = OMAP_MMC_MIN_CLOCK;
-
-	if (pdata->max_freq > 0)
-		mmc->f_max = pdata->max_freq;
-	else if (mmc->f_max == 0)
-		mmc->f_max = OMAP_MMC_MAX_CLOCK;
-
 	spin_lock_init(&host->irq_lock);
 
 	host->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
-		host->fclk = NULL;
 		goto err1;
 	}
 
+	mmc->f_min = OMAP_MMC_MIN_CLOCK;
+	if (pdata->max_freq > 0)
+		mmc->f_max = pdata->max_freq;
+
+	if (mmc->f_max) {
+		ret = clk_set_rate(host->fclk, mmc->f_max);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to set clock to %d\n",
+				mmc->f_max);
+			goto err1;
+		}
+	} else {
+		mmc->f_max = OMAP_MMC_MAX_CLOCK;
+	}
+
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
 		dev_info(&pdev->dev, "multiblock reads disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\n");
 		omap_hsmmc_ops.multi_io_quirk = omap_hsmmc_multi_io_quirk;
-- 
2.11.0
