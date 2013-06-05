From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 1/3] mmc: sdhci-esdhc-imx: Fix version register read
Date: Wed,  5 Jun 2013 15:13:24 +0200
Message-ID: <1370438006-13093-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49722 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3FENPh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jun 2013 09:15:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, kernel@pengutronix.de

From: Sascha Hauer <s.hauer@pengutronix.de>

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
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c9317ed..8f0d8c7 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -258,12 +258,14 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 
 	if (unlikely(reg == SDHCI_HOST_VERSION)) {
-		reg ^= 2;
-		if (is_imx6q_usdhc(imx_data)) {
-			/*
-			 * The usdhc register returns a wrong host version.
-			 * Correct it here.
-			 */
+		switch (imx_data->devtype) {
+		case IMX25_ESDHC:
+			return SDHCI_SPEC_100;
+		case IMX35_ESDHC:
+		case IMX51_ESDHC:
+		case IMX53_ESDHC:
+			return SDHCI_SPEC_200;
+		case IMX6Q_USDHC:
 			return SDHCI_SPEC_300;
 		}
 	}
-- 
1.8.2.rc2

