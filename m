From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/3] mmc: esdhc i.MX: Fix version register read
Date: Mon, 24 Sep 2012 09:22:24 +0200
Message-ID: <1348471345-30785-3-git-send-email-s.hauer@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43420 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab2IXHWr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 03:22:47 -0400
In-Reply-To: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>

The i.MX ESDHC controller version register is a mess:

- i.MX25 has a v1 controller which identifies itself as v2
- i.MX6Q has a v3 controller which identifies itself as v4
- i.MX35,51,53 have v2 controllers which identify themselves correctly

Additionally on i.MX the register is located at offset 0xfc instead of
0xfe. The i.MX6 had a quirk around it which converted v4 into v3. Instead
of reading the real version register, all other SoCs used to return
the value from 0xfe which contains 0x0 for all SoCs, so all controllers
except i.MX6q were identified as version v1.

This patch fixes this by returning the version based on the devtype
data leaving the useless version register untouched.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e23f813..4fe7312 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -237,15 +237,20 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 
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
+		switch (imx_data->devtype) {
+		case IMX25_ESDHC:
+			return SDHCI_SPEC_100;
+		case IMX35_ESDHC:
+		case IMX51_ESDHC:
+		case IMX53_ESDHC:
+			return SDHCI_SPEC_200;
+		case IMX6Q_USDHC:
+			return SDHCI_SPEC_300;
+		}
 	}
 
 	return readw(host->ioaddr + reg);
-- 
1.7.10.4

