From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 09/10] mmc: sdhci-esdhc-imx: add preset value quirk for mx6
Date: Wed, 9 Oct 2013 19:20:15 +0800
Message-ID: <1381317616-1229-10-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:26681
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752352Ab3JILfM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2013 07:35:12 -0400
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, b29396@freescale.com, john.tobias.ph@gmail.com

The i.MX6 does not support preset value feature.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8879974..5cd70e0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -995,8 +995,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	 * The imx6q ROM code will change the default watermark level setting
 	 * to something insane.  Change it back here.
 	 */
-	if (is_imx6_usdhc(imx_data))
+	if (is_imx6_usdhc(imx_data)) {
 		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
+		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+	}
 
 	if (is_imx6q_usdhc(imx_data))
 		sdhci_esdhc_ops.platform_execute_tuning =
-- 
1.7.2.rc3


