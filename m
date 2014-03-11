From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 6/6] mmc: sdhci: Allow for irq being shared.
Date: Tue, 11 Mar 2014 10:09:36 +0200
Message-ID: <531EC4C0.5020205@intel.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com> <1394456564-13783-7-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [143.182.124.37] ([143.182.124.37]:22875 "EHLO mga14.intel.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751626AbaCKIKQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Mar 2014 04:10:16 -0400
In-Reply-To: <1394456564-13783-7-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

If the SDHCI irq is shared with another device then
the interrupt handler can get called while SDHCI
is runtime suspended.  That is harmless but the
warning message is not useful so remove it.  Also
returning IRQ_NONE is more appropriate.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in V2:
	Return IRQ_NONE instead of IRQ_HANDLED


 drivers/mmc/host/sdhci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7f95211..04a5e25 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2434,9 +2434,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	if (host->runtime_suspended) {
 		spin_unlock(&host->lock);
-		pr_warning("%s: got irq while runtime suspended\n",
-		       mmc_hostname(host->mmc));
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 	}
 
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
-- 
1.8.3.2

