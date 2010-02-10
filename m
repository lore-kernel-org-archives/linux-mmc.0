From: David Vrabel <david.vrabel@csr.com>
Subject: [PATCH 2/3] mmc: omap_hsmmc: don't turn SDIO cards off when idle
Date: Wed, 10 Feb 2010 11:51:59 +0000
Message-ID: <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com>
References: <cover.1265801967.git.david.vrabel@csr.com>
 <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43032 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018Ab0BJLxG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Feb 2010 06:53:06 -0500
In-Reply-To: <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com>
In-Reply-To: <cover.1265801967.git.david.vrabel@csr.com>
References: <cover.1265801967.git.david.vrabel@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: David Vrabel <david.vrabel@csr.com>, linux-omap@vger.kernel.org, madhu.cr@ti.com

Don't turn SDIO cards off to save power.  Doing so will lose all
internal state in the card.

Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
 drivers/mmc/host/omap_hsmmc.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e7142a2..e6d8cb3 100644
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
@@ -1359,8 +1360,12 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
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
@@ -1371,9 +1376,8 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
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

