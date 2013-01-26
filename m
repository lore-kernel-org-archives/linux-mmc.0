From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] mmc: fix to refer NULL pointer
Date: Sat, 26 Jan 2013 14:19:49 +0900
Message-ID: <1359177589-13868-1-git-send-email-jy0922.shim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47802 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab3AZFTm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Jan 2013 00:19:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Check whether host->sdio_irq_thread is NULL before wake_up_process() is
called about host->sdio_irq_thread.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
Currently the kernel panic to refer NULL pointer about
host->sdio_irq_thread are occuring at the trats board using Samsung
SDHCI driver.

 include/linux/mmc/host.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 61a10c1..2950fea 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -372,7 +372,8 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
 	host->sdio_irq_pending = true;
-	wake_up_process(host->sdio_irq_thread);
+	if (host->sdio_irq_thread)
+		wake_up_process(host->sdio_irq_thread);
 }
 
 #ifdef CONFIG_REGULATOR
-- 
1.7.9.5

