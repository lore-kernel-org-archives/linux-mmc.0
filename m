From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 03/10] mmc: mxs-mmc: get rid of the use of cpu_is_xxx
Date: Mon,  7 May 2012 22:43:05 +0800
Message-ID: <1336401793-13753-4-git-send-email-shawn.guo@linaro.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46809 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab2EGOnY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 10:43:24 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1335513dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 May 2012 07:43:24 -0700 (PDT)
In-Reply-To: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>

The register HW_SSP_VERSION is broken for ssp version detection,
as the address of the register is different between imx23 and imx28.
Let's use platform_device_id to detect the device, so that the use
of cpu_is_xxx can be removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c    |   21 ++++++++-------
 arch/arm/mach-mxs/include/mach/devices-common.h |    1 +
 drivers/clk/mxs/clk-imx23.c                     |    4 +-
 drivers/clk/mxs/clk-imx28.c                     |    8 +++---
 drivers/mmc/host/mxs-mmc.c                      |   32 +++++++++++++++-------
 5 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/platform-mxs-mmc.c b/arch/arm/mach-mxs/devices/platform-mxs-mmc.c
index bef9d92..b33c9d0 100644
--- a/arch/arm/mach-mxs/devices/platform-mxs-mmc.c
+++ b/arch/arm/mach-mxs/devices/platform-mxs-mmc.c
@@ -17,8 +17,9 @@
 #include <mach/mx28.h>
 #include <mach/devices-common.h>
 
-#define mxs_mxs_mmc_data_entry_single(soc, _id, hwid)			\
+#define mxs_mxs_mmc_data_entry_single(soc, _devid, _id, hwid)		\
 	{								\
+		.devid = _devid,					\
 		.id = _id,						\
 		.iobase = soc ## _SSP ## hwid ## _BASE_ADDR,		\
 		.dma = soc ## _DMA_SSP ## hwid,				\
@@ -26,23 +27,23 @@
 		.irq_dma = soc ## _INT_SSP ## hwid ## _DMA,		\
 	}
 
-#define mxs_mxs_mmc_data_entry(soc, _id, hwid)				\
-	[_id] = mxs_mxs_mmc_data_entry_single(soc, _id, hwid)
+#define mxs_mxs_mmc_data_entry(soc, _devid, _id, hwid)			\
+	[_id] = mxs_mxs_mmc_data_entry_single(soc, _devid, _id, hwid)
 
 
 #ifdef CONFIG_SOC_IMX23
 const struct mxs_mxs_mmc_data mx23_mxs_mmc_data[] __initconst = {
-	mxs_mxs_mmc_data_entry(MX23, 0, 1),
-	mxs_mxs_mmc_data_entry(MX23, 1, 2),
+	mxs_mxs_mmc_data_entry(MX23, "imx23-mmc", 0, 1),
+	mxs_mxs_mmc_data_entry(MX23, "imx23-mmc", 1, 2),
 };
 #endif
 
 #ifdef CONFIG_SOC_IMX28
 const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst = {
-	mxs_mxs_mmc_data_entry(MX28, 0, 0),
-	mxs_mxs_mmc_data_entry(MX28, 1, 1),
-	mxs_mxs_mmc_data_entry(MX28, 2, 2),
-	mxs_mxs_mmc_data_entry(MX28, 3, 3),
+	mxs_mxs_mmc_data_entry(MX28, "imx28-mmc", 0, 0),
+	mxs_mxs_mmc_data_entry(MX28, "imx28-mmc", 1, 1),
+	mxs_mxs_mmc_data_entry(MX28, "imx28-mmc", 2, 2),
+	mxs_mxs_mmc_data_entry(MX28, "imx28-mmc", 3, 3),
 };
 #endif
 
@@ -70,6 +71,6 @@ struct platform_device *__init mxs_add_mxs_mmc(
 		},
 	};
 
