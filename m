From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC] mmc: tmio: always unmap DMA before waiting for interrupt
Date: Thu, 16 Mar 2017 11:56:02 +0100
Message-ID: <20170316105602.2581-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

In the (maybe academical) case, we don't get a DATAEND interrupt after
DMA completed, we will wait endlessly for the completion to complete.
This is not bad per se, since we have a more generic completion tracking
a timeout. In that rare case, however, the DMA buffer will not get
unmapped and we have a leak. Reorder the code, so unmapping will always
take place.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

It's probably academical, still I think it is better to not have any leaks in
favor of slightly more lock hazzling. Open for opionions, though, this is why
I send out as RFC.

 drivers/mmc/host/tmio_mmc_dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index c7684fa91f1f9c..e2093db2b7ffce 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -47,8 +47,6 @@ static void tmio_mmc_dma_callback(void *arg)
 {
 	struct tmio_mmc_host *host = arg;
 
-	wait_for_completion(&host->dma_dataend);
-
 	spin_lock_irq(&host->lock);
 
 	if (!host->data)
@@ -63,6 +61,11 @@ static void tmio_mmc_dma_callback(void *arg)
 			     host->sg_ptr, host->sg_len,
 			     DMA_TO_DEVICE);
 
+	spin_unlock_irq(&host->lock);
+
+	wait_for_completion(&host->dma_dataend);
+
+	spin_lock_irq(&host->lock);
 	tmio_mmc_do_data_irq(host);
 out:
 	spin_unlock_irq(&host->lock);
-- 
2.11.0
