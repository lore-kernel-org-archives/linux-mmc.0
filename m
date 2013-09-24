From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 5/5] mmc:esdhc: Avoid writting to power register
Date: Tue, 24 Sep 2013 16:12:19 +0800
Message-ID: <1380010339-25446-5-git-send-email-Haijun.Zhang@freescale.com>
References: <1380010339-25446-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:22375
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750725Ab3IXISB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 04:18:01 -0400
In-Reply-To: <1380010339-25446-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

eSDHC host don't have a standand power control register.
Also eSDHC host which support spec 1.0 and spec 2.0 don't
support voltage switch. So add this change avoid writing other
bit of this register by mistake.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index f5de1e5..bc7de5e 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -141,6 +141,11 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
 	if (reg == SDHCI_HOST_CONTROL)
 		val &= ~ESDHC_HOST_CONTROL_RES;
+
+	/* ESDHC host spec version 1.0 and 2.0 don't support voltage switch */
+	if ((reg == SDHCI_POWER_CONTROL) && (host->version < SDHCI_SPEC_300))
+		return;
+
 	sdhci_be32bs_writeb(host, val, reg);
 }
 
-- 
1.8.0


