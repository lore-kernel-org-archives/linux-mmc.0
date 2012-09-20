From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 28/34] mmc: mxcmmc: remove cpu_is_xxx by using platform_device_id
Date: Thu, 20 Sep 2012 14:45:41 +0800
Message-ID: <1348123547-31082-29-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49998 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2ITGrr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 02:47:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so4370522pbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Sep 2012 23:47:47 -0700 (PDT)
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org

It changes the driver to use platform_device_id rather than cpu_is_xxx
to determine the controller type, and updates the platform code
accordingly.

As the result, mach/hardware.h inclusion gets removed from the driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Chris Ball <cjb@laptop.org>
Tested-by: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-mmc@vger.kernel.org
---
 arch/arm/mach-imx/clk-imx27.c                |   12 +++++-----
 arch/arm/mach-imx/clk-imx31.c                |    4 ++--
 arch/arm/mach-imx/devices/devices-common.h   |    1 +
 arch/arm/mach-imx/devices/platform-mxc-mmc.c |   15 +++++++------
 arch/arm/mach-imx/mach-mx31_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-mx31moboard.c         |    4 ++--
 arch/arm/mach-imx/mach-pcm038.c              |    2 +-
 drivers/mmc/host/mxcmmc.c                    |   31 ++++++++++++++++++++++++--
 8 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index f4ec05e..71c3f12 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -212,12 +212,12 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[gpt6_ipg_gate], "ipg", "imx-gpt.5");
 	clk_register_clkdev(clk[per1_gate], "per", "imx-gpt.5");
 	clk_register_clkdev(clk[pwm_ipg_gate], NULL, "mxc_pwm.0");
-	clk_register_clkdev(clk[per2_gate], "per", "mxc-mmc.0");
-	clk_register_clkdev(clk[sdhc1_ipg_gate], "ipg", "mxc-mmc.0");
-	clk_register_clkdev(clk[per2_gate], "per", "mxc-mmc.1");
-	clk_register_clkdev(clk[sdhc2_ipg_gate], "ipg", "mxc-mmc.1");
-	clk_register_clkdev(clk[per2_gate], "per", "mxc-mmc.2");
-	clk_register_clkdev(clk[sdhc2_ipg_gate], "ipg", "mxc-mmc.2");
+	clk_register_clkdev(clk[per2_gate], "per", "imx21-mmc.0");
+	clk_register_clkdev(clk[sdhc1_ipg_gate], "ipg", "imx21-mmc.0");
+	clk_register_clkdev(clk[per2_gate], "per", "imx21-mmc.1");
+	clk_register_clkdev(clk[sdhc2_ipg_gate], "ipg", "imx21-mmc.1");
+	clk_register_clkdev(clk[per2_gate], "per", "imx21-mmc.2");
+	clk_register_clkdev(clk[sdhc2_ipg_gate], "ipg", "imx21-mmc.2");
 	clk_register_clkdev(clk[cspi1_ipg_gate], NULL, "imx27-cspi.0");
 	clk_register_clkdev(clk[cspi2_ipg_gate], NULL, "imx27-cspi.1");
 	clk_register_clkdev(clk[cspi3_ipg_gate], NULL, "imx27-cspi.2");
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index d9ff16e..1277f73 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -159,8 +159,8 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[i2c2_gate], NULL, "imx21-i2c.1");
 	clk_register_clkdev(clk[i2c3_gate], NULL, "imx21-i2c.2");
 	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1.0");
