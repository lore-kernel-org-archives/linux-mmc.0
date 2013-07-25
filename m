From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/2 V2] mmc: esdhc: get voltage from dts file
Date: Thu, 25 Jul 2013 08:38:11 +0800
Message-ID: <1374712691-12807-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:58133
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752871Ab3GYB3w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2013 21:29:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Add voltage-range support in esdhc of T4, So we can choose
to read voltages from dts file as one optional.
If we can get a valid voltage-range from device node, we use
this voltage as the final voltage support. Else we still read
from capacity or from other provider.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for V2:
	- change dev_info to dev_err
	- share function in pltfm.c

 drivers/mmc/host/sdhci-of-esdhc.c |  1 +
 drivers/mmc/host/sdhci-pltfm.c    | 32 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.h    |  1 +
 drivers/mmc/host/sdhci.c          |  3 +++
 include/linux/mmc/sdhci.h         |  1 +
 5 files changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 15039e2..cdfb08b 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -304,6 +304,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 
 	sdhci_get_of_property(pdev);
+	sdhci_get_voltage(pdev);
 
 	np = pdev->dev.of_node;
 	if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e2065a4..4682aba 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -109,10 +109,42 @@ void sdhci_get_of_property(struct platform_device *pdev)
 			host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 	}
 }
+
+void sdhci_get_voltage(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	const u32 *voltage_ranges;
+	int num_ranges, i;
+	struct device_node *np;
+
+	np = pdev->dev.of_node;
+	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
+	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
+	if (!voltage_ranges || !num_ranges) {
+		dev_info(&pdev->dev, "OF: voltage-ranges unspecified\n");
+		return;
+	}
+
+	for (i = 0; i < num_ranges; i++) {
+		const int j = i * 2;
+		u32 mask;
+
+		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
+				be32_to_cpu(voltage_ranges[j + 1]));
+		if (!mask) {
+			dev_err(&pdev->dev,
+				"OF: voltage-range #%d is invalid\n", i);
+			return;
+		}
+		host->ocr_mask |= mask;
+	}
+}
 #else
 void sdhci_get_of_property(struct platform_device *pdev) {}
+void sdhci_get_voltage(struct platform_device *pdev) {}
 #endif /* CONFIG_OF */
 EXPORT_SYMBOL_GPL(sdhci_get_of_property);
+EXPORT_SYMBOL_GPL(sdhci_get_voltage);
 
 struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 				    const struct sdhci_pltfm_data *pdata,
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index e15ced79..aba8253 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -92,6 +92,7 @@ static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
 #endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
 
 extern void sdhci_get_of_property(struct platform_device *pdev);
+extern void sdhci_get_voltage(struct platform_device *pdev);
 
 extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 					  const struct sdhci_pltfm_data *pdata,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a78bd4f..57541e0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3119,6 +3119,9 @@ int sdhci_add_host(struct sdhci_host *host)
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
 
+	if (host->ocr_mask)
+		ocr_avail = host->ocr_mask;
+
 	mmc->ocr_avail = ocr_avail;
 	mmc->ocr_avail_sdio = ocr_avail;
 	if (host->ocr_avail_sdio)
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e3c6a74..3e781b8 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -171,6 +171,7 @@ struct sdhci_host {
 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
 	unsigned int            ocr_avail_mmc;
+	u32 ocr_mask;		/* available voltages */
 
 	wait_queue_head_t	buf_ready_int;	/* Waitqueue for Buffer Read Ready interrupt */
 	unsigned int		tuning_done;	/* Condition flag set when CMD19 succeeds */
-- 
1.8.0


