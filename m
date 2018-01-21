From: David Lechner <david@lechnology.com>
Subject: [PATCH] mmc: davinci: dont' use module_platform_driver_probe()
Date: Sun, 21 Jan 2018 14:09:36 -0600
Message-ID: <1516565376-9960-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, David Lechner <david@lechnology.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This changes module_platform_driver_probe() to module_platform_driver()
in the TI DaVinci MMC driver.

On device tree systems, we can get a -EPROBE_DEFER when using a pinmux
for the CD GPIO, which results in the driver never loading because
module_platform_driver_probe() prevents it from being re-probed.

So, we replace module_platform_driver_probe() with
module_platform_driver() and removed the __init attributes accordingly.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/mmc/host/davinci_mmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 351330d..c5309cc 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -174,7 +174,7 @@ module_param(poll_loopcount, uint, S_IRUGO);
 MODULE_PARM_DESC(poll_loopcount,
 		 "Maximum polling loop count. Default = 32");
 
-static unsigned __initdata use_dma = 1;
+static unsigned use_dma = 1;
 module_param(use_dma, uint, 0);
 MODULE_PARM_DESC(use_dma, "Whether to use DMA or not. Default = 1");
 
@@ -496,8 +496,7 @@ static int mmc_davinci_start_dma_transfer(struct mmc_davinci_host *host,
 	return ret;
 }
 
-static void __init_or_module
-davinci_release_dma_channels(struct mmc_davinci_host *host)
+static void davinci_release_dma_channels(struct mmc_davinci_host *host)
 {
 	if (!host->use_dma)
 		return;
@@ -506,7 +505,7 @@ davinci_release_dma_channels(struct mmc_davinci_host *host)
 	dma_release_channel(host->dma_rx);
 }
 
-static int __init davinci_acquire_dma_channels(struct mmc_davinci_host *host)
+static int davinci_acquire_dma_channels(struct mmc_davinci_host *host)
 {
 	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
 	if (IS_ERR(host->dma_tx)) {
@@ -1201,7 +1200,7 @@ static int mmc_davinci_parse_pdata(struct mmc_host *mmc)
 	return 0;
 }
 
-static int __init davinci_mmcsd_probe(struct platform_device *pdev)
+static int davinci_mmcsd_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct mmc_davinci_host *host = NULL;
@@ -1414,11 +1413,12 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.pm	= davinci_mmcsd_pm_ops,
 		.of_match_table = davinci_mmc_dt_ids,
 	},
+	.probe		= davinci_mmcsd_probe,
 	.remove		= __exit_p(davinci_mmcsd_remove),
 	.id_table	= davinci_mmc_devtype,
 };
 
-module_platform_driver_probe(davinci_mmcsd_driver, davinci_mmcsd_probe);
+module_platform_driver(davinci_mmcsd_driver);
 
 MODULE_AUTHOR("Texas Instruments India");
 MODULE_LICENSE("GPL");
-- 
2.7.4
