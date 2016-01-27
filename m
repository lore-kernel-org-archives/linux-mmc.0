From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 01/21] mmc: sdhci-pltfm: consolidate parsing path
Date: Wed, 27 Jan 2016 13:04:23 +0800
Message-ID: <1453871063-3030-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch wrapper mmc_of_parse into sdhci_get_of_property,
and change the return value for variant drivers to check it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/sdhci-pltfm.c | 23 +++++++++++++++++++----
 drivers/mmc/host/sdhci-pltfm.h |  2 +-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 072bb27..8b0fa73 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -66,12 +66,19 @@ static bool sdhci_of_wp_inverted(struct device_node *np)
 #endif /* CONFIG_PPC */
 }
 
-void sdhci_get_of_property(struct platform_device *pdev)
+int sdhci_get_of_property(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	u32 bus_width;
+	int ret;
+
+	ret = mmc_of_parse(host->mmc);
+	if (ret) {
+		dev_err(&pdev->dev, "mmc_of_parse failed!\n");
+		return ret;
+	}
 
 	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
 		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
@@ -107,9 +114,11 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	if (of_property_read_bool(np, "wakeup-source") ||
 	    of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+
+	return 0;
 }
 #else
-void sdhci_get_of_property(struct platform_device *pdev) {}
+int sdhci_get_of_property(struct platform_device *pdev) {}
 #endif /* CONFIG_OF */
 EXPORT_SYMBOL_GPL(sdhci_get_of_property);
 
@@ -207,12 +216,18 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	sdhci_get_of_property(pdev);
+	ret = sdhci_get_of_property(pdev);
+	if (ret)
+		goto err_register;
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		sdhci_pltfm_free(pdev);
+		goto err_register;
+
+	return 0;
 
+err_register:
+	sdhci_pltfm_free(pdev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_register);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 04bc248..2da8065 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -91,7 +91,7 @@ static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
 }
 #endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
 
-extern void sdhci_get_of_property(struct platform_device *pdev);
+extern int sdhci_get_of_property(struct platform_device *pdev);
 
 extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 					  const struct sdhci_pltfm_data *pdata,
-- 
2.3.7
