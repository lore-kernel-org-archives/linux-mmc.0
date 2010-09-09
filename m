From: akpm@linux-foundation.org
Subject: [patch 17/41] omap hsmmc: fix a racing case between kmmcd and omap_hsmmc_suspend
Date: Thu, 09 Sep 2010 16:37:49 -0700
Message-ID: <201009092337.o89Nbndr014216@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44536 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754333Ab0IIXsz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 19:48:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ethan.too@gmail.com, adrian.hunter@nokia.com, cjb@laptop.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

From: Ethan Du <ethan.too@gmail.com>

If suspend called when kmmcd is doing host->ops->disable, as kmmcd already
increased host->en_dis_recurs to 1, the mmc_host_enable in suspend
function will return directly without increase the nesting_cnt, which will
cause the followed register access carried out to the disabled host.

mmc_suspend_host will enable host itself.  No need to enable host before
it.  Also works on kmmcd will get flushed in mmc_suspend_host, enable host
after it will be safe.  So make the mmc_host_enable after it.

[cjb: rebase against current Linus]
Signed-off-by: Ethan <ethan.too@gmail.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
Acked-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/omap_hsmmc.c~omap-hsmmc-fix-a-racing-case-between-kmmcd-and-omap_hsmmc_suspend drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~omap-hsmmc-fix-a-racing-case-between-kmmcd-and-omap_hsmmc_suspend
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -2323,8 +2323,8 @@ static int omap_hsmmc_suspend(struct dev
 			}
 		}
 		cancel_work_sync(&host->mmc_carddetect_work);
-		mmc_host_enable(host->mmc);
 		ret = mmc_suspend_host(host->mmc);
+		mmc_host_enable(host->mmc);
 		if (ret == 0) {
 			omap_hsmmc_disable_irq(host);
 			OMAP_HSMMC_WRITE(host->base, HCTL,
_
