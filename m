From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 3/3] mmc:esdhc: add support to get voltage from device-tree
Date: Mon, 29 Jul 2013 10:56:35 +0800
Message-ID: <1375066595-14968-3-git-send-email-Haijun.Zhang@freescale.com>
References: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:43907
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330Ab3G2Dtt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Jul 2013 23:49:49 -0400
In-Reply-To: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Add suppport to get voltage from device-tree node for esdhc host,
if voltage-ranges was specified in device-tree node we can get
ocr_mask instead of read from host capacity register. If not voltages
still can be get from host capacity register.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 15039e2..b1a7f54 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -316,6 +316,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 
 	/* call to generic mmc_of_parse to support additional capabilities */
 	mmc_of_parse(host->mmc);
+	host->ocr_mask = mmc_of_parse_voltage(host->mmc);
 
 	ret = sdhci_add_host(host);
 	if (ret)
-- 
1.8.0


