From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v3, 5/5] mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
Date: Fri, 27 Nov 2015 11:20:17 +0800
Message-ID: <1448594417-22515-6-git-send-email-yangbo.lu@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:13536
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753750AbbK0D2K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 22:28:10 -0500
In-Reply-To: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: scottwood@freescale.com, X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

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
---
 drivers/mmc/host/sdhci-of-esdhc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fce24b7..3a47243 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -78,6 +78,8 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 static u16 esdhc_readw_fixup(struct sdhci_host *host,
 				     int spec_reg, u32 value)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_esdhc *esdhc = pltfm_host->priv;
 	u16 ret;
 	int shift = (spec_reg & 0x2) * 8;
 
@@ -85,6 +87,13 @@ static u16 esdhc_readw_fixup(struct sdhci_host *host,
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

