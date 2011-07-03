From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/3] mmc: sdhci-esdhc-imx: add device tree probe support
Date: Sun,  3 Jul 2011 16:30:51 +0800
Message-ID: <1309681851-23052-4-git-send-email-shawn.guo@linaro.org>
References: <1309681851-23052-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1309681851-23052-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The patch adds device tree probe support for sdhci-esdhc-imx driver.

Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   40 ++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   99 +++++++++++++++++++-
 2 files changed, 134 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
new file mode 100644
index 0000000..e182e7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -0,0 +1,40 @@
+* Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.MX
+
+The Enhanced Secure Digital Host Controller on Freescale i.MX family
+provides an interface for MMC, SD, and SDIO types of memory cards.
+
+Required properties:
+- compatible : Should be "fsl,<chip>-esdhc"
+- reg : Should contain eSDHC registers location and length
+- interrupts : Should contain eSDHC interrupt
+- cd-type : String, card detection (CD) method.  Supported values are:
+    "none" : No CD
+    "controller" : Uses eSDHC controller internal CD signal
+    "gpio" : Uses GPIO pin for CD
+    "permanent" : No CD because card is permanently wired to host
+- wp-type : String, write protection (WP) method.  Supported values are:
+    "none" : No WP
+    "controller" : Uses eSDHC controller internal WP signal 
+    "gpio" : Uses GPIO pin for WP
+- gpios : Should specify GPIOs in this order: CD GPIO, WP GPIO, if
+  properties cd-type and wp-type are "gpio".
+
+Examples:
+
+esdhc@70004000 {
+	compatible = "fsl,imx51-esdhc";
+	reg = <0x70004000 0x4000>;
+	interrupts = <1>;
+	cd-type = "controller";
+	wp-type = "controller";
+};
+
+esdhc@70008000 {
+	compatible = "fsl,imx51-esdhc";
+	reg = <0x70008000 0x4000>;
+	interrupts = <2>;
+	cd-type = "gpio";
+	wp-type = "gpio";
+	gpios = <&gpio0 6 0>, /* CD, GPIO1_6 */
+		<&gpio0 5 0>; /* WP, GPIO1_5 */
+};
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 705d670..57793e3 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -20,6 +20,9 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <mach/esdhc.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -78,6 +81,14 @@ static struct platform_device_id imx_esdhc_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, imx_esdhc_devtype);
 
+static const struct of_device_id imx_esdhc_dt_ids[] = {
+	{ .compatible = "fsl,imx25-esdhc", .data = &imx_esdhc_devtype[IMX25_ESDHC], },
+	{ .compatible = "fsl,imx35-esdhc", .data = &imx_esdhc_devtype[IMX35_ESDHC], },
+	{ .compatible = "fsl,imx51-esdhc", .data = &imx_esdhc_devtype[IMX51_ESDHC], },
+	{ .compatible = "fsl,imx53-esdhc", .data = &imx_esdhc_devtype[IMX53_ESDHC], },
+	{ /* sentinel */ },
+};
+
 static unsigned int esdhc_pltfm_get_max_blk_size(struct sdhci_host *host)
 {
 	/* Force 2048 bytes, which is the maximum supported size in SDHCI. */
@@ -290,24 +301,93 @@ static irqreturn_t cd_irq(int irq, void *data)
 	return IRQ_HANDLED;
 };
 
+#ifdef CONFIG_OF
+static int __devinit sdhci_esdhc_imx_probe_dt(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+			of_match_device(imx_esdhc_dt_ids, &pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	struct esdhc_platform_data *boarddata;
+	int err, i;
+	const char *cd, *cd_types[] = {
+		[ESDHC_CD_NONE]		= "none",
+		[ESDHC_CD_CONTROLLER]	= "controller",
+		[ESDHC_CD_GPIO]		= "gpio",
+		[ESDHC_CD_PERMANENT]	= "permanent",
+	};
+	const char *wp, *wp_types[] = {
+		[ESDHC_WP_NONE]		= "none",
+		[ESDHC_WP_CONTROLLER]	= "controller",
+		[ESDHC_WP_GPIO]		= "gpio",
+	};
+
+	if (!np)
+		return -ENODEV;
+
+	boarddata = kzalloc(sizeof(*boarddata), GFP_KERNEL);
+	if (!boarddata)
+		return -ENOMEM;
+	pdev->dev.platform_data = boarddata;
+
+	err = of_property_read_string(np, "cd-type", &cd);
+	if (err)
+		return err;
+	for (i = 0; i < ARRAY_SIZE(cd_types); i++)
+		if (!strcasecmp(cd, cd_types[i])) {
+			boarddata->cd_type = i;
+			break;
+		}
+
+	err = of_property_read_string(np, "wp-type", &wp);
+	if (err)
+		return err;
+	for (i = 0; i < ARRAY_SIZE(wp_types); i++)
+		if (!strcasecmp(wp, wp_types[i])) {
+			boarddata->wp_type = i;
+			break;
+		}
+
+	boarddata->cd_gpio = of_get_gpio(np, 0);
+	boarddata->wp_gpio = of_get_gpio(np, 1);
+
+	pdev->id_entry = (struct platform_device_id *) of_id->data;
+
+	return 0;
+}
+#else
+static inline int sdhci_esdhc_imx_probe_dt(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
-	struct esdhc_platform_data *boarddata;
+	struct esdhc_platform_data *boarddata = NULL;
 	struct clk *clk;
 	int err;
 	struct pltfm_imx_data *imx_data;
 
+	err = sdhci_esdhc_imx_probe_dt(pdev);
+	if (err)
+		return err;
+
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
-	if (IS_ERR(host))
-		return PTR_ERR(host);
+	if (IS_ERR(host)) {
+		err = PTR_ERR(host);
+		goto err_sdhci_pltfm;
+	}
 
 	pltfm_host = sdhci_priv(host);
 
 	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
-	if (!imx_data)
-		return -ENOMEM;
+	if (!imx_data) {
+		err = -ENOMEM;
+		goto err_imx_data;
+	}
 
 	imx_data->devtype = pdev->id_entry->driver_data;
 	pltfm_host->priv = imx_data;
@@ -401,12 +481,17 @@ no_board_data:
 	clk_put(pltfm_host->clk);
 err_clk_get:
 	kfree(imx_data);
+err_imx_data:
 	sdhci_pltfm_free(pdev);
+err_sdhci_pltfm:
+	if (np)
+		kfree(boarddata);
 	return err;
 }
 
 static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
@@ -429,6 +514,9 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 
 	sdhci_pltfm_free(pdev);
 
+	if (np)
+		kfree(boarddata);
+
 	return 0;
 }
 
@@ -436,6 +524,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
 	.driver		= {
 		.name	= "sdhci-esdhc-imx",
 		.owner	= THIS_MODULE,
+		.of_match_table = imx_esdhc_dt_ids,
 	},
 	.id_table	= imx_esdhc_devtype,
 	.probe		= sdhci_esdhc_imx_probe,
-- 
1.7.4.1