-	return mxs_add_platform_device("mxs-mmc", data->id,
+	return mxs_add_platform_device(data->devid, data->id,
 			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index f2e3839..2b37689 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -89,6 +89,7 @@ struct platform_device * __init mxs_add_mxs_i2c(
 /* mmc */
 #include <mach/mmc.h>
 struct mxs_mxs_mmc_data {
+	const char *devid;
 	int id;
 	resource_size_t iobase;
 	resource_size_t dma;
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 96562f5..f7be225 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -93,8 +93,8 @@ static struct clk_lookup xbus_lookups[] __initdata = {
 };
 
 static struct clk_lookup ssp_lookups[] __initdata = {
-	{ .dev_id = "mxs-mmc.0", },
-	{ .dev_id = "mxs-mmc.1", },
+	{ .dev_id = "imx23-mmc.0", },
+	{ .dev_id = "imx23-mmc.1", },
 	{ .dev_id = "80010000.ssp", },
 	{ .dev_id = "80034000.ssp", },
 };
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index e18cac9..cadc801 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -139,22 +139,22 @@ static struct clk_lookup xbus_lookups[] __initdata = {
 };
 
 static struct clk_lookup ssp0_lookups[] __initdata = {
-	{ .dev_id = "mxs-mmc.0", },
+	{ .dev_id = "imx28-mmc.0", },
 	{ .dev_id = "80010000.ssp", },
 };
 
 static struct clk_lookup ssp1_lookups[] __initdata = {
-	{ .dev_id = "mxs-mmc.1", },
+	{ .dev_id = "imx28-mmc.1", },
 	{ .dev_id = "80012000.ssp", },
 };
 
 static struct clk_lookup ssp2_lookups[] __initdata = {
-	{ .dev_id = "mxs-mmc.2", },
+	{ .dev_id = "imx28-mmc.2", },
 	{ .dev_id = "80014000.ssp", },
 };
 
 static struct clk_lookup ssp3_lookups[] __initdata = {
-	{ .dev_id = "mxs-mmc.3", },
+	{ .dev_id = "imx28-mmc.3", },
 	{ .dev_id = "80016000.ssp", },
 };
 
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 13907e4..54bbb8b 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -42,7 +42,6 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/stmp_device.h>
 
-#include <mach/mxs.h>
 #include <mach/mmc.h>
 
 #define DRIVER_NAME	"mxs-mmc"
@@ -50,8 +49,7 @@
 /* card detect polling timeout */
 #define MXS_MMC_DETECT_TIMEOUT			(HZ/2)
 
-#define SSP_VERSION_LATEST	4
-#define ssp_is_old(host)	(host->version < SSP_VERSION_LATEST)
+#define ssp_is_old(host)	(host->devid == IMX23_MMC)
 
 /* SSP registers */
 #define HW_SSP_CTRL0				0x000
@@ -123,8 +121,6 @@
 #define HW_SSP_STATUS(h)			(ssp_is_old(h) ? 0x0c0 : 0x100)
 #define  BM_SSP_STATUS_CARD_DETECT		(1 << 28)
 #define  BM_SSP_STATUS_SDIO_IRQ			(1 << 17)
-#define HW_SSP_VERSION				(cpu_is_mx23() ? 0x110 : 0x130)
-#define  BP_SSP_VERSION_MAJOR			(24)
 
 #define BF_SSP(value, field)	(((value) << BP_SSP_##field) & BM_SSP_##field)
 
@@ -139,6 +135,11 @@
 
 #define SSP_PIO_NUM	3
 
+enum mxs_mmc_id {
+	IMX23_MMC,
+	IMX28_MMC,
+};
+
 struct mxs_mmc_host {
 	struct mmc_host			*mmc;
 	struct mmc_request		*mrq;
@@ -158,7 +159,7 @@ struct mxs_mmc_host {
 	enum dma_transfer_direction	slave_dirn;
 	u32				ssp_pio_words[SSP_PIO_NUM];
 
-	unsigned int			version;
+	enum mxs_mmc_id			devid;
 	unsigned char			bus_width;
 	spinlock_t			lock;
 	int				sdio_irq_en;
@@ -678,6 +679,19 @@ static bool mxs_mmc_dma_filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
+static struct platform_device_id mxs_mmc_ids[] = {
+	{
+		.name = "imx23-mmc",
+		.driver_data = IMX23_MMC,
+	}, {
+		.name = "imx28-mmc",
+		.driver_data = IMX28_MMC,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, mxs_mmc_ids);
+
 static int mxs_mmc_probe(struct platform_device *pdev)
 {
 	struct mxs_mmc_host *host;
@@ -712,10 +726,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		goto out_mmc_free;
 	}
 
-	/* only major verion does matter */
-	host->version = readl(host->base + HW_SSP_VERSION) >>
-			BP_SSP_VERSION_MAJOR;
-
+	host->devid = pdev->id_entry->driver_data;
 	host->mmc = mmc;
 	host->res = r;
 	host->dma_res = dmares;
@@ -866,6 +877,7 @@ static const struct dev_pm_ops mxs_mmc_pm_ops = {
 static struct platform_driver mxs_mmc_driver = {
 	.probe		= mxs_mmc_probe,
 	.remove		= mxs_mmc_remove,
+	.id_table	= mxs_mmc_ids,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
-- 
1.7.5.4

