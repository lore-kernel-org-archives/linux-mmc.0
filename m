From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v7 3/5] mmc: davinci_mmc: add DT support
Date: Thu, 28 Mar 2013 18:42:00 +0530
Message-ID: <1364476322-15882-4-git-send-email-prakash.pm@ti.com>
References: <1364476322-15882-3-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1364476322-15882-3-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, arnd@arndb.de, "Manjunathappa, Prakash" <prakash.pm@ti.com>, mporter@ti.com
List-Id: linux-mmc@vger.kernel.org

Adds device tree support for davinci_mmc. Also add binding documentation.
As of now tested for non-dma PIO mode and without GPIO card_detect/
write_protect option because of dependencies on EDMA and GPIO module DT
support.

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
Cc: Arnd Bergmann <arnd@arndb.de>
---
Since v6:
Add DMA handling capability.

Since v4:
Minor nit, check on return value for failure of max-frequency property
parsing.

Since v2:
Modified the default value for bus-width and skipping the property specifications for highspeed card capabilties for now. Re-ordered patch 2 and 3.

Since v1:
Modified the DT parse function to take default values, updated DT binding documentation accordingly.

 .../devicetree/bindings/mmc/davinci_mmc.txt        |   33 +++++++++
 drivers/mmc/host/davinci_mmc.c                     |   70 ++++++++++++++++++-
 2 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
new file mode 100644
index 0000000..e5a0140
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
@@ -0,0 +1,33 @@
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
+- dmas: List of DMA specifiers with the controller specific format
+	as described in the generic DMA client binding. A tx and rx
+	specifier is required.
+- dma-names: RX and TX  DMA request names. These strings correspond
+	1:1 with the DMA specifiers listed in dmas.
+
+Example:
+mmc0: mmc@1c40000 {
+	compatible = "ti,da830-mmc",
+	reg = <0x40000 0x1000>;
+	interrupts = <16>;
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	dmas = <&edma 16
+		&edma 17>;
+	dma-names = "rx", "tx";
+};
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 7d0e684..1d06e5a 100644
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
@@ -523,14 +525,16 @@ static int __init davinci_acquire_dma_channels(struct mmc_davinci_host *host)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	host->dma_tx =
-		dma_request_channel(mask, edma_filter_fn, &host->txdma);
+		dma_request_slave_channel_compat(mask, edma_filter_fn,
+				&host->txdma, mmc_dev(host->mmc), "tx");
 	if (!host->dma_tx) {
 		dev_err(mmc_dev(host->mmc), "Can't get dma_tx channel\n");
 		return -ENODEV;
 	}
 
 	host->dma_rx =
-		dma_request_channel(mask, edma_filter_fn, &host->rxdma);
+		dma_request_slave_channel_compat(mask, edma_filter_fn,
+				&host->rxdma, mmc_dev(host->mmc), "rx");
 	if (!host->dma_rx) {
 		dev_err(mmc_dev(host->mmc), "Can't get dma_rx channel\n");
 		r = -ENODEV;
@@ -1170,9 +1174,62 @@ static struct platform_device_id davinci_mmc_devtype[] = {
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
@@ -1180,7 +1237,11 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
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
@@ -1424,6 +1485,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.name	= "davinci_mmc",
 		.owner	= THIS_MODULE,
 		.pm	= davinci_mmcsd_pm_ops,
+		.of_match_table = of_match_ptr(davinci_mmc_dt_ids),
 	},
 	.remove		= __exit_p(davinci_mmcsd_remove),
 	.id_table	= davinci_mmc_devtype,
-- 
1.7.4.1

