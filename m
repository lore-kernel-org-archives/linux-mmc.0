From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci: Remove blank line
Date: Wed, 18 Jun 2014 09:22:31 +0200
Message-ID: <1403076151-3950-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:65386 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbaFRHWm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jun 2014 03:22:42 -0400
Received: by mail-la0-f52.google.com with SMTP id ty20so240822lab.25
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jun 2014 00:22:41 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>

While merging the sdhci patchset from Russell King, somehow a blank
line was left behind. Let's correct the formatting.

Cc: Chris Ball <chris@printf.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c23a872..9493fa7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1533,7 +1533,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			host->ops->set_clock(host, host->clock);
 		}
 
-
 		/* Reset SD Clock Enable */
 		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 		clk &= ~SDHCI_CLOCK_CARD_EN;
-- 
1.7.9.5