-	clk_register_clkdev(clk[sdhc1_gate], NULL, "mxc-mmc.0");
-	clk_register_clkdev(clk[sdhc2_gate], NULL, "mxc-mmc.1");
+	clk_register_clkdev(clk[sdhc1_gate], NULL, "imx31-mmc.0");
+	clk_register_clkdev(clk[sdhc2_gate], NULL, "imx31-mmc.1");
 	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");
 	clk_register_clkdev(clk[ssi2_gate], NULL, "imx-ssi.1");
 	clk_register_clkdev(clk[firi_gate], "firi", NULL);
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 8112a1a..7fa3ef7 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -228,6 +228,7 @@ struct platform_device *__init imx_add_mxc_ehci(
 
 #include <linux/platform_data/mmc-mxcmmc.h>
 struct imx_mxc_mmc_data {
+	const char *devid;
 	int id;
 	resource_size_t iobase;
 	resource_size_t iosize;
diff --git a/arch/arm/mach-imx/devices/platform-mxc-mmc.c b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
index ce90ab0..487f61c 100644
--- a/arch/arm/mach-imx/devices/platform-mxc-mmc.c
+++ b/arch/arm/mach-imx/devices/platform-mxc-mmc.c
@@ -10,21 +10,22 @@
 #include <mach/hardware.h>
 #include "devices-common.h"
 
-#define imx_mxc_mmc_data_entry_single(soc, _id, _hwid, _size)		\
+#define imx_mxc_mmc_data_entry_single(soc, _devid, _id, _hwid, _size)	\
 	{								\
+		.devid = _devid,					\
 		.id = _id,						\
 		.iobase = soc ## _SDHC ## _hwid ## _BASE_ADDR,		\
 		.iosize = _size,					\
 		.irq = soc ## _INT_SDHC ## _hwid,			\
 		.dmareq = soc ## _DMA_REQ_SDHC ## _hwid,		\
 	}
-#define imx_mxc_mmc_data_entry(soc, _id, _hwid, _size)			\
-	[_id] = imx_mxc_mmc_data_entry_single(soc, _id, _hwid, _size)
+#define imx_mxc_mmc_data_entry(soc, _devid, _id, _hwid, _size)		\
+	[_id] = imx_mxc_mmc_data_entry_single(soc, _devid, _id, _hwid, _size)
 
 #ifdef CONFIG_SOC_IMX21
 const struct imx_mxc_mmc_data imx21_mxc_mmc_data[] __initconst = {
 #define imx21_mxc_mmc_data_entry(_id, _hwid)				\
-	imx_mxc_mmc_data_entry(MX21, _id, _hwid, SZ_4K)
+	imx_mxc_mmc_data_entry(MX21, "imx21-mmc", _id, _hwid, SZ_4K)
 	imx21_mxc_mmc_data_entry(0, 1),
 	imx21_mxc_mmc_data_entry(1, 2),
 };
@@ -33,7 +34,7 @@ const struct imx_mxc_mmc_data imx21_mxc_mmc_data[] __initconst = {
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_mmc_data imx27_mxc_mmc_data[] __initconst = {
 #define imx27_mxc_mmc_data_entry(_id, _hwid)				\
-	imx_mxc_mmc_data_entry(MX27, _id, _hwid, SZ_4K)
+	imx_mxc_mmc_data_entry(MX27, "imx21-mmc", _id, _hwid, SZ_4K)
 	imx27_mxc_mmc_data_entry(0, 1),
 	imx27_mxc_mmc_data_entry(1, 2),
 };
@@ -42,7 +43,7 @@ const struct imx_mxc_mmc_data imx27_mxc_mmc_data[] __initconst = {
 #ifdef CONFIG_SOC_IMX31
 const struct imx_mxc_mmc_data imx31_mxc_mmc_data[] __initconst = {
 #define imx31_mxc_mmc_data_entry(_id, _hwid)				\
-	imx_mxc_mmc_data_entry(MX31, _id, _hwid, SZ_16K)
+	imx_mxc_mmc_data_entry(MX31, "imx31-mmc", _id, _hwid, SZ_16K)
 	imx31_mxc_mmc_data_entry(0, 1),
 	imx31_mxc_mmc_data_entry(1, 2),
 };
@@ -67,7 +68,7 @@ struct platform_device *__init imx_add_mxc_mmc(
 			.flags = IORESOURCE_DMA,
 		},
 	};
-	return imx_add_platform_device_dmamask("mxc-mmc", data->id,
+	return imx_add_platform_device_dmamask(data->devid, data->id,
 			res, ARRAY_SIZE(res),
 			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
 }
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 5377c88..0333567 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -393,7 +393,7 @@ static struct regulator_init_data gpo_init = {
 };
 
 static struct regulator_consumer_supply vmmc2_consumers[] = {
-	REGULATOR_SUPPLY("vmmc", "mxc-mmc.0"),
+	REGULATOR_SUPPLY("vmmc", "imx31-mmc.0"),
 };
 
 static struct regulator_init_data vmmc2_init = {
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index e719c76..31c7d05 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -175,11 +175,11 @@ static const struct spi_imx_master moboard_spi1_pdata __initconst = {
 
 static struct regulator_consumer_supply sdhc_consumers[] = {
 	{
-		.dev_name = "mxc-mmc.0",
+		.dev_name = "imx31-mmc.0",
 		.supply	= "sdhc0_vcc",
 	},
 	{
-		.dev_name = "mxc-mmc.1",
+		.dev_name = "imx31-mmc.1",
 		.supply	= "sdhc1_vcc",
 	},
 };
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 4a52340..8bf95f5 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -212,7 +212,7 @@ static const struct spi_imx_master pcm038_spi0_data __initconst = {
 
 static struct regulator_consumer_supply sdhc1_consumers[] = {
 	{
-		.dev_name = "mxc-mmc.1",
+		.dev_name = "imx21-mmc.1",
 		.supply	= "sdhc_vcc",
 	},
 };
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 7b1161d..15010b3 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -41,7 +41,6 @@
 #include <linux/platform_data/mmc-mxcmmc.h>
 
 #include <linux/platform_data/dma-imx.h>
-#include <mach/hardware.h>
 
 #define DRIVER_NAME "mxc-mmc"
 
@@ -112,6 +111,11 @@
 #define INT_WRITE_OP_DONE_EN		(1 << 1)
 #define INT_READ_OP_EN			(1 << 0)
 
+enum mxcmci_type {
+	IMX21_MMC,
+	IMX31_MMC,
+};
+
 struct mxcmci_host {
 	struct mmc_host		*mmc;
 	struct resource		*res;
@@ -150,7 +154,26 @@ struct mxcmci_host {
 	int			dmareq;
 	struct dma_slave_config dma_slave_config;
 	struct imx_dma_data	dma_data;
+	enum mxcmci_type	devtype;
+};
+
+static struct platform_device_id mxcmci_devtype[] = {
+	{
+		.name = "imx21-mmc",
+		.driver_data = IMX21_MMC,
+	}, {
+		.name = "imx31-mmc",
+		.driver_data = IMX31_MMC,
+	}, {
+		/* sentinel */
+	}
 };
+MODULE_DEVICE_TABLE(platform, mxcmci_devtype);
+
+static inline int is_imx31_mmc(struct mxcmci_host *host)
+{
+	return host->devtype == IMX31_MMC;
+}
 
 static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
 
@@ -811,6 +834,8 @@ static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 static void mxcmci_init_card(struct mmc_host *host, struct mmc_card *card)
 {
+	struct mxcmci_host *mxcmci = mmc_priv(host);
+
 	/*
 	 * MX3 SoCs have a silicon bug which corrupts CRC calculation of
 	 * multi-block transfers when connected SDIO peripheral doesn't
@@ -818,7 +843,7 @@ static void mxcmci_init_card(struct mmc_host *host, struct mmc_card *card)
 	 * One way to prevent this is to only allow 1-bit transfers.
 	 */
 
-	if (cpu_is_mx3() && card->type == MMC_TYPE_SDIO)
+	if (is_imx31_mmc(mxcmci) && card->type == MMC_TYPE_SDIO)
 		host->caps &= ~MMC_CAP_4_BIT_DATA;
 	else
 		host->caps |= MMC_CAP_4_BIT_DATA;
@@ -888,6 +913,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	host->mmc = mmc;
 	host->pdata = pdev->dev.platform_data;
+	host->devtype = pdev->id_entry->driver_data;
 	spin_lock_init(&host->lock);
 
 	mxcmci_init_ocr(host);
@@ -1056,6 +1082,7 @@ static const struct dev_pm_ops mxcmci_pm_ops = {
 static struct platform_driver mxcmci_driver = {
 	.probe		= mxcmci_probe,
 	.remove		= mxcmci_remove,
+	.id_table	= mxcmci_devtype,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.owner		= THIS_MODULE,
-- 
1.7.9.5

