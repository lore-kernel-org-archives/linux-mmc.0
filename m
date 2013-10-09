From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 08/10] mmc: sdhci-esdhc-imx: enable SDR50 tuning for imx6q/dl
Date: Wed, 9 Oct 2013 19:20:14 +0800
Message-ID: <1381317616-1229-9-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:44722
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752293Ab3JILfK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2013 07:35:10 -0400
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, b29396@freescale.com, john.tobias.ph@gmail.com

The imx6q/dl supports SDR50 tunning, enable it for a better timing
on SDR50 mode.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 91b2d85..8879974 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -244,7 +244,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 		if (is_imx6q_usdhc(imx_data))
 			/* imx6q/dl does not have cap_1 register, fake one */
 			val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
-					| SDHCI_SUPPORT_SDR50;
+				| SDHCI_SUPPORT_SDR50 | SDHCI_USE_SDR50_TUNING;
 		else if (is_imx6sl_usdhc(imx_data))
 			val = readl(host->ioaddr + SDHCI_CAPABILITIES) & 0xFFFF;
 	}
-- 
1.7.2.rc3


