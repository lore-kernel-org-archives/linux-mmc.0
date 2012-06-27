From: philipspatches@gmail.com
Subject: [PATCH] mmc: host: sdhci.  UHS Switch failure - cycle power if regulator is used
Date: Wed, 27 Jun 2012 09:15:00 -0700
Message-ID: <1340813700-10898-1-git-send-email-prakity@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57816 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab2F0QPI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jun 2012 12:15:08 -0400
Received: by pbbrp8 with SMTP id rp8so1754708pbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jun 2012 09:15:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>

From: Philip Rakity <prakity@marvell.com>

Power needs to be removed from the card when switching to 1.8v fails.

If a regulator is used to control vmmc we need to turn the
regulator off and then back on otherwise power will not be removed
from the card.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f4b8b4d..ef4231a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1663,11 +1663,15 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 		pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
 		pwr &= ~SDHCI_POWER_ON;
 		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		if (host->vmmc)
+			regulator_disable(host->vmmc);
 
 		/* Wait for 1ms as per the spec */
 		usleep_range(1000, 1500);
 		pwr |= SDHCI_POWER_ON;
 		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		if (host->vmmc)
+			regulator_enable(host->vmmc);
 
 		pr_info(DRIVER_NAME ": Switching to 1.8V signalling "
 			"voltage failed, retrying with S18R set to 0\n");
-- 
1.7.0.4

