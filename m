From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 3/3 V2] mmc:esdhc: add support to get voltage from device-tree
Date: Wed, 31 Jul 2013 14:25:26 +0800
Message-ID: <1375251927-3330-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:9585 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754Ab3GaHR4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Jul 2013 03:17:56 -0400
In-Reply-To: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
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
changes for v2:
	- Update the parameters of function

 drivers/mmc/host/sdhci-of-esdhc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 15039e2..8a7e2af 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -316,6 +316,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 
 	/* call to generic mmc_of_parse to support additional capabilities */
 	mmc_of_parse(host->mmc);
+	host->ocr_mask = mmc_of_parse_voltage(np);
 
 	ret = sdhci_add_host(host);
 	if (ret)
-- 
1.8.0


