From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 4/5] mmc: sdhci-esdhc-imx: fix runtime pm unblance issue
Date: Mon, 4 Nov 2013 16:38:28 +0800
Message-ID: <1383554309-29065-5-git-send-email-b29396@freescale.com>
References: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:40333
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752315Ab3KDI6p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2013 03:58:45 -0500
In-Reply-To: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, ulf.hansson@linaro.org

Since we're using common esdhc_send_command for tuning commands and
the core code will call pm_runtime_put after command is finished.
So we add a pm_runtime_get_sync here to get the blance.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 0bd99eb..da8026b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -698,6 +698,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
 	mdelay(1);
 
+	pm_runtime_get_sync(host->mmc->parent);
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
 			ESDHC_MIX_CTRL_FBCLK_SEL;
-- 
1.7.2.rc3


