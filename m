From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH] mmc: sdio: avoid using NULL sdio_irq_thread pointer
Date: Fri, 10 Jul 2015 11:36:45 +0800
Message-ID: <1436499405-41847-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0117.outbound.protection.outlook.com ([207.46.100.117]:45568
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751622AbbGJD4L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jul 2015 23:56:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

For Freescale QorIQ LS1021AQDS board, there is a SDIO interrupt
in the process of resume without inserting SD adapter because of
some unknown issue. But the driver doesn't assign sdio_irq_thread
pointer. This will block the resume of kernel. This patch is used
to avoid using NULL sdio_irq_thread pointer.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 include/linux/mmc/host.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1369e54..83b81fd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -412,7 +412,8 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
 	host->sdio_irq_pending = true;
-	wake_up_process(host->sdio_irq_thread);
+	if (host->sdio_irq_thread)
+		wake_up_process(host->sdio_irq_thread);
 }
 
 void sdio_run_irqs(struct mmc_host *host);
-- 
2.1.0.27.g96db324

