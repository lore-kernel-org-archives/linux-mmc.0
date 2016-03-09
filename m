From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] mmc: dw_mmc: avoid using dmaengine_terminate_all
Date: Wed,  9 Mar 2016 10:34:46 +0800
Message-ID: <1457490886-18092-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:36699 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbcCICnb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2016 21:43:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

dmaengine_terminate_all is deprecated and should be
replaced by more explicit synchronous and asynchronous
terminate functions. This change is based on the
commit b36f09c3c441 ("dmaengine: Add transfer termination
synchronization support"). Currently dw_mci_stop_dma
may be called under the spinlock, let's migrate
dmaengine_terminate_all to async terminate. This could
avoid the race condition of use-after-free resouce of
dmaengine once slave-dma driver implement the synchronize
method.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 242f9a0..45a406f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -680,7 +680,7 @@ static const struct dw_mci_dma_ops dw_mci_idmac_ops = {
 
 static void dw_mci_edmac_stop_dma(struct dw_mci *host)
 {
-	dmaengine_terminate_all(host->dms->ch);
+	dmaengine_terminate_async(host->dms->ch);
 }
 
 static int dw_mci_edmac_start_dma(struct dw_mci *host,
-- 
2.3.7


