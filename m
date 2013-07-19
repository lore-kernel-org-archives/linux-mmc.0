From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 3/4 V3] mmc: esdhc: Correct host version of T4240-R1.0-R2.0
Date: Fri, 19 Jul 2013 09:39:33 +0800
Message-ID: <1374197973-6050-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:41321
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935040Ab3GSCbe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jul 2013 22:31:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, r39252@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Vender version and sdhc spec version of T4240-R1.0-R2.0 is incorrect.
The right value should be VVN=0x13, SVN = 0x1. The wrong version number
will break down the ADMA data transfer. This defect only exist in
T4240-R1.0-R2.0.
Also share vvn and svr for public use.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index adfaadd..509e10d 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -26,7 +26,7 @@
 #define VENDOR_V_22	0x12
 #define VENDOR_V_23	0x13
 
-static u32 svr;
+static u32 svr, vvn;
 
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
@@ -43,11 +43,9 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
 	 * For FSL eSDHC, must aligned 4-byte, so use 0xFC to read the
 	 * the verdor version number, oxFE is SDHCI_HOST_VERSION.
 	 */
-	if ((reg == SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1)) {
-		u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
-		tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
-		if (tmp > VENDOR_V_22)
-			ret |= SDHCI_CAN_DO_ADMA2;
+	if ((reg == SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1) &&
+		(vvn > VENDOR_V_22)) {
+		ret |= SDHCI_CAN_DO_ADMA2;
 	}
 
 	return ret;
@@ -63,6 +61,12 @@ static u16 esdhc_readw(struct sdhci_host *host, int reg)
 		ret = in_be32(host->ioaddr + base) & 0xffff;
 	else
 		ret = (in_be32(host->ioaddr + base) >> shift) & 0xffff;
+
+	/* T4240-R1.0-R2.0 had a incorrect vendor version and spec version */
+	if ((reg == SDHCI_HOST_VERSION) &&
+			((SVR_SOC_VER(svr) == SVR_T4240) && (SVR_REV(svr) <= 0x20)))
+		ret = (VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) | SDHCI_SPEC_200;
+
 	return ret;
 }
 
@@ -175,17 +179,12 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
  */
 static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 {
-	u32 tmp;
 	bool applicable;
 	dma_addr_t dmastart;
 	dma_addr_t dmanow;
 
-	tmp = esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
-	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
-
 	applicable = (intmask & SDHCI_INT_DATA_END) &&
-		(intmask & SDHCI_INT_BLK_GAP) &&
-		(tmp == VENDOR_V_23);
+		(intmask & SDHCI_INT_BLK_GAP) && (vvn == VENDOR_V_23);
 	if (applicable) {
 
 		esdhc_reset(host, SDHCI_RESET_DATA);
@@ -215,7 +214,7 @@ static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 		((SVR_SOC_VER(svr) == SVR_P1010) && (SVR_REV(svr) == 0x10)) ||
 		((SVR_SOC_VER(svr) == SVR_P3041) && (SVR_REV(svr) <= 0x20)) ||
 		((SVR_SOC_VER(svr) == SVR_P2041) && (SVR_REV(svr) <= 0x20)) ||
-		((SVR_SOC_VER(svr) == SVR_P5040) && SVR_REV(svr) == 0x20)))
+		((SVR_SOC_VER(svr) == SVR_P5040) && (SVR_REV(svr) == 0x20))))
 		return;
 
 	esdhc_reset(host, SDHCI_RESET_DATA);
@@ -318,10 +317,9 @@ static void esdhc_of_resume(struct sdhci_host *host)
 
 static void esdhc_of_platform_init(struct sdhci_host *host)
 {
-	u32 vvn;
+	svr = mfspr(SPRN_SVR);
+	vvn = esdhc_readw(host, SDHCI_HOST_VERSION);
 
-	vvn = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
-	vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
 	if (vvn == VENDOR_V_22)
 		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
 
@@ -390,7 +388,6 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	struct device_node *np;
 	int ret;
 
-	svr = mfspr(SPRN_SVR);
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
-- 
1.8.0


