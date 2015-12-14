From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v4, 6/6] mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
Date: Mon, 14 Dec 2015 12:24:27 +0800
Message-ID: <1450067067-44869-7-git-send-email-yangbo.lu@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0117.outbound.protection.outlook.com ([65.55.169.117]:55296
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752272AbbLNEcX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Dec 2015 23:32:23 -0500
In-Reply-To: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: scottwood@freescale.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

The eSDHC of T4240-R1.0-R2.0 has incorrect vender version and spec version.
Acturally, the right version numbers should be VVN=0x13 and SVN = 0x1.
So, fix it in driver to avoid that incorrect version numbers break down the
ADMA data transfer.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- None
Changes for v3:
	- Got SoC version/revision from struct sdhci_esdhc instead of global variables
Changes for v4
	- None
---
 drivers/mmc/host/sdhci-of-esdhc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 9105888..6ab94e7 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -77,6 +77,8 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 static u16 esdhc_readw_fixup(struct sdhci_host *host,
 				     int spec_reg, u32 value)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_esdhc *esdhc = pltfm_host->priv;
 	u16 ret;
 	int shift = (spec_reg & 0x2) * 8;
 
@@ -84,6 +86,13 @@ static u16 esdhc_readw_fixup(struct sdhci_host *host,
 		ret = value & 0xffff;
 	else
 		ret = (value >> shift) & 0xffff;
+
+	/* Workaround for T4240-R1.0-R2.0 eSDHC which has incorrect
+	 * vendor version and spec version information.
+	 */
+	if ((spec_reg == SDHCI_HOST_VERSION) &&
+	    (esdhc->soc_ver == SVR_T4240) && (esdhc->soc_rev <= 0x20))
+		ret = (VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) | SDHCI_SPEC_200;
 	return ret;
 }
 
-- 
2.1.0.27.g96db324

