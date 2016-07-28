From: robert.foss@collabora.com
Subject: [PACTH v2] mmc: sdhci: Do not allow tuning procedure to be interrupted
Date: Thu, 28 Jul 2016 14:07:10 -0400
Message-ID: <1469729230-5392-1-git-send-email-robert.foss@collabora.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48262 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbcG1SHS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2016 14:07:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christopher Freeman <cfreeman@nvidia.com>, Robert Foss <robert.foss@collabora.com>

From: Christopher Freeman <cfreeman@nvidia.com>

wait_event_interruptible_timeout() will return early if the blocked
process receives a signal, causing the driver to abort the tuning
procedure and possibly leaving the controller in a bad state.  Since the
tuning command is expected to complete quickly (<50ms) and we've set a
timeout, use wait_event_timeout() instead.

Signed-off-by: Christopher Freeman <cfreeman@nvidia.com>
Tested-by: Robert Foss <robert.foss@collabora.com>
Signed-off-by: Robert Foss <robert.foss@collabora.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e3d7c0..9e80203 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1960,7 +1960,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 		spin_unlock_irqrestore(&host->lock, flags);
 		/* Wait for Buffer Read Ready interrupt */
-		wait_event_interruptible_timeout(host->buf_ready_int,
+		wait_event_timeout(host->buf_ready_int,
 					(host->tuning_done == 1),
 					msecs_to_jiffies(50));
 		spin_lock_irqsave(&host->lock, flags);
-- 
2.7.4

