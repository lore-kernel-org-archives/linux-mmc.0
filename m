From: akpm@linux-foundation.org
Subject: [patch 08/29] omap hsmmc: fix a bug in card remove scenario
Date: Tue, 06 Apr 2010 14:34:49 -0700
Message-ID: <201004062134.o36LYn5g009660@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40326 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756836Ab0DFVez (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Apr 2010 17:34:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, madhu.cr@ti.com, adrian.hunter@nokia.com, linux-mmc@vger.kernel.org

From: Madhusudhan Chikkature <madhu.cr@ti.com>

The reset of data lines when the card is removed from the cage results in
a failure.The failure is seen if the card is removed from the cage when TC
is pending after a CMD with data received CC.The reset logic leaves the
controller in a state where niether a TC is received nor DTO.

The rest code can be safely removed here since it is taken care in the IRQ
handler.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap_hsmmc.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff -puN drivers/mmc/host/omap_hsmmc.c~omap-hsmmc-fix-a-bug-in-card-remove-scenario drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~omap-hsmmc-fix-a-bug-in-card-remove-scenario
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -1179,15 +1179,10 @@ static void omap_hsmmc_detect(struct wor
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
_
