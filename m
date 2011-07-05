From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/3] mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
Date: Tue, 5 Jul 2011 23:26:06 +0800
Message-ID: <1309879568-25837-2-git-send-email-shawn.guo@linaro.org>
References: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:38621
	"EHLO CH1EHSOBE012.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754214Ab1GEPT6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 11:19:58 -0400
In-Reply-To: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>

The patch removes all the uses of cpu_is_mx().  Instead, it utilizes
platform_device_id to distinguish the esdhc differences among SoCs.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>
---
 arch/arm/mach-imx/clock-imx25.c                    |    4 +-
 arch/arm/mach-imx/clock-imx35.c                    |    6 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   16 +++---
 arch/arm/mach-mx5/mx51_efika.c                     |    4 +-
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   17 +++---
 arch/arm/plat-mxc/include/mach/devices-common.h    |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   60 ++++++++++++++++++-
 7 files changed, 81 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index a65838f..2955afa 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -300,8 +300,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdt_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx25.0", NULL, esdhc1_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx25.1", NULL, esdhc2_clk)
 	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
 	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index 5a4cc1e..2f80f14 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -458,9 +458,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx-epit.0", NULL, epit1_clk)
 	_REGISTER_CLOCK("imx-epit.1", NULL, epit2_clk)
 	_REGISTER_CLOCK(NULL, "esai", esai_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx35.0", NULL, esdhc1_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx35.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx35.2", NULL, esdhc3_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK(NULL, "gpio", gpio1_clk)
 	_REGISTER_CLOCK(NULL, "gpio", gpio2_clk)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 699b0d2..fd60e2c 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1453,10 +1453,10 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx51.0", NULL, esdhc1_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx51.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx51.2", NULL, esdhc3_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx51.3", NULL, esdhc4_clk)
 	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
 	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
@@ -1480,10 +1480,10 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
 	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_mx53_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_mx53_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_mx53_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_mx53_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx53.0", NULL, esdhc1_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx53.1", NULL, esdhc2_mx53_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx53.2", NULL, esdhc3_mx53_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx53.3", NULL, esdhc4_mx53_clk)
 	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index 56739c2..4435e03 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -260,8 +260,8 @@ static struct regulator_consumer_supply vvideo_consumers[] = {
 };
 
 static struct regulator_consumer_supply vsd_consumers[] = {
-	REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx.0"),
-	REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx.1"),
+	REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx51.0"),
+	REGULATOR_SUPPLY("vmmc", "sdhci-esdhc-imx51.1"),
 };
 
 static struct regulator_consumer_supply pwgt1_consumer[] = {
diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
index 79d6d71..5955f5d 100644
--- a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
+++ b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
@@ -10,21 +10,22 @@
 #include <mach/devices-common.h>
 #include <mach/esdhc.h>
 
-#define imx_sdhci_esdhc_imx_data_entry_single(soc, _id, hwid) \
+#define imx_sdhci_esdhc_imx_data_entry_single(soc, _devid, _id, hwid) \
 	{								\
+		.devid = _devid,					\
 		.id = _id,						\
 		.iobase = soc ## _ESDHC ## hwid ## _BASE_ADDR,	\
 		.irq = soc ## _INT_ESDHC ## hwid,			\
 	}
 
-#define imx_sdhci_esdhc_imx_data_entry(soc, id, hwid)	\
-	[id] = imx_sdhci_esdhc_imx_data_entry_single(soc, id, hwid)
+#define imx_sdhci_esdhc_imx_data_entry(soc, devid, id, hwid)	\
+	[id] = imx_sdhci_esdhc_imx_data_entry_single(soc, devid, id, hwid)
 
 #ifdef CONFIG_SOC_IMX25
 const struct imx_sdhci_esdhc_imx_data
 imx25_sdhci_esdhc_imx_data[] __initconst = {
 #define imx25_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
-	imx_sdhci_esdhc_imx_data_entry(MX25, _id, _hwid)
+	imx_sdhci_esdhc_imx_data_entry(MX25, "sdhci-esdhc-imx25", _id, _hwid)
 	imx25_sdhci_esdhc_imx_data_entry(0, 1),
 	imx25_sdhci_esdhc_imx_data_entry(1, 2),
 };
@@ -34,7 +35,7 @@ imx25_sdhci_esdhc_imx_data[] __initconst = {
 const struct imx_sdhci_esdhc_imx_data
 imx35_sdhci_esdhc_imx_data[] __initconst = {
 #define imx35_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
-	imx_sdhci_esdhc_imx_data_entry(MX35, _id, _hwid)
+	imx_sdhci_esdhc_imx_data_entry(MX35, "sdhci-esdhc-imx35", _id, _hwid)
 	imx35_sdhci_esdhc_imx_data_entry(0, 1),
 	imx35_sdhci_esdhc_imx_data_entry(1, 2),
 	imx35_sdhci_esdhc_imx_data_entry(2, 3),
@@ -45,7 +46,7 @@ imx35_sdhci_esdhc_imx_data[] __initconst = {
 const struct imx_sdhci_esdhc_imx_data
 imx51_sdhci_esdhc_imx_data[] __initconst = {
 #define imx51_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
-	imx_sdhci_esdhc_imx_data_entry(MX51, _id, _hwid)
+	imx_sdhci_esdhc_imx_data_entry(MX51, "sdhci-esdhc-imx51", _id, _hwid)
 	imx51_sdhci_esdhc_imx_data_entry(0, 1),
 	imx51_sdhci_esdhc_imx_data_entry(1, 2),
 	imx51_sdhci_esdhc_imx_data_entry(2, 3),
@@ -57,7 +58,7 @@ imx51_sdhci_esdhc_imx_data[] __initconst = {
 const struct imx_sdhci_esdhc_imx_data
 imx53_sdhci_esdhc_imx_data[] __initconst = {
 #define imx53_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
-	imx_sdhci_esdhc_imx_data_entry(MX53, _id, _hwid)
+	imx_sdhci_esdhc_imx_data_entry(MX53, "sdhci-esdhc-imx53", _id, _hwid)
 	imx53_sdhci_esdhc_imx_data_entry(0, 1),
 	imx53_sdhci_esdhc_imx_data_entry(1, 2),
 	imx53_sdhci_esdhc_imx_data_entry(2, 3),
@@ -93,6 +94,6 @@ struct platform_device *__init imx_add_sdhci_esdhc_imx(
 	if (!pdata)
 		pdata = &default_esdhc_pdata;
 
-	return imx_add_platform_device("sdhci-esdhc-imx", data->id, res,
+	return imx_add_platform_device(data->devid, data->id, res,
 			ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index bf93820..c9e7b66 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -276,6 +276,7 @@ struct platform_device *__init imx_add_mxc_w1(
 
 #include <mach/esdhc.h>
 struct imx_sdhci_esdhc_imx_data {
+	const char *devid;
 	int id;
 	resource_size_t iobase;
 	resource_size_t irq;
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 3cc6f61..1edda29 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -20,7 +20,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
-#include <mach/hardware.h>
 #include <mach/esdhc.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -42,11 +41,57 @@
  */
 #define ESDHC_FLAG_MULTIBLK_NO_INT	(1 << 1)
 
+enum imx_esdhc_type {
+	IMX25_ESDHC,
+	IMX35_ESDHC,
+	IMX51_ESDHC,
+	IMX53_ESDHC,
+};
+
 struct pltfm_imx_data {
 	int flags;
 	u32 scratchpad;
+	enum imx_esdhc_type devtype;
+};
+
+static struct platform_device_id imx_esdhc_devtype[] = {
+	{
+		.name = "sdhci-esdhc-imx25",
+		.driver_data = IMX25_ESDHC,
+	}, {
+		.name = "sdhci-esdhc-imx35",
+		.driver_data = IMX35_ESDHC,
+	}, {
+		.name = "sdhci-esdhc-imx51",
+		.driver_data = IMX51_ESDHC,
+	}, {
+		.name = "sdhci-esdhc-imx53",
+		.driver_data = IMX53_ESDHC,
+	}, {
+		/* sentinel */
+	}
 };
 
+static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
+{
+	return data->devtype == IMX25_ESDHC;
+}
+
+static inline int is_imx35_esdhc(struct pltfm_imx_data *data)
+{
+	return data->devtype == IMX35_ESDHC;
+}
+
+static inline int is_imx51_esdhc(struct pltfm_imx_data *data)
+{
+	return data->devtype == IMX51_ESDHC;
+}
+
+static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
+{
+	return data->devtype == IMX53_ESDHC;
+}
+
 static unsigned int esdhc_pltfm_get_max_blk_size(struct sdhci_host *host)
 {
 	/* Force 2048 bytes, which is the maximum supported size in SDHCI. */
@@ -55,8 +100,12 @@ static unsigned int esdhc_pltfm_get_max_blk_size(struct sdhci_host *host)
 
 static unsigned int esdhc_pltfm_get_max_blk_count(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+
 	/* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
-	return (cpu_is_mx25() || cpu_is_mx35()) ? 1 : 65535;
+	return (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data)) ?
+		1 : 65535;
 }
 
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
@@ -274,6 +323,8 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
 	if (!imx_data)
 		return -ENOMEM;
+
+	imx_data->devtype = pdev->id_entry->driver_data;
 	pltfm_host->priv = imx_data;
 
 	clk = clk_get(mmc_dev(host->mmc), NULL);
@@ -285,10 +336,10 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
-	if (!cpu_is_mx25())
+	if (!is_imx25_esdhc(imx_data))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	if (!(cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()))
+	if (is_imx53_esdhc(imx_data))
 		imx_data->flags |= ESDHC_FLAG_MULTIBLK_NO_INT;
 
 	boarddata = host->mmc->parent->platform_data;
@@ -401,6 +452,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
 		.name	= "sdhci-esdhc-imx",
 		.owner	= THIS_MODULE,
 	},
+	.id_table	= imx_esdhc_devtype,
 	.probe		= sdhci_esdhc_imx_probe,
 	.remove		= __devexit_p(sdhci_esdhc_imx_remove),
 #ifdef CONFIG_PM
-- 
1.7.4.1


