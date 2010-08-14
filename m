From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] MMC: fix the use of kunmap_atomic() in tmio_mmc.h
Date: Sat, 14 Aug 2010 22:29:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1008142225120.16329@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:60241 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755137Ab0HNU3p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 14 Aug 2010 16:29:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ian Molton <spyro@f2s.com>, Magnus Damm <damm@opensource.se>, Eric Miao <eric.y.miao@gmail.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.c |    7 ++++---
 drivers/mmc/host/tmio_mmc.h |    8 +++-----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ee7d0a5..69d98e3 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -164,6 +164,7 @@ tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command *cmd)
 static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 {
 	struct mmc_data *data = host->data;
+	void *sg_virt;
 	unsigned short *buf;
 	unsigned int count;
 	unsigned long flags;
@@ -173,8 +174,8 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 		return;
 	}
 
-	buf = (unsigned short *)(tmio_mmc_kmap_atomic(host, &flags) +
-	      host->sg_off);
+	sg_virt = tmio_mmc_kmap_atomic(host->sg_ptr, &flags);
+	buf = (unsigned short *)(sg_virt + host->sg_off);
 
 	count = host->sg_ptr->length - host->sg_off;
 	if (count > data->blksz)
@@ -191,7 +192,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 
 	host->sg_off += count;
 
-	tmio_mmc_kunmap_atomic(host, &flags);
+	tmio_mmc_kunmap_atomic(sg_virt, &flags);
 
 	if (host->sg_off == host->sg_ptr->length)
 		tmio_mmc_next_sg(host);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 64f7d5d..446f9e9 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -177,19 +177,17 @@ static inline int tmio_mmc_next_sg(struct tmio_mmc_host *host)
 	return --host->sg_len;
 }
 
-static inline char *tmio_mmc_kmap_atomic(struct tmio_mmc_host *host,
+static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 	unsigned long *flags)
 {
-	struct scatterlist *sg = host->sg_ptr;
-
 	local_irq_save(*flags);
 	return kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ) + sg->offset;
 }
 
-static inline void tmio_mmc_kunmap_atomic(struct tmio_mmc_host *host,
+static inline void tmio_mmc_kunmap_atomic(void *virt,
 	unsigned long *flags)
 {
-	kunmap_atomic(sg_page(host->sg_ptr), KM_BIO_SRC_IRQ);
+	kunmap_atomic(virt, KM_BIO_SRC_IRQ);
 	local_irq_restore(*flags);
 }
 
-- 
1.7.2

