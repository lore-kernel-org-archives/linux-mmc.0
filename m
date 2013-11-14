From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci: Allow for long command timeouts
Date: Thu, 14 Nov 2013 10:16:20 +0200
Message-ID: <1384416980-15850-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28827 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab3KNIJU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Nov 2013 03:09:20 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

The driver has a timer with a 10 second
timeout to catch devices that stop responding.
However it is possible for commands to take
even longer than that.  Change the timer
timeout to reflect the command timeout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bd8a098..614a34d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1013,7 +1013,12 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
-	mod_timer(&host->timer, jiffies + 10 * HZ);
+	timeout = jiffies;
+	if (!cmd->data && cmd->cmd_timeout_ms > 9000)
+		timeout += DIV_ROUND_UP(cmd->cmd_timeout_ms, 1000) * HZ + HZ;
+	else
+		timeout += 10 * HZ;
+	mod_timer(&host->timer, timeout);
 
 	host->cmd = cmd;
 
-- 
1.7.11.7

