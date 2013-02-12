From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v3 1/3] mmc: davinci_mmc: add DT support
Date: Tue, 12 Feb 2013 12:07:36 +0530
Message-ID: <1360651058-5255-2-git-send-email-prakash.pm@ti.com>
References: <1360651058-5255-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38772 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab3BLGgk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Feb 2013 01:36:40 -0500
In-Reply-To: <1360651058-5255-1-git-send-email-prakash.pm@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, nsekhar@ti.com, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com, "Manjunathappa, Prakash" <prakash.pm@ti.com>, mporter@ti.com

Adds device tree support for davinci_mmc. Also add binding documentation.
As of now in non-dma PIO mode and without GPIO card_detect/write_protect
option because of dependencies on EDMA and GPIO module DT support.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: davinci-linux-open-source@linux.davincidsp.com
Cc: devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: mporter@ti.com
---
Since v2:
Modified the default value for bus-width and removed the support for
highspeed card capabilties for now.
Since v1:
Modified DT parse function to take default values and accomodate controller
version in compatible field.

 .../devicetree/bindings/mmc/davinci_mmc.txt        |   25 ++++++++
 drivers/mmc/host/davinci_mmc.c                     |   65 +++++++++++++++++++-
 2 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
new file mode 100644
index 0000000..247be0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
@@ -0,0 +1,25 @@
+* TI Highspeed MMC host controller for DaVinci
+
+The Highspeed MMC Host Controller on TI DaVinci family
+provides an interface for MMC, SD and SDIO types of memory cards.
+
+This file documents the properties used by the davinci_mmc driver.
+
+Required properties:
+- compatible:
+ Should be "ti,davinci-mmc-da830": for da830, da850, dm365
+ Should be "ti,davinci-mmc-dm355": for dm355, dm644x
+
+Optional properties:
+- bus-width: Number of data lines, can be <1>, <4>, or <8>, default <1>
+- max-frequency: Maximum operating clock frequency, default 25MHz.
+
+Example:
+	mmc0: mmc@1c40000 {
+		compatible = "ti,davinci-mmc-da830",
+		reg = <0x40000 0x1000>;
+		interrupts = <16>;
+		status = "okay";
+		bus-width = <4>;
+		max-frequency = <50000000>;
+	};
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 27123f8..66ca6bf 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -34,6 +34,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/edma.h>
 #include <linux/mmc/mmc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/platform_data/mmc-davinci.h>
 
@@ -1157,16 +1159,74 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
 	mmc_davinci_reset_ctrl(host, 0);
 }
 
-static int __init davinci_mmcsd_probe(struct platform_device *pdev)
+static const struct of_device_id davinci_mmc_dt_ids[] = {
+	{
+		.compatible = "ti,davinci-mmc-dm355",
+		.data = (void *)MMC_CTLR_VERSION_1,
+	},
+	{
+		.compatible = "ti,davinci-mmc-da830",
+		.data = (void *)MMC_CTLR_VERSION_2,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, davinci_mmc_dt_ids);
+
+static struct davinci_mmc_config
+	*mmc_parse_pdata(struct platform_device *pdev)
 {
+	struct device_node *np;
 	struct davinci_mmc_config *pdata = pdev->dev.platform_data;
+	const struct of_device_id *match =
+		of_match_device(of_match_ptr(davinci_mmc_dt_ids), &pdev->dev);
+	u32 data;
+
+	np = pdev->dev.of_node;
+	if (!np)
+		return pdata;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(&pdev->dev, "Failed to allocate memory for struct davinci_mmc_config\n");
+		goto nodata;
+	}
+
+	if (match->data)
+		pdata->version = (u8)((int)match->data);
+
+	of_property_read_u32(np, "max-frequency", &pdata->max_freq);
+	if (!pdata->max_freq)
+		dev_info(&pdev->dev, "'max-frequency' property not specified, defaulting to 25MHz\n");
+
+	of_property_read_u32(np, "bus-width", &data);
+	switch (data) {
+	case 1:
+	case 4:
+	case 8:
+		pdata->wires = data;
+		break;
+	default:
+		pdata->wires = 1;
+		dev_info(&pdev->dev, "Unsupported buswidth, defaulting to 1 bit\n");
+	}
+nodata:
+	return pdata;
+}
+
+static int __init davinci_mmcsd_probe(struct platform_device *pdev)
+{
+	struct davinci_mmc_config *pdata = NULL;
 	struct mmc_davinci_host *host = NULL;
 	struct mmc_host *mmc = NULL;
 	struct resource *r, *mem = NULL;
 	int ret = 0, irq = 0;
 	size_t mem_size;
 
-	/* REVISIT:  when we're fully converted, fail if pdata is NULL */
+	pdata = mmc_parse_pdata(pdev);
+	if (pdata == NULL) {
+		dev_err(&pdev->dev, "Can not get platform data\n");
+		return -ENOENT;
+	}
 
 	ret = -ENODEV;
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1408,6 +1468,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.name	= "davinci_mmc",
 		.owner	= THIS_MODULE,
 		.pm	= davinci_mmcsd_pm_ops,
+		.of_match_table = of_match_ptr(davinci_mmc_dt_ids),
 	},
 	.remove		= __exit_p(davinci_mmcsd_remove),
 };
-- 
1.7.4.1

