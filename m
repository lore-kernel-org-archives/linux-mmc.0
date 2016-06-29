From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 25/54] mmc: sdhci: sdhci_execute_tuning() must delete timer
Date: Wed, 29 Jun 2016 16:24:38 +0300
Message-ID: <1467206707-30185-26-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21027 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932098AbcF2Na6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:30:58 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

sdhci_send_command() starts a timer to catch cases where the host
controller fails. The timer is normally deleted when the request completes,
but in the case of sdhci_execute_tuning() the request is handled
differently and the timer is left running. This goes unnoticed because
tuning is done before another command so the timer gets reset then.
That should not be relied upon, so make sdhci_execute_tuning() delete the
timer.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6c8cc1a1b858..2ee8bfa77116 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2057,6 +2057,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		sdhci_send_command(host, &cmd);
 
 		host->cmd = NULL;
+		sdhci_del_timer(host, &mrq);
 
 		spin_unlock_irqrestore(&host->lock, flags);
 		/* Wait for Buffer Read Ready interrupt */
-- 
1.9.1

