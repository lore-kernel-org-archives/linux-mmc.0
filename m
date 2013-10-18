From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 7/8] mmc: sdhci-esdhc-imx: add preset value quirk for mx6
Date: Fri, 18 Oct 2013 18:54:20 +0800
Message-ID: <1382093661-4074-8-git-send-email-b29396@freescale.com>
References: <1382093661-4074-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:38019
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753077Ab3JRLK7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 07:10:59 -0400
In-Reply-To: <1382093661-4074-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

The i.MX6 does not support preset value feature.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index bdbca0e..8f2d995 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1006,8 +1006,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	 * The imx6q ROM code will change the default watermark level setting
 	 * to something insane.  Change it back here.
 	 */
-	if (esdhc_is_usdhc(imx_data))
+	if (esdhc_is_usdhc(imx_data)) {
 		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
+		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
-- 
1.7.2.rc3


