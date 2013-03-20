From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v6 3/5] mmc: davinci_mmc: add DT support
Date: Wed, 20 Mar 2013 17:14:10 +0530
Message-ID: <1363779852-24083-4-git-send-email-prakash.pm@ti.com>
References: <1363779852-24083-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35407 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465Ab3CTLom (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Mar 2013 07:44:42 -0400
In-Reply-To: <1363779852-24083-1-git-send-email-prakash.pm@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>, mporter@ti.com

Adds device tree support for davinci_mmc. Also add binding documentation.
As of now in non-dma PIO mode and without GPIO card_detect/write_protect
option because of dependencies on EDMA and GPIO module DT support.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Sekhar Nori <nsekhar@ti.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: davinci-linux-open-source@linux.davincidsp.com
Cc: devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: mporter@ti.com
---
Since v4:
Minor nit, check on return value for failure of max-frequency property
parsing.

Since v2:
Modified the default value for bus-width and skipping the property specifications for highspeed card capabilties for now. Re-ordered patch 2 and 3.

Since v1:
Modified the DT parse function to take default values, updated DT binding documentation accordingly.
 .../devicetree/bindings/mmc/davinci_mmc.txt        |   25 ++++++++
 drivers/mmc/host/davinci_mmc.c                     |   64 +++++++++++++++++++-
 2 files changed, 87 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
new file mode 100644
index 0000000..c4413f7
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
+ Should be "ti,da830-mmc": for da830, da850, dm365
+ Should be "ti,dm355-mmc": for dm355, dm644x
+
+Optional properties:
+- bus-width: Number of data lines, can be <1>, <4>, or <8>, default <1>
+- max-frequency: Maximum operating clock frequency, default 25MHz.
+
+Example:
+	mmc0: mmc@1c40000 {
+		compatible = "ti,da830-mmc",
+		reg = <0x40000 0x1000>;
+		interrupts = <16>;
+		status = "okay";
+		bus-width = <4>;
+		max-frequency = <50000000>;
+	};
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 7d0e684..8aada43 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -34,6 +34,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/edma.h>
 #include <linux/mmc/mmc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/mmc-davinci.h>
@@ -1170,9 +1172,62 @@ static struct platform_device_id davinci_mmc_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, davinci_mmc_devtype);
 
-static int __init davinci_mmcsd_probe(struct platform_device *pdev)
+static const struct of_device_id davinci_mmc_dt_ids[] = {
+	{
+		.compatible = "ti,dm6441-mmc",
+		.data = &davinci_mmc_devtype[MMC_CTLR_VERSION_1],
+	},
+	{
+		.compatible = "ti,da830-mmc",
+		.data = &davinci_mmc_devtype[MMC_CTLR_VERSION_2],
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
+	if (match)
+		pdev->id_entry = match->data;
+
+	if (of_property_read_u32(np, "max-frequency", &pdata->max_freq))
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
@@ -1180,7 +1235,11 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	size_t mem_size;
 	const struct platform_device_id *id_entry;
 
-	/* REVISIT:  when we're fully converted, fail if pdata is NULL */
+	pdata = mmc_parse_pdata(pdev);
+	if (pdata == NULL) {
+		dev_err(&pdev->dev, "Couldn't get platform data\n");
+		return -ENOENT;
+	}
 
 	ret = -ENODEV;
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1424,6 +1483,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.name	= "davinci_mmc",
 		.owner	= THIS_MODULE,
 		.pm	= davinci_mmcsd_pm_ops,
+		.of_match_table = of_match_ptr(davinci_mmc_dt_ids),
 	},
 	.remove		= __exit_p(davinci_mmcsd_remove),
 	.id_table	= davinci_mmc_devtype,
-- 
1.7.4.1

