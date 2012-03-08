From: <r66093@freescale.com>
Subject: [PATCH] eSDHC: Add ADMA mode support for eSDHC
Date: Thu, 8 Mar 2012 11:25:02 +0800
Message-ID: <1331177102-24455-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:10362
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302Ab2CHDdT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Mar 2012 22:33:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Pan Jiafei <Jiafei.Pan@freescale.com>, Jason Jin <Jason.jin@freescale.com>, Chris Ball <cjb@laptop.org>, Anton Vorontsov <cbouatmailru@gmail.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

The register of eSDHC Host Controller Capabilities is not compatible with
standard SDHC register, and eSDHC cannot support End Attribute in NOP ADMA
descriptor. With this patch eSDHC can works in ADMA mode
and performance can be improved.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Pan Jiafei <Jiafei.Pan@freescale.com>
Signed-off-by: Jason Jin <Jason.jin@freescale.com>
CC: Chris Ball <cjb@laptop.org>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c |   36 +++++++++++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index f8eb1fb..ae5fcbf 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -21,6 +21,32 @@
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
+#define VENDOR_V_22	0x12
+static u32 esdhc_readl(struct sdhci_host *host, int reg)
+{
+	u32 ret;
+
+	ret = in_be32(host->ioaddr + reg);
+	/*
+	 * The bit of ADMA flag in eSDHC is not compatible with standard
+	 * SDHC register, so set fake flag SDHCI_CAN_DO_ADMA2 when ADMA is
+	 * supported by eSDHC.
+	 * And for many FSL eSDHC controller, the reset value of field
+	 * SDHCI_CAN_DO_ADMA1 is one, but some of them can't support ADMA,
+	 * only these vendor version is greater than 2.2/0x12 support ADMA.
+	 * For FSL eSDHC, must aligned 4-byte, so use 0xFC to read the
+	 * the verdor version number, oxFE is SDHCI_HOST_VERSION.
+	 */
+	if ((reg == SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1)) {
+		u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
+		tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
+		if (tmp > VENDOR_V_22)
+			ret |= SDHCI_CAN_DO_ADMA2;
+	}
+
+	return ret;
+}
+
 static u16 esdhc_readw(struct sdhci_host *host, int reg)
 {
 	u16 ret;
@@ -144,7 +170,7 @@ static void esdhc_of_resume(struct sdhci_host *host)
 #endif
 
 static struct sdhci_ops sdhci_esdhc_ops = {
-	.read_l = sdhci_be32bs_readl,
+	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
 	.read_b = esdhc_readb,
 	.write_l = sdhci_be32bs_writel,
@@ -161,9 +187,13 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
-	/* card detection could be handled via GPIO */
+	/*
+	 * card detection could be handled via GPIO
+	 * eSDHC cannot support End Attribute in NOP ADMA descriptor
+	 */
 	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
-		| SDHCI_QUIRK_NO_CARD_NO_RESET,
+		| SDHCI_QUIRK_NO_CARD_NO_RESET
+		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.ops = &sdhci_esdhc_ops,
 };
 
-- 
1.7.5.4


