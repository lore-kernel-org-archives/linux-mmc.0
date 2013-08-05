From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] mmc: sh_mmcif: revision-specific configuration from
 Device Tree
Date: Mon, 5 Aug 2013 16:11:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1308051514350.22479@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add compatibility strings to configure MMCIF revision-specific features.
MMCIF blocks are always integrated into SoCs, so, we use SoC model to
distinguish between MMCIF versions.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

Hi Chris,
I marked this as RFC, because having no access to the MMC standard I'm not 
certain about VccQ requirements for MMC DDR. On the one hand a comment in 
mmc.c says
	 * EXT_CSD_CARD_TYPE_DDR_1_8V means 3.3V or 1.8V vccq.
which suggests, that DDR (DDR50?) can be used with VccQ = 3.3V, 1.8V and 
1.2V at least. But in mmc_init_card() DDR50 is only requested from the 
driver if either MMC_CAP_1_8V_DDR or MMC_CAP_1_2V_DDR is specified in 
host's capabilities. So, I'm actually not sure whether MMC_CAP_UHS_DDR50 
alone without 1_8V or 1_2V makes sense. That's also what I implemented in 
this patch - DDR50 is only enabled in combination with either 1.2 or 1.8V 
capability. Is this correct?

 Documentation/devicetree/bindings/mmc/sh_mmcif.txt |   15 ++++
 drivers/mmc/host/sh_mmcif.c                        |   68 +++++++++++++++++--
 2 files changed, 75 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sh_mmcif.txt

diff --git a/Documentation/devicetree/bindings/mmc/sh_mmcif.txt b/Documentation/devicetree/bindings/mmc/sh_mmcif.txt
new file mode 100644
index 0000000..a0e7fee
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sh_mmcif.txt
@@ -0,0 +1,15 @@
+* Renesas MMCIF MMC controller
+
+The MMCIF driver uses the standard mmc DT parser to evaluate all standard MMC DT
+properties. Additionally the following properties must or can be used:
+
+Compulsory properties:
+- compatible:	must be one of
+		"renesas,sh-mmcif" for generic MMCIF blocks
+		"renesas,sh-mmcif-r8a73a4" for MMCIF on R8A73A4 (APE6)
+		"renesas,sh-mmcif-r8a7740" for MMCIF on R8A7740 (A1)
+		"renesas,sh-mmcif-r8a7790" for MMCIF on R8A7790 (H2)
+		"renesas,sh-mmcif-sh73a0" for MMCIF on SH73A0 (AG5)
+		"renesas,sh-mmcif-sh7372" for MMCIF on SH7372 (AP4)
+
+Further, any standard MMC DT properties from mmc.txt can be used.
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 444f83b..a4bd784 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -57,6 +57,7 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
@@ -257,6 +258,39 @@ struct sh_mmcif_host {
 	bool			dma_active;
 };
 
+struct sh_mmcif_of_data {
+	unsigned int	ccs_enable : 1;
+	unsigned int	clk_ctrl2_enable : 1;
+	unsigned int	uhs_ddr_1v8 : 1;
+	unsigned int	uhs_ddr_1v2 : 1;
+};
+
+enum {
+	R8A73A4,
+	R8A7740,
+	R8A7790,
+	SH7372,
+	SH73A0,
+};
+
+static const struct sh_mmcif_of_data sh_mmcif_of_cfg[] = {
+	[R8A73A4] = {
+		.uhs_ddr_1v8 = 1,
+	},
+	[R8A7740] = {
+		/* all disabled */
+	},
+	[R8A7790] = {
+		.clk_ctrl2_enable = 1,
+	},
+	[SH73A0] = {
+		.uhs_ddr_1v8 = 1,
+	},
+	[SH7372] = {
+		.ccs_enable = 1,
+	},
+};
+
 static inline void sh_mmcif_bitset(struct sh_mmcif_host *host,
 					unsigned int reg, u32 val)
 {
@@ -1362,8 +1396,21 @@ static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
 		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
 }
 
+static const struct of_device_id mmcif_of_match[] = {
+	{.compatible = "renesas,sh-mmcif"},
+	{.compatible = "renesas,sh-mmcif-r8a73a4", .data = &sh_mmcif_of_cfg[R8A73A4]},
+	{.compatible = "renesas,sh-mmcif-r8a7740", .data = &sh_mmcif_of_cfg[R8A7740]},
+	{.compatible = "renesas,sh-mmcif-r8a7790", .data = &sh_mmcif_of_cfg[R8A7790]},
+	{.compatible = "renesas,sh-mmcif-sh73a0", .data = &sh_mmcif_of_cfg[SH73A0]},
+	{.compatible = "renesas,sh-mmcif-sh7372", .data = &sh_mmcif_of_cfg[SH7372]},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mmcif_of_match);
+
 static int sh_mmcif_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id =
+		of_match_device(mmcif_of_match, &pdev->dev);
 	int ret = 0, irq[2];
 	struct mmc_host *mmc;
 	struct sh_mmcif_host *host;
@@ -1403,8 +1450,19 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	host->mmc	= mmc;
 	host->addr	= reg;
 	host->timeout	= msecs_to_jiffies(1000);
-	host->ccs_enable = !pd || !pd->ccs_unsupported;
-	host->clk_ctrl2_enable = pd && pd->clk_ctrl2_present;
+
+	if (of_id && of_id->data) {
+		const struct sh_mmcif_of_data *of_data = of_id->data;
+		host->ccs_enable = of_data->ccs_enable;
+		host->clk_ctrl2_enable = of_data->clk_ctrl2_enable;
+		if (of_data->uhs_ddr_1v8)
+			mmc->caps |= MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR;
+		if (of_data->uhs_ddr_1v2)
+			mmc->caps |= MMC_CAP_UHS_DDR50 | MMC_CAP_1_2V_DDR;
+	} else {
+		host->ccs_enable = !pd || !pd->ccs_unsupported;
+		host->clk_ctrl2_enable = pd && pd->clk_ctrl2_present;
+	}
 
 	host->pd = pdev;
 
@@ -1564,12 +1622,6 @@ static int sh_mmcif_resume(struct device *dev)
 #define sh_mmcif_resume		NULL
 #endif	/* CONFIG_PM */
 
-static const struct of_device_id mmcif_of_match[] = {
-	{ .compatible = "renesas,sh-mmcif" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, mmcif_of_match);
-
 static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
 	.suspend = sh_mmcif_suspend,
 	.resume = sh_mmcif_resume,
-- 
1.7.2.5

