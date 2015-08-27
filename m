From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 3/3] mmc: sdhci-of-esdhc: add workaround for T4240 incorrect HOSTVER value
Date: Thu, 27 Aug 2015 17:29:14 +0800
Message-ID: <1440667754-25466-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0112.outbound.protection.outlook.com ([207.46.100.112]:40341
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751285AbbH0Jti (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Aug 2015 05:49:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: scottwood@freescale.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

For T4240-R1.0-R2.0, the HOSTVER register has incorrcet vender
version value and sdhc spec version value. This will break down
the ADMA data transfer. So add workaround to get right value
VVN=0x13, SVN = 0x1.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 20e0b9a..84496f0 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -70,6 +70,14 @@ static u16 esdhc_readw(struct sdhci_host *host, int reg)
 		ret = in_be32(host->ioaddr + base) & 0xffff;
 	else
 		ret = (in_be32(host->ioaddr + base) >> shift) & 0xffff;
+
+	/* Workaround for T4240-R1.0-R2.0 eSDHC which has incorrect
+	 * vendor version and spec version information.
+	 */
+	if ((reg == SDHCI_HOST_VERSION) &&
+	    (soc_ver == SVR_T4240) && (soc_rev <= 0x20))
+		ret = (VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) | SDHCI_SPEC_200;
+
 	return ret;
 }
 
-- 
2.1.0.27.g96db324

