From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/4] mmc: sdhci: Allow override of get_cd() called from sdhci_request()
Date: Tue,  9 Feb 2016 16:12:36 +0200
Message-ID: <1455027158-21564-3-git-send-email-adrian.hunter@intel.com>
References: <1455027158-21564-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45280 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757320AbcBIOQb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Feb 2016 09:16:31 -0500
In-Reply-To: <1455027158-21564-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

Drivers may need to provide their own get_cd() mmc host op, but
currently the internals of the current op (sdhci_get_cd()) are
provided by sdhci_do_get_cd() which is also called from
sdhci_request().

To allow override of the get_cd functionality, change sdhci_request()
to call ->get_cd() instead of sdhci_do_get_cd().

Note, in the future the call to ->get_cd() will likely be removed
from sdhci_request() since most drivers don't need actually it.
However this change is being done now to facilitate a subsequent
bug fix.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9bfa66df963a..add9fdfd1d8f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1360,7 +1360,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_runtime_pm_get(host);
 
 	/* Firstly check card presence */
-	present = sdhci_do_get_cd(host);
+	present = mmc->ops->get_cd(mmc);
 
 	spin_lock_irqsave(&host->lock, flags);
 
-- 
1.9.1

