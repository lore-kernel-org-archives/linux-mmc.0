From: <yinbo.zhu@nxp.com>
Subject: [PATCH v2] mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec
Date: Wed, 8 Nov 2017 17:09:50 +0800
Message-ID: <20171108090950.4900-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0067.outbound.protection.outlook.com ([104.47.40.67]:47872
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751295AbdKHJ2H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Nov 2017 04:28:07 -0500
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
Change in v2:
		Replace ESDHC_TB_DIS with default register bit ESDHC_TB_EN

 drivers/mmc/host/sdhci-of-esdhc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d96a057a7db8..023c24bd0d94 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -783,6 +783,10 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 	pltfm_host = sdhci_priv(host);
 	esdhc = sdhci_pltfm_priv(pltfm_host);
 
+	val = sdhci_readl(host, ESDHC_TBCTL);
+	val &= ~ESDHC_TB_EN;
+	sdhci_writel(host, val, ESDHC_TBCTL);
+
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
-- 
2.14.1

