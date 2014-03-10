From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 6/6] mmc: sdhci: Allow for irq being shared.
Date: Mon, 10 Mar 2014 15:02:44 +0200
Message-ID: <1394456564-13783-7-git-send-email-adrian.hunter@intel.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46138 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbaCJNEL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Mar 2014 09:04:11 -0400
In-Reply-To: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

If the SDHCI irq is shared with another device then
the interrupt handler can get called while SDHCI
is runtime suspended.  That is harmless but the
warning message is no longer useful so remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7f95211..4b155d5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2434,8 +2434,6 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	if (host->runtime_suspended) {
 		spin_unlock(&host->lock);
-		pr_warning("%s: got irq while runtime suspended\n",
-		       mmc_hostname(host->mmc));
 		return IRQ_HANDLED;
 	}
 
-- 
1.8.3.2

