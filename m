From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 4/5] mmc: esdhc: Correct host version of T4240-R1.0-R2.0
Date: Tue, 3 Sep 2013 15:33:16 +0800
Message-ID: <1378193597-29059-4-git-send-email-Haijun.Zhang@freescale.com>
References: <1378193597-29059-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.181.185] ([216.32.181.185]:29683 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932637Ab3ICHhc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 03:37:32 -0400
In-Reply-To: <1378193597-29059-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cbouatmailru@gmail.com, galak@kernel.crashing.org
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Vender version and sdhc spec version of T4240-R1.0-R2.0 is incorrect.
The right value should be VVN=0x13, SVN = 0x1. The wrong version number
will break down the ADMA data transfer. This defect only exist in
T4240-R1.0-R2.0.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
	- Depend on patch [1/5]

 drivers/mmc/host/sdhci-of-esdhc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index c531d75..ba2f234 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -63,6 +63,13 @@ static u16 esdhc_readw(struct sdhci_host *host, int reg)
 		ret = in_be32(host->ioaddr + base) & 0xffff;
 	else
 		ret = (in_be32(host->ioaddr + base) >> shift) & 0xffff;
+
+	/* T4240-R1.0-R2.0 had a incorrect vendor version and spec version */
+	if ((reg == SDHCI_HOST_VERSION) &&
+			((SVR_SOC_VER(svr) == SVR_T4240) &&
+			 (SVR_REV(svr) <= 0x20)))
+		ret = (VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) | SDHCI_SPEC_200;
+
 	return ret;
 }
 
-- 
1.8.0


