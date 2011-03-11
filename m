From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio: fix address in kunmap_atomic() calls
Date: Fri, 11 Mar 2011 08:30:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103110822160.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52585 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1CKHaX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2011 02:30:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

Currently kunmap_atomic() doesn't take into account the offset, used
with kmap_atomic(). On platforms, where kunmap_atomic() is not a NOP,
this will lead to problems, when offset != 0.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

No, I've never seen this bug trigger, so, not sure whether we need it for 
.38 / stable.

 drivers/mmc/host/tmio_mmc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 986f902..32ab145 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -222,9 +222,9 @@ static char *tmio_mmc_kmap_atomic(struct scatterlist *sg, unsigned long *flags)
 	return kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ) + sg->offset;
 }
 
-static void tmio_mmc_kunmap_atomic(void *virt, unsigned long *flags)
+static void tmio_mmc_kunmap_atomic(struct scatterlist *sg, unsigned long *flags, void *virt)
 {
-	kunmap_atomic(virt, KM_BIO_SRC_IRQ);
+	kunmap_atomic(virt - sg->offset, KM_BIO_SRC_IRQ);
 	local_irq_restore(*flags);
 }
 
@@ -516,7 +516,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 
 	host->sg_off += count;
 
-	tmio_mmc_kunmap_atomic(sg_virt, &flags);
+	tmio_mmc_kunmap_atomic(host->sg_ptr, &flags, sg_virt);
 
 	if (host->sg_off == host->sg_ptr->length)
 		tmio_mmc_next_sg(host);
@@ -774,7 +774,7 @@ static void tmio_check_bounce_buffer(struct tmio_mmc_host *host)
 		unsigned long flags;
 		void *sg_vaddr = tmio_mmc_kmap_atomic(host->sg_orig, &flags);
 		memcpy(sg_vaddr, host->bounce_buf, host->bounce_sg.length);
-		tmio_mmc_kunmap_atomic(sg_vaddr, &flags);
+		tmio_mmc_kunmap_atomic(host->sg_orig, &flags, sg_vaddr);
 	}
 }
 
@@ -898,7 +898,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 		void *sg_vaddr = tmio_mmc_kmap_atomic(sg, &flags);
 		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
 		memcpy(host->bounce_buf, sg_vaddr, host->bounce_sg.length);
-		tmio_mmc_kunmap_atomic(sg_vaddr, &flags);
+		tmio_mmc_kunmap_atomic(sg, &flags, sg_vaddr);
 		host->sg_ptr = &host->bounce_sg;
 		sg = host->sg_ptr;
 	}
-- 
1.7.2.3

