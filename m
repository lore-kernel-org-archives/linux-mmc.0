From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 3/4] sdhci: don't finish commands in flight
Date: Tue, 14 Dec 2010 22:49:35 -0600
Message-ID: <1292388576-25600-4-git-send-email-olof@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:38600 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760511Ab0LOE5b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Dec 2010 23:57:31 -0500
In-Reply-To: <1292388576-25600-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>

Don't schedule the finish_tasklet unless the command complete bit is
set in the interrupt status register.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 98f3d3d..4285cba 100644
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
1.7.3.GIT

