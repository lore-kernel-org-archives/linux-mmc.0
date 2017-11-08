From: <yinbo.zhu@nxp.com>
Subject: [PATCH v1] mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec
Date: Wed, 8 Nov 2017 15:40:09 +0800
Message-ID: <20171108074009.28914-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0060.outbound.protection.outlook.com ([104.47.32.60]:43424
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751318AbdKHH61 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Nov 2017 02:58:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yinbo.zhu@nxp.com, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, yangbo.lu@nxp.com

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

The bit eSDHC_TBCTL[TB_EN] couldn't be reset by eSDHC_SYSCTL[RSTA] which is
used to reset for all. The driver should make sure it's cleared before card
initialization, otherwise the initialization would fail.

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc.h    | 1 +
 drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index dfa58f8b8dfa..74b42dbc1ef6 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -60,6 +60,7 @@
 /* Tuning Block Control Register */
 #define ESDHC_TBCTL			0x120
 #define ESDHC_TB_EN			0x00000004
+#define ESDHC_TB_DIS			(0x1 << 2)
 
 /* Control Register for DMA transfer */
 #define ESDHC_DMA_SYSCTL		0x40c
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d96a057a7db8..b89de8e55330 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -783,6 +783,9 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 	pltfm_host = sdhci_priv(host);
 	esdhc = sdhci_pltfm_priv(pltfm_host);
 
+	val = sdhci_readl(host, ESDHC_TBCTL);
+	val &= ~ESDHC_TB_DIS;
+	sdhci_writel(host, val, ESDHC_TBCTL);
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
-- 
2.14.1

