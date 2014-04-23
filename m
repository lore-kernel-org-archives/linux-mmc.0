From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 19/38] mmc: sdhci-esdhc-imx: comment runtime_pm_get_sync() in
 esdhc_prepare_tuning()
Date: Wed, 23 Apr 2014 20:07:47 +0100
Message-ID: <E1Wd2WJ-0003vY-D6@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46445 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932222AbaDWTHv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:07:51 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

It is far from obvious what this is doing, and it looks like it's an
unbalanced runtime_pm_get() call.  However, the put is inside
sdhci_tasklet_finish(), so it's not unbalanced at all.  This should
be documented so people know what's going on here.  Do so.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5acfe2fc4fe0..eb7a13796bcb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -695,6 +695,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
 	mdelay(1);
 
+	/* This is balanced by the runtime put in sdhci_tasklet_finish */
 	pm_runtime_get_sync(host->mmc->parent);
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
-- 
1.8.3.1

