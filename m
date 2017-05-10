From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 6/6] mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file
Date: Wed, 10 May 2017 11:25:30 +0200
Message-ID: <1494408330-28161-7-git-send-email-horms+renesas@verge.net.au>
References: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54135 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbdEJJ0C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2017 05:26:02 -0400
In-Reply-To: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>

Make renesas_sdhi_sys_dmac.c a top-level module file that makes use of
library code supplied by renesas_sdhi_core.c

This is in order to facilitate adding other variants of SDHI;
in particular SDHI using different DMA controllers.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/renesas_sdhi.h          |  23 +++++-
 drivers/mmc/host/renesas_sdhi_core.c     | 132 ++-----------------------------
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 109 ++++++++++++++++++++++++-
 3 files changed, 135 insertions(+), 129 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index f65d936cd680..eb3ea15ff92d 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -12,7 +12,28 @@
 #ifndef RENESAS_SDHI_H
 #define RENESAS_SDHI_H
 
+#include <linux/platform_device.h>
 #include "tmio_mmc.h"
 
-const struct tmio_mmc_dma_ops *renesas_sdhi_get_dma_ops(void);
+struct renesas_sdhi_scc {
+	unsigned long clk_rate;	/* clock rate for SDR104 */
+	u32 tap;		/* sampling clock position for SDR104 */
+};
+
+struct renesas_sdhi_of_data {
+	unsigned long tmio_flags;
+	u32	      tmio_ocr_mask;
+	unsigned long capabilities;
+	unsigned long capabilities2;
+	enum dma_slave_buswidth dma_buswidth;
+	dma_addr_t dma_rx_offset;
+	unsigned bus_shift;
+	int scc_offset;
+	struct renesas_sdhi_scc *taps;
+	int taps_num;
+};
+
+int renesas_sdhi_probe(struct platform_device *pdev,
+                       const struct tmio_mmc_dma_ops *dma_ops);
+int renesas_sdhi_remove(struct platform_device *pdev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index b605b8fe9499..846ee1a8e5a6 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1,5 +1,5 @@
 /*
- * SuperH Mobile SDHI
+ * Renesas SDHI
  *
  * Copyright (C) 2016 Sang Engineering, Wolfram Sang
  * Copyright (C) 2015-16 Renesas Electronics Corporation
@@ -23,8 +23,6 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
@@ -48,100 +46,6 @@
 
 #define host_to_priv(host) container_of((host)->pdata, struct renesas_sdhi, mmc_data)
 
-struct renesas_sdhi_scc {
-	unsigned long clk_rate;	/* clock rate for SDR104 */
-	u32 tap;		/* sampling clock position for SDR104 */
-};
-
-struct renesas_sdhi_of_data {
-	unsigned long tmio_flags;
-	u32	      tmio_ocr_mask;
-	unsigned long capabilities;
-	unsigned long capabilities2;
-	enum dma_slave_buswidth dma_buswidth;
-	dma_addr_t dma_rx_offset;
-	unsigned bus_shift;
-	int scc_offset;
-	struct renesas_sdhi_scc *taps;
-	int taps_num;
-};
-
-static const struct renesas_sdhi_of_data of_default_cfg = {
-	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
-};
-
-static const struct renesas_sdhi_of_data of_rz_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_32BIT_DATA_PORT,
-	.tmio_ocr_mask	= MMC_VDD_32_33,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-};
-
-static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-};
-
-/* Definitions for sampling clocks */
-static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
-	{
-		.clk_rate = 156000000,
-		.tap = 0x00000703,
-	},
-	{
-		.clk_rate = 0,
-		.tap = 0x00000300,
-	},
-};
-
-static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
-	.dma_rx_offset	= 0x2000,
-	.scc_offset	= 0x0300,
-	.taps		= rcar_gen2_scc_taps,
-	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
-};
-
-/* Definitions for sampling clocks */
-static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
-	{
-		.clk_rate = 0,
-		.tap = 0x00000300,
-	},
-};
-
-static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-	.bus_shift	= 2,
-	.scc_offset	= 0x1000,
-	.taps		= rcar_gen3_scc_taps,
-	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
-};
-
-static const struct of_device_id renesas_sdhi_of_match[] = {
-	{ .compatible = "renesas,sdhi-shmobile" },
-	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
-	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
-	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
-	{ .compatible = "renesas,sdhi-r7s72100", .data = &of_rz_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
-	{},
-};
-MODULE_DEVICE_TABLE(of, renesas_sdhi_of_match);
-
 struct renesas_sdhi {
 	struct clk *clk;
 	struct clk *clk_cd;
@@ -552,9 +456,10 @@ static void renesas_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 	renesas_sdhi_sdbuf_width(host, enable ? 32 : 16);
 }
 
-static int renesas_sdhi_probe(struct platform_device *pdev)
+int renesas_sdhi_probe(struct platform_device *pdev,
+		       const struct tmio_mmc_dma_ops *dma_ops)
 {
-	const struct renesas_sdhi_of_data *of_data = of_device_get_match_data(&pdev->dev);
+	const struct renesas_sdhi_of_data *of_data = of_device_get_match_data( &pdev->dev);
 	struct renesas_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
@@ -668,7 +573,7 @@ static int renesas_sdhi_probe(struct platform_device *pdev)
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
-	ret = tmio_mmc_host_probe(host, mmc_data, renesas_sdhi_get_dma_ops());
+	ret = tmio_mmc_host_probe(host, mmc_data, dma_ops);
 	if (ret < 0)
 		goto efree;
 
@@ -734,7 +639,7 @@ static int renesas_sdhi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int renesas_sdhi_remove(struct platform_device *pdev)
+int renesas_sdhi_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
@@ -743,28 +648,3 @@ static int renesas_sdhi_remove(struct platform_device *pdev)
 
 	return 0;
 }
-
-static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-			pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			tmio_mmc_host_runtime_resume,
-			NULL)
-};
-
-static struct platform_driver renesas_sdhi_driver = {
-	.driver		= {
-		.name	= "sh_mobile_sdhi",
-		.pm	= &tmio_mmc_dev_pm_ops,
-		.of_match_table = renesas_sdhi_of_match,
-	},
-	.probe		= renesas_sdhi_probe,
-	.remove		= renesas_sdhi_remove,
-};
-
-module_platform_driver(renesas_sdhi_driver);
-
-MODULE_DESCRIPTION("Renesas SDHI driver");
-MODULE_AUTHOR("Magnus Damm");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:sh_mobile_sdhi");
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 94f453c2da6d..acc42e0a3411 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -13,13 +13,93 @@
 #include <linux/dmaengine.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 
