From: David Vrabel <david.vrabel@csr.com>
Subject: [PATCH 1/2] mmc: omap_hsmmc: don't turn SDIO cards off when idle
Date: Mon, 22 Feb 2010 14:24:18 +0000
Message-ID: <011dd4317f229b7bf71a6c962a621d86cfdda1f3.1266847842.git.david.vrabel@csr.com>
References: <cover.1266847842.git.david.vrabel@csr.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <cover.1266847842.git.david.vrabel@csr.com>
In-Reply-To: <cover.1266847842.git.david.vrabel@csr.com>
References: <cover.1266847842.git.david.vrabel@csr.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, madhu.cr@ti.com, David Vrabel <david.vrabel@csr.com>
List-Id: linux-mmc@vger.kernel.org

Don't turn SDIO cards off to save power.  Doing so will lose all
internal state in the card.

Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
 drivers/mmc/host/omap_hsmmc.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4b23225..323a0e8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/core.h>
+#include <linux/mmc/card.h>
 #include <linux/io.h>
 #include <linux/semaphore.h>
 #include <plat/dma.h>
@@ -1366,8 +1367,12 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
 	      mmc_slot(host).card_detect ||
 	      (mmc_slot(host).get_cover_state &&
 	       mmc_slot(host).get_cover_state(host->dev, host->slot_id)))) {
-		mmc_release_host(host->mmc);
-		return 0;
+		goto out;
+	}
+
+	/* Don't turn SDIO cards off. */
+	if (host->mmc->card && mmc_card_sdio(host->mmc->card)) {
+		goto out;
 	}
 
 	mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
@@ -1378,9 +1383,8 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
 		host->dpm_state == CARDSLEEP ? "CARDSLEEP" : "REGSLEEP");
 
 	host->dpm_state = OFF;
-
+out:
 	mmc_release_host(host->mmc);
-
 	return 0;
 }
 
-- 
1.6.3.3

