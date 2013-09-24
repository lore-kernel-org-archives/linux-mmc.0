From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 3/5] mmc:esdhc: Update timeout clock according to actual clock
Date: Tue, 24 Sep 2013 16:12:17 +0800
Message-ID: <1380010339-25446-3-git-send-email-Haijun.Zhang@freescale.com>
References: <1380010339-25446-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:46544
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941Ab3IXISQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 04:18:16 -0400
In-Reply-To: <1380010339-25446-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

At 50 Mhz SD_CLK period,
the max timeout value = 2^27 * SD_CLK period ~= 2.69 sec.

When we has quirk SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK, the timeout_clk
should be calculate according to the real clock run by card. Which is
less than 50 MHz. So update the timeout clock when the clock was actually
enabled and used.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index a2a0642..e70c4e6 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -73,6 +73,7 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
 	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
 		clock, host_clock / pre_div / div);
 
+	host->mmc->actual_clock = host->max_clk / pre_div / div;
 	pre_div >>= 1;
 	div--;
 
@@ -82,6 +83,11 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 	mdelay(1);
+
+	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
+		host->timeout_clk = host->mmc->actual_clock / 1000;
+		host->mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+	}
 out:
 	host->clock = clock;
 }
-- 
1.8.0


