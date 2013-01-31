From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] mmc: davinci_mmc: add DT support
Date: Thu, 31 Jan 2013 16:03:06 +0530
Message-ID: <1359628387-14437-3-git-send-email-prakash.pm@ti.com>
References: <1359628387-14437-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1359628387-14437-1-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mporter-l0cyMroinI0@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Adds device tree support for davinci_mmc. Also add
binding documentation.
Tested with non-dma PIO mode and without GPIO
card_detect/write_protect option because of
dependencies on EDMA and GPIO modules DT support.

Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: mporter-l0cyMroinI0@public.gmane.org
---
 .../devicetree/bindings/mmc/davinci_mmc.txt        |   23 +++++++
 drivers/mmc/host/davinci_mmc.c                     |   69 +++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
new file mode 100644
index 0000000..144bee6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
@@ -0,0 +1,23 @@
+* TI Highspeed MMC host controller for DaVinci
+
+The Highspeed MMC Host Controller on TI DaVinci family
+provides an interface for MMC, SD and SDIO types of memory cards.
+
+This file documents differences between the core properties described
+by mmc.txt and the properties used by the davinci_mmc driver.
+
+Required properties:
+- compatible:
+ Should be "ti,davinci_mmc", for davinci controllers
+
+Optional properties:
+- bus-width: Number of data lines, can be <1>, <4>, or <8>, default <1>
+- max-frequency: maximum operating clock frequency.
+- caps: Check for Host capabilities in <linux/mmc/host.h>
+- version: version of controller.
+Example:
+	mmc1: mmc@0x4809c000 {
+		compatible = "ti,omap4-hsmmc";
+		reg = <0x4809c000 0x400>;
+		bus-width = <4>;
+	};
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 382b79d..ce6730d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -34,6 +34,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/edma.h>
 #include <linux/mmc/mmc.h>
+#include <linux/of.h>
 
 #include <linux/platform_data/mmc-davinci.h>
 
@@ -1156,16 +1157,75 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
 
 	mmc_davinci_reset_ctrl(host, 0);
 }
+#ifdef CONFIG_OF
+static struct davinci_mmc_config
+	*mmc_of_get_pdata(struct platform_device *pdev)
+{
+	struct device_node *np;
+	struct davinci_mmc_config *pdata = NULL;
+	u32 data;
+	int ret;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev, "Failed to allocate memory for struct davinci_mmc_config\n");
+			goto nodata;
+		}
+	}
+
+	np = pdev->dev.of_node;
+	if (!np)
+		goto nodata;
+
+	ret = of_property_read_u32(np, "bus-width", &data);
+	if (ret)
+		dev_info(&pdev->dev, "wires not specified, defaulting to 4 bit mode\n");
+	pdata->wires = data;
+
+	ret = of_property_read_u32(np, "max-frequency", &data);
+	if (ret)
+		dev_info(&pdev->dev, "max-frequency not specified, defaulting to 25MHz\n");
+	pdata->max_freq = data;
+
+	ret = of_property_read_u32(np, "caps", &data);
+	if (ret)
+		dev_info(&pdev->dev, "card capability not specified\n");
+	pdata->caps = data;
+
+	ret = of_property_read_u32(np, "version", &data);
+	if (ret)
+		dev_err(&pdev->dev, "version not specified\n");
+	pdata->version = data;
+
+nodata:
+	return pdata;
+}
+
+#else
+static struct davinci_mmc_config
+	*mmc_of_get_pdata(struct platform_device *pdev)
+{
+	return pdev->dev.platform_data;
+}
+#endif
 
 static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 {
-	struct davinci_mmc_config *pdata = pdev->dev.platform_data;
+	struct davinci_mmc_config *pdata = NULL;
 	struct mmc_davinci_host *host = NULL;
 	struct mmc_host *mmc = NULL;
 	struct resource *r, *mem = NULL;
 	int ret = 0, irq = 0;
 	size_t mem_size;
 
+	pdata = mmc_of_get_pdata(pdev);
+	if (pdata == NULL) {
+		dev_err(&pdev->dev, "Can not get platform data\n");
+		return -ENOENT;
+	}
+
 	/* REVISIT:  when we're fully converted, fail if pdata is NULL */
 
 	ret = -ENODEV;
@@ -1403,11 +1463,18 @@ static const struct dev_pm_ops davinci_mmcsd_pm = {
 #define davinci_mmcsd_pm_ops NULL
 #endif
 
+static const struct of_device_id davinci_mmc_of_match[] = {
+	{.compatible = "ti,davinci_mmc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, davinci_mmc_of_match);
+
 static struct platform_driver davinci_mmcsd_driver = {
 	.driver		= {
 		.name	= "davinci_mmc",
 		.owner	= THIS_MODULE,
 		.pm	= davinci_mmcsd_pm_ops,
+		.of_match_table = of_match_ptr(davinci_mmc_of_match),
 	},
 	.remove		= __exit_p(davinci_mmcsd_remove),
 };
-- 
1.7.4.1
