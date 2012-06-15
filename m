From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/4] mmc: sdhci-esdhc-imx: Remove unneeded '#ifdef CONFIG_OF'
Date: Fri, 15 Jun 2012 14:23:05 -0300
Message-ID: <1339780987-11063-2-git-send-email-fabio.estevam@freescale.com>
References: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:53125
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754218Ab2FORXl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 13:23:41 -0400
In-Reply-To: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, shawn.guo@linaro.org, marex@denx.de, Fabio Estevam <fabio.estevam@freescale.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

CONFIG_OF is always selected for imx SoCs so it is safe
to drop the '#ifdef CONFIG_OF'.

Cc: Chris Ball <cjb@laptop.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ebbe984..1b0c999 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -397,7 +397,6 @@ static irqreturn_t cd_irq(int irq, void *data)
 	return IRQ_HANDLED;
 };
 
-#ifdef CONFIG_OF
 static int __devinit
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 			 struct esdhc_platform_data *boarddata)
@@ -426,14 +425,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	return 0;
 }
-#else
-static inline int
-sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
-			 struct esdhc_platform_data *boarddata)
-{
-	return -ENODEV;
-}
-#endif
 
 static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 {
-- 
1.7.1