+#include "renesas_sdhi.h"
 #include "tmio_mmc.h"
 
 #define TMIO_MMC_MIN_DMA_LEN 8
 
+static const struct renesas_sdhi_of_data of_default_cfg = {
+	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
+};
+
+static const struct renesas_sdhi_of_data of_rz_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_32BIT_DATA_PORT,
+	.tmio_ocr_mask	= MMC_VDD_32_33,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+};
+
+static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
+			  TMIO_MMC_CLK_ACTUAL,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+};
+
+/* Definitions for sampling clocks */
+static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
+	{
+		.clk_rate = 156000000,
+		.tap = 0x00000703,
+	},
+	{
+		.clk_rate = 0,
+		.tap = 0x00000300,
+	},
+};
+
+static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.dma_rx_offset	= 0x2000,
+	.scc_offset	= 0x0300,
+	.taps		= rcar_gen2_scc_taps,
+	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
+};
+
+/* Definitions for sampling clocks */
+static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
+	{
+		.clk_rate = 0,
+		.tap = 0x00000300,
+	},
+};
+
+static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.bus_shift	= 2,
+	.scc_offset	= 0x1000,
+	.taps		= rcar_gen3_scc_taps,
+	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
+};
+
+static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
+	{ .compatible = "renesas,sdhi-shmobile" },
+	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r7s72100", .data = &of_rz_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
+
+
 static void renesas_sdhi_sys_dmac_enable_dma(struct tmio_mmc_host *host,
 					     bool enable)
 {
@@ -365,7 +445,32 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
 	.abort = renesas_sdhi_sys_dmac_abort_dma,
 };
 
-const struct tmio_mmc_dma_ops *renesas_sdhi_get_dma_ops(void)
+static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
 {
-	return &renesas_sdhi_sys_dmac_dma_ops;
+	return renesas_sdhi_probe(pdev, &renesas_sdhi_sys_dmac_dma_ops);
 }
+
+static const struct dev_pm_ops renesas_sdhi_sys_dmac_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+			pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+			tmio_mmc_host_runtime_resume,
+			NULL)
+};
+
+static struct platform_driver renesas_sys_dmac_sdhi_driver = {
+	.driver		= {
+		.name	= "sh_mobile_sdhi",
+		.pm	= &renesas_sdhi_sys_dmac_dev_pm_ops,
+		.of_match_table = renesas_sdhi_sys_dmac_of_match,
+	},
+	.probe		= renesas_sdhi_sys_dmac_probe,
+	.remove		= renesas_sdhi_remove,
+};
+
+module_platform_driver(renesas_sys_dmac_sdhi_driver);
+
+MODULE_DESCRIPTION("Renesas SDHI driver");
+MODULE_AUTHOR("Magnus Damm");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:sh_mobile_sdhi");
-- 
2.1.4

