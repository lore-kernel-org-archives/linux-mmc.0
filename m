From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]OMAP HSMMC: Fix a bug in card remove scenario
Date: Thu, 1 Apr 2010 05:59:36 +0530 (IST)
Message-ID: <40837.192.168.10.89.1270081776.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59446 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab0DAA3w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 31 Mar 2010 20:29:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

From: Madhusudhan Chikkature <madhu.cr@ti.com>
Date: Wed, 31 Mar 2010 19:31:24 -0400
Subject: [PATCH] OMAP HSMMC:Fix a bug in card removal scenario

The reset of data lines when the card is removed from the cage results
in a failure.The failure is seen if the card is removed from the cage
when TC is pending after a CMD with data received CC.The reset logic leaves
the controller in a state where niether a TC is received nor DTO.

The rest code can be safely removed here since it is taken care in the IRQ
handler.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 83f0aff..e9caf69 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1179,15 +1179,10 @@ static void omap_hsmmc_detect(struct work_struct *work)
 		carddetect = -ENOSYS;
 	}

-	if (carddetect) {
+	if (carddetect)
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
-	} else {
-		mmc_host_enable(host->mmc);
-		omap_hsmmc_reset_controller_fsm(host, SRD);
-		mmc_host_lazy_disable(host->mmc);
-
+	else
 		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
-	}
 }

 /*
-- 
1.6.3.3



