From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 3/4] mmc:esdhc: add support to get voltage from device-tree
Date: Mon, 26 Aug 2013 09:19:24 +0800
Message-ID: <1377479965-471-3-git-send-email-Haijun.Zhang@freescale.com>
References: <1377479965-471-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:26804
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755974Ab3HZBVZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Aug 2013 21:21:25 -0400
In-Reply-To: <1377479965-471-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, galak@kernel.crashing.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Add suppport to get voltage from device-tree node for esdhc host,
if voltage-ranges was specified in device-tree node we can get
ocr_mask instead of read from host capacity register. If not voltages
still can be get from host capacity register.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Acked-by: Anton Vorontsov <anton@enomsg.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 15039e2..e328252 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -316,6 +316,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 
 	/* call to generic mmc_of_parse to support additional capabilities */
 	mmc_of_parse(host->mmc);
+	mmc_of_parse_voltage(np, &host->ocr_mask);
 
 	ret = sdhci_add_host(host);
 	if (ret)
-- 
1.8.0


