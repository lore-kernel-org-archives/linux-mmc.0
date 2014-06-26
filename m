From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] mmc: sdhci: avoid double-delay while transitioning to 1.8V
Date: Thu, 26 Jun 2014 15:50:00 +0100
Message-ID: <E1X0Azw-0003rY-4v@rmk-PC.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:44025 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753449AbaFZOuE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jun 2014 10:50:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

The MMC core in mmc_set_signal_voltage() already provides for the delay
required to switch to 1.8V, so there is no need for drivers to perform
this wait themselves.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This patch was missed from the previous set because v2 was never sent.

 drivers/mmc/host/sdhci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d558f70756b0..3c8b91d3a793 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1762,9 +1762,6 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 		ctrl |= SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
-		/* Wait for 5ms */
-		usleep_range(5000, 5500);
-
 		/* 1.8V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (ctrl & SDHCI_CTRL_VDD_180)
-- 
1.8.3.1

