From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio_mmc: fix card eject during IO with DMA
Date: Fri, 6 Jan 2012 13:06:51 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201061302430.16279@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

When DMA is in use and the card is ejected during IO, DMA transfers have to
be terminated, otherwise the dmaengine driver fails to operate properly,
when the card is re-inserted.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This goes on top of all my recent tmio_mmc patches. Even if some of them 
will require some minor changes, this one, probably, will still have a 
good chance to apply:-)

 drivers/mmc/host/tmio_mmc.h     |    7 ++++++-
 drivers/mmc/host/tmio_mmc_dma.c |   12 ++++++++++++
 drivers/mmc/host/tmio_mmc_pio.c |    6 +++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 62d0d14..d857f5c 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -20,8 +20,8 @@
 #include <linux/mmc/tmio.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
-#include <linux/spinlock.h>
 #include <linux/scatterlist.h>
+#include <linux/spinlock.h>
 
 /* Definitions for values the CTRL_SDIO_STATUS register can take. */
 #define TMIO_SDIO_STAT_IOIRQ	0x0001
@@ -119,6 +119,7 @@ void tmio_mmc_start_dma(struct tmio_mmc_host *host, struct mmc_data *data);
 void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable);
 void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata);
 void tmio_mmc_release_dma(struct tmio_mmc_host *host);
+void tmio_mmc_abort_dma(struct tmio_mmc_host *host);
 #else
 static inline void tmio_mmc_start_dma(struct tmio_mmc_host *host,
 			       struct mmc_data *data)
@@ -139,6 +140,10 @@ static inline void tmio_mmc_request_dma(struct tmio_mmc_host *host,
 static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 {
 }
+
+static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
+{
+}
 #endif
 
 #ifdef CONFIG_PM
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 86f259c..756759b 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -34,6 +34,18 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 #endif
 }
 
+void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
+{
+	tmio_mmc_enable_dma(host, false);
+
+	if (host->chan_rx)
+		dmaengine_terminate_all(host->chan_rx);
+	if (host->chan_tx)
+		dmaengine_terminate_all(host->chan_tx);
+
+	tmio_mmc_enable_dma(host, true);
+}
+
 static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 {
 	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f68e6f3..7c4378f 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -42,8 +42,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
-#include <linux/workqueue.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 #include "tmio_mmc.h"
 
@@ -245,6 +245,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	/* Ready for new calls */
 	host->mrq = NULL;
 
+	tmio_mmc_abort_dma(host);
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -271,6 +272,9 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	host->mrq = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	if (mrq->cmd->error || (mrq->data && mrq->data->error))
+		tmio_mmc_abort_dma(host);
+
 	mmc_request_done(host->mmc, mrq);
 }
 
-- 
1.7.2.5

