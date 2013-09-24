From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/5] mmc:sdhc: Calculate timeout_clk from actual sd clock
Date: Tue, 24 Sep 2013 16:12:16 +0800
Message-ID: <1380010339-25446-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1380010339-25446-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:52977
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750725Ab3IXIRs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 04:17:48 -0400
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
 drivers/mmc/host/sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7a7fb4f..c614c31 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1238,6 +1238,10 @@ clock_set:
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
+	if (real_div && (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
+		host->timeout_clk = host->mmc->actual_clock / 1000;
+		host->mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+	}
 out:
 	host->clock = clock;
 }
-- 
1.8.0


