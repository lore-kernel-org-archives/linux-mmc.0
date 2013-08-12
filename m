From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 3/3 V3] mmc:esdhc: add support to get voltage from device-tree
Date: Mon, 12 Aug 2013 09:39:04 +0800
Message-ID: <1376271546-25085-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:44719
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755416Ab3HLCpf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Aug 2013 22:45:35 -0400
In-Reply-To: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, galak@kernel.crashing.org, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Add suppport to get voltage from device-tree node for esdhc host,
if voltage-ranges was specified in device-tree node we can get
ocr_mask instead of read from host capacity register. If not voltages
still can be get from host capacity register.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
changes for V3:
	- changed the parameter of function

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


