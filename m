From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH] mmc: tmio: Fix PIO mode with CONFIG_HIGHMEM
Date: Fri, 13 Feb 2015 14:55:47 +0900
Message-ID: <54DD91E3.3070903@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Current PIO mode occurred kernel panic with CONFIG_HIGHMEM.
This patch fixes the kernel panic by converting the driver
to the sg_miter API.

Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
This patch is based on renesas.git / renesas-devel-20150211-v3.19 tag.

 drivers/mmc/host/tmio_mmc.h     |    1 +
 drivers/mmc/host/tmio_mmc_pio.c |   35 ++++++++++++++++-------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index a34ecbe..3092219 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -56,6 +56,7 @@ struct tmio_mmc_host {
 	struct scatterlist      *sg_orig;
 	unsigned int            sg_len;
 	unsigned int            sg_off;
+	struct sg_mapping_iter	sg_miter;

 	struct platform_device *pdev;
 	struct tmio_mmc_data *pdata;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 250bf8c..6d8f363 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -70,17 +70,14 @@ static void tmio_mmc_ack_mmc_irqs(struct tmio_mmc_host *host, u32 i)

 static void tmio_mmc_init_sg(struct tmio_mmc_host *host, struct mmc_data *data)
 {
-	host->sg_len = data->sg_len;
-	host->sg_ptr = data->sg;
-	host->sg_orig = data->sg;
-	host->sg_off = 0;
-}
+	unsigned int flags = SG_MITER_ATOMIC;

-static int tmio_mmc_next_sg(struct tmio_mmc_host *host)
-{
-	host->sg_ptr = sg_next(host->sg_ptr);
-	host->sg_off = 0;
-	return --host->sg_len;
+	if (data->flags & MMC_DATA_READ)
+		flags |= SG_MITER_TO_SG;
+	else
+		flags |= SG_MITER_FROM_SG;
+
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 }

 #ifdef CONFIG_MMC_DEBUG
@@ -418,7 +415,7 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
 static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 {
 	struct mmc_data *data = host->data;
-	void *sg_virt;
+	struct sg_mapping_iter *sg_miter = &host->sg_miter;
 	unsigned short *buf;
 	unsigned int count;
 	unsigned long flags;
@@ -431,10 +428,12 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 		return;
 	}

-	sg_virt = tmio_mmc_kmap_atomic(host->sg_ptr, &flags);
-	buf = (unsigned short *)(sg_virt + host->sg_off);
+	local_irq_save(flags);

-	count = host->sg_ptr->length - host->sg_off;
+	if (!sg_miter_next(sg_miter))
+		return;
+	buf = sg_miter->addr;
+	count = sg_miter->length;
 	if (count > data->blksz)
 		count = data->blksz;

@@ -444,12 +443,10 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 	/* Transfer the data */
 	tmio_mmc_transfer_data(host, buf, count);

-	host->sg_off += count;
-
-	tmio_mmc_kunmap_atomic(host->sg_ptr, &flags, sg_virt);
+	sg_miter->consumed = count;
+	sg_miter_stop(sg_miter);

-	if (host->sg_off == host->sg_ptr->length)
-		tmio_mmc_next_sg(host);
+	local_irq_restore(flags);

 	return;
 }
-- 
1.7.9.5
