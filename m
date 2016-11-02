From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/4] mmc: sdhci: Fix missing enhanced strobe setting during runtime resume
Date: Wed,  2 Nov 2016 15:49:11 +0200
Message-ID: <1478094551-24819-5-git-send-email-adrian.hunter@intel.com>
References: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:57330 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754523AbcKBNyM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Nov 2016 09:54:12 -0400
In-Reply-To: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Harjani Ritesh <riteshh@codeaurora.org>

Restore enhanced strobe setting during runtime resume.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f8cb9a958738..146f442de1ad 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2921,6 +2921,10 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 		spin_unlock_irqrestore(&host->lock, flags);
 	}
 
+	if ((mmc->caps2 & MMC_CAP2_HS400_ES) &&
+	    mmc->ops->hs400_enhanced_strobe)
+		mmc->ops->hs400_enhanced_strobe(mmc, &mmc->ios);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	host->runtime_suspended = false;
-- 
1.9.1

