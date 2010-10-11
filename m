From: Dmitry Shmidt <dimitrysh@android.com>
Subject: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Mon, 11 Oct 2010 18:32:26 +0000 (UTC)
Message-ID: <loom.20101011T202734-842@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33078 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755684Ab0JKSfF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Oct 2010 14:35:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1P5NDD-0002Xx-5y
	for linux-mmc@vger.kernel.org; Mon, 11 Oct 2010 20:35:03 +0200
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 11 Oct 2010 20:35:03 +0200
Received: from dimitrysh by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 11 Oct 2010 20:35:03 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

While working with "permanent" mmc/sdio devices we may want to skip new 
suspend/resume functionality.

commit 4c40080bb1d4f68000b7a4c397c1bc8a623668fa
Author: Dmitry Shmidt <dimitrysh@android.com>
Date:   Mon Oct 11 11:28:54 2010 -0700

    mmc: Add "ignore mmc pm notify" functionality
    
    Signed-off-by: Dmitry Shmidt <dimitrysh@android.com>

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d80cfdc..ba684e6 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -137,7 +137,8 @@ int mmc_add_host(struct mmc_host *host)
 #endif
 
 	mmc_start_host(host);
-	register_pm_notifier(&host->pm_notify);
+	if (!(host->pm_flags & MMC_PM_IGNORE_PM_NOTIFY))
+		register_pm_notifier(&host->pm_notify);
 
 	return 0;
 }
@@ -154,7 +155,9 @@ EXPORT_SYMBOL(mmc_add_host);
  */
 void mmc_remove_host(struct mmc_host *host)
 {
-	unregister_pm_notifier(&host->pm_notify);
+	if (!(host->pm_flags & MMC_PM_IGNORE_PM_NOTIFY))
+		unregister_pm_notifier(&host->pm_notify);
+
 	mmc_stop_host(host);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/mmc/pm.h b/include/linux/mmc/pm.h
index d37aac4..3903823 100644
--- a/include/linux/mmc/pm.h
+++ b/include/linux/mmc/pm.h
@@ -26,5 +26,6 @@ typedef unsigned int mmc_pm_flag_t;
 
 #define MMC_PM_KEEP_POWER	(1 << 0)	/* preserve card power during 
suspend */
 #define MMC_PM_WAKE_SDIO_IRQ	(1 << 1)	/* wake up host system on SDIO 
IRQ assertion */
+#define MMC_PM_IGNORE_PM_NOTIFY	(1 << 2)	/* ignore mmc pm notify 
*/
 
 #endif


