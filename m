From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/4] mmc: sdhci: Add out_unlock to sdhci_execute_tuning
Date: Fri,  5 Dec 2014 19:25:29 +0200
Message-ID: <1417800331-15248-3-git-send-email-adrian.hunter@intel.com>
References: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49598 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbaLER1Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:27:16 -0500
In-Reply-To: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

A 'goto' can be used to save duplicating unlocking
and returning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b3d68e0..2efa7fe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1909,9 +1909,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		/* FALLTHROUGH */
 
 	default:
-		spin_unlock_irqrestore(&host->lock, flags);
-		sdhci_runtime_pm_put(host);
-		return 0;
+		goto out_unlock;
 	}
 
 	if (host->ops->platform_execute_tuning) {
@@ -2066,6 +2064,7 @@ out:
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+out_unlock:
 	spin_unlock_irqrestore(&host->lock, flags);
 	sdhci_runtime_pm_put(host);
 
-- 
1.9.1

