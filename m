From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 4/4] mmc: host: sdhci: Add virtual command queue support
Date: Fri,  6 Sep 2019 11:52:02 +0800
Message-ID: <fc8a0fe513d244375013546c3c03967510feea4a.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add cqhci_virt_finalize_request() to help to complete a request
from virtual command queue.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4e9ebc8..fb5983e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -32,6 +32,7 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include "sdhci.h"
+#include "cqhci.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -2710,7 +2711,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (!cqhci_virt_finalize_request(host->mmc, mrq))
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }
@@ -3133,7 +3135,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	/* Process mrqs ready for immediate completion */
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
-		if (mrqs_done[i])
+		if (mrqs_done[i] &&
+		    !cqhci_virt_finalize_request(host->mmc, mrqs_done[i]))
 			mmc_request_done(host->mmc, mrqs_done[i]);
 	}
 
-- 
1.7.9.5
