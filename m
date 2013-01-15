From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci-esdhc-imx: fix host version read
Date: Tue, 15 Jan 2013 23:30:27 +0800
Message-ID: <1358263827-3379-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:6034
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755118Ab3AOPaE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jan 2013 10:30:04 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, stable@vger.kernel.org

When commit 95a2482 (mmc: sdhci-esdhc-imx: add basic imx6q usdhc
support) works around host version issue on imx6q, it gets the
register address fixup "reg ^= 2" lost for imx25/35/51/53 esdhc.
Thus, the controller version on these SoCs is wrongly identified
as v1 while it's actually v2.

Add the address fixup back and take a different approach to correct
imx6q host version, so that the host version read gets back to work
for all SoCs.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: <stable@vger.kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e07df81..b503113 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -237,15 +237,18 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 
 static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+
 	if (unlikely(reg == SDHCI_HOST_VERSION)) {
-		u16 val = readw(host->ioaddr + (reg ^ 2));
-		/*
-		 * uSDHC supports SDHCI v3.0, but it's encoded as value
-		 * 0x3 in host controller version register, which violates
-		 * SDHCI_SPEC_300 definition.  Work it around here.
-		 */
-		if ((val & SDHCI_SPEC_VER_MASK) == 3)
-			return --val;
+		reg ^= 2;
+		if (is_imx6q_usdhc(imx_data)) {
+			/*
+			 * The usdhc register returns a wrong host version.
+			 * Correct it here.
+			 */
+			return SDHCI_SPEC_300;
+		}
 	}
 
 	return readw(host->ioaddr + reg);
-- 
1.7.9.5


