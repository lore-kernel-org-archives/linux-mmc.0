From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 1/2] mmc: sdhci-pltfm: Convert DT properties to generic device properties
Date: Mon, 30 Jul 2018 11:45:42 +0530
Message-ID: <1532931343-9499-2-git-send-email-srinath.mannam@broadcom.com>
References: <1532931343-9499-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532931343-9499-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, vikram.prakash@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Convert DT properties to generic device properties
so that drivers can get properties from DT or ACPI.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 68 +++++++++++++++++++++++++-----------------
 drivers/mmc/host/sdhci-pltfm.h |  7 ++++-
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 02bea61..b231c9a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -30,6 +30,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/of.h>
 #ifdef CONFIG_PPC
 #include <asm/machdep.h>
@@ -51,11 +52,10 @@ static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-#ifdef CONFIG_OF
-static bool sdhci_of_wp_inverted(struct device_node *np)
+static bool sdhci_wp_inverted(struct device *dev)
 {
-	if (of_get_property(np, "sdhci,wp-inverted", NULL) ||
-	    of_get_property(np, "wp-inverted", NULL))
+	if (device_property_present(dev, "sdhci,wp-inverted") ||
+	    device_property_present(dev, "wp-inverted"))
 		return true;
 
 	/* Old device trees don't have the wp-inverted property. */
@@ -66,52 +66,64 @@ static bool sdhci_of_wp_inverted(struct device_node *np)
 #endif /* CONFIG_PPC */
 }
 
-void sdhci_get_of_property(struct platform_device *pdev)
+#ifdef CONFIG_OF
+static void sdhci_get_compatibility(struct platform_device *pdev)
 {
+	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+
+	if (!np)
+		return;
+
+	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
+	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
+	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
+	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+}
+#else
+void sdhci_get_compatibility(struct platform_device *pdev) {}
+#endif /* CONFIG_OF */
+
+void sdhci_get_property(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	u32 bus_width;
 
-	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
+	if (device_property_present(dev, "sdhci,auto-cmd12"))
 		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
-	if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
-	    (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
+	if (device_property_present(dev, "sdhci,1-bit-only") ||
+	    (device_property_read_u32(dev, "bus-width", &bus_width) == 0 &&
 	    bus_width == 1))
 		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
-	if (sdhci_of_wp_inverted(np))
+	if (sdhci_wp_inverted(dev))
 		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
-	if (of_get_property(np, "broken-cd", NULL))
+	if (device_property_present(dev, "broken-cd"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
-	if (of_get_property(np, "no-1-8-v", NULL))
+	if (device_property_present(dev, "no-1-8-v"))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
-	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
-		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
-
-	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
-	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
-	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
-	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
-		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	sdhci_get_compatibility(pdev);
 
-	of_property_read_u32(np, "clock-frequency", &pltfm_host->clock);
+	device_property_read_u32(dev, "clock-frequency", &pltfm_host->clock);
 
-	if (of_find_property(np, "keep-power-in-suspend", NULL))
+	if (device_property_present(dev, "keep-power-in-suspend"))
 		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
 
-	if (of_property_read_bool(np, "wakeup-source") ||
-	    of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
+	if (device_property_read_bool(dev, "wakeup-source") ||
+	    device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
-#else
-void sdhci_get_of_property(struct platform_device *pdev) {}
-#endif /* CONFIG_OF */
-EXPORT_SYMBOL_GPL(sdhci_get_of_property);
+EXPORT_SYMBOL_GPL(sdhci_get_property);
 
 struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 				    const struct sdhci_pltfm_data *pdata,
@@ -184,7 +196,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	sdhci_get_of_property(pdev);
+	sdhci_get_property(pdev);
 
 	ret = sdhci_add_host(host);
 	if (ret)
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 1e91fb1..6109987 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -90,7 +90,12 @@ static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
 }
 #endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
 
-extern void sdhci_get_of_property(struct platform_device *pdev);
+void sdhci_get_property(struct platform_device *pdev);
+
+static inline void sdhci_get_of_property(struct platform_device *pdev)
+{
+	return sdhci_get_property(pdev);
+}
 
 extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 					  const struct sdhci_pltfm_data *pdata,
-- 
2.7.4
