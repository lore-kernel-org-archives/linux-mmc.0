From: Haijun Zhang <haijun.zhang@freescale.com>
Subject: [PATCH] mmc:host eSDHC:  Remove duplicate code of enable_dma
Date: Sun, 7 Apr 2013 15:30:17 +0800
Message-ID: <1365319817-27237-1-git-send-email-haijun.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:26126
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161571Ab3DGIFz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Apr 2013 04:05:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <haijun.zhang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

Remove duplicate code "enable_dma()" in platform_resume.
Enable_dma was invoked already in sdhci_resume_host
before ops->platform_resume was executed

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 5e68adc..da3fb7b 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -212,7 +212,6 @@ static void esdhc_of_suspend(struct sdhci_host *host)
 
 static void esdhc_of_resume(struct sdhci_host *host)
 {
-	esdhc_of_enable_dma(host);
 	sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
 }
 #endif
-- 
1.7.0.4


