From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH 2/2] sdhci : recompute timeout_clk when needed
Date: Thu, 14 Aug 2014 16:03:18 +0200
Message-ID: <1408024998-4097-2-git-send-email-matthieu.castet@parrot.com>
References: <1408024998-4097-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:53719 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbaHNODL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Aug 2014 10:03:11 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so1155348wes.9
        for <linux-mmc@vger.kernel.org>; Thu, 14 Aug 2014 07:03:08 -0700 (PDT)
In-Reply-To: <1408024998-4097-1-git-send-email-matthieu.castet@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Matthieu CASTET <matthieu.castet@parrot.com>

when SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set, timeout_clk is sdclk.
We need to update it when we change sdclk in sdhci_set_clock.
This allow to have a more precisse timeout and max_busy_timeout. This
can help for command that need a big busy wait (erase, ...).

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
---
 drivers/mmc/host/sdhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9df59a4..76b1aab 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1192,8 +1192,13 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 clock_set:
-	if (real_div)
+	if (real_div) {
 		host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
+		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
+			host->timeout_clk = host->mmc->actual_clock / 1000;
+			host->mmc->max_busy_timeout = (1 << 27) / host->timeout_clk;
+		}
+	}
 
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
-- 
2.1.0.rc1

