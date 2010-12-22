From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 2/3] sdhci: don't finish commands in flight
Date: Wed, 22 Dec 2010 02:01:10 -0600
Message-ID: <1293004871-1918-3-git-send-email-olof@lixom.net>
References: <1293004871-1918-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:53493 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab0LVIBw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 03:01:52 -0500
In-Reply-To: <1293004871-1918-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>

Don't schedule the finish_tasklet unless the command complete bit is
set in the interrupt status register.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c0094c1..562aaea 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1432,7 +1432,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 		host->cmd->error = -EILSEQ;
 
 	if (host->cmd->error) {
-		tasklet_schedule(&host->finish_tasklet);
+		if (intmask & SDHCI_INT_RESPONSE)
+			tasklet_schedule(&host->finish_tasklet);
 		return;
 	}
 
-- 
1.7.3.1

