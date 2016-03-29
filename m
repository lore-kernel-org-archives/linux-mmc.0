From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/8] mmc: sdhci-pci: Remove redundant runtime PM calls
Date: Tue, 29 Mar 2016 09:31:11 +0200
Message-ID: <1459236673-5639-6-git-send-email-ulf.hansson@linaro.org>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35421 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbcC2Hbb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 03:31:31 -0400
Received: by mail-lf0-f46.google.com with SMTP id k79so5261557lfb.2
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2016 00:31:30 -0700 (PDT)
In-Reply-To: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>

Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
devices"), made some calls to the runtime PM API from the driver
redundant. Especially those which deals with runtime PM reference
counting, so let's remove them.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 62aa5d0..8dfe721 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -340,8 +340,6 @@ static int bxt_get_cd(struct mmc_host *mmc)
 	if (!gpio_cd)
 		return 0;
 
-	pm_runtime_get_sync(mmc->parent);
-
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
@@ -351,9 +349,6 @@ static int bxt_get_cd(struct mmc_host *mmc)
 out:
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	pm_runtime_mark_last_busy(mmc->parent);
-	pm_runtime_put_autosuspend(mmc->parent);
-
 	return ret;
 }
 
-- 
1.9.1

