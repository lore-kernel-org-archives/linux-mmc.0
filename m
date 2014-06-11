From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: usdhi6rol0: fix compiler warnings
Date: Wed, 11 Jun 2014 23:30:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1406112327250.2586@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:55588 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbaFKVbE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jun 2014 17:31:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Randy Dunlap <rdunlap@infradead.org>, Phil Edworthy <phil.edworthy@renesas.com>

Fix a number of wrong print formats.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

Chris, the "possibl NULL mrq" warning is bogus. It cannot be NULL in the 
USDHI6_WAIT_FOR_STOP state. But if you prefer, I can fix that one too.

 drivers/mmc/host/usdhi6rol0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index eb2bbbe..f0a39eb 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -357,7 +357,7 @@ static void *usdhi6_sg_map(struct usdhi6_host *host)
 
 	WARN(host->pg.page, "%p not properly unmapped!\n", host->pg.page);
 	if (WARN(sg_dma_len(sg) % data->blksz,
-		 "SG size %zd isn't a multiple of block size %zd\n",
+		 "SG size %u isn't a multiple of block size %u\n",
 		 sg_dma_len(sg), data->blksz))
 		return NULL;
 
@@ -459,7 +459,7 @@ static void usdhi6_sg_advance(struct usdhi6_host *host)
 	done = (host->page_idx << PAGE_SHIFT) + host->offset;
 	total = host->sg->offset + sg_dma_len(host->sg);
 
-	dev_dbg(mmc_dev(host->mmc), "%s(): %zu of %zu @ %u\n", __func__,
+	dev_dbg(mmc_dev(host->mmc), "%s(): %zu of %zu @ %zu\n", __func__,
 		done, total, host->offset);
 
 	if (done < total && host->offset) {
@@ -489,7 +489,7 @@ static void usdhi6_sg_advance(struct usdhi6_host *host)
 		host->sg = next;
 
 		if (WARN(next && sg_dma_len(next) % data->blksz,
-			 "SG size %zd isn't a multiple of block size %zd\n",
+			 "SG size %u isn't a multiple of block size %u\n",
 			 sg_dma_len(next), data->blksz))
 			data->error = -EINVAL;
 
@@ -896,7 +896,7 @@ static void usdhi6_request_done(struct usdhi6_host *host)
 	struct mmc_data *data = mrq->data;
 
 	if (WARN(host->pg.page || host->head_pg.page,
-		 "Page %p or %p not unmapped: wait %u, CMD%d(%c) @ +0x%x %ux%u in SG%u!\n",
+		 "Page %p or %p not unmapped: wait %u, CMD%d(%c) @ +0x%zx %ux%u in SG%u!\n",
 		 host->pg.page, host->head_pg.page, host->wait, mrq->cmd->opcode,
 		 data ? (data->flags & MMC_DATA_READ ? 'R' : 'W') : '-',
 		 data ? host->offset : 0, data ? data->blocks : 0,
@@ -1666,7 +1666,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
 	case USDHI6_WAIT_FOR_READ:
 	case USDHI6_WAIT_FOR_WRITE:
 		dev_dbg(mmc_dev(host->mmc),
-			"%c: page #%u @ +0x%x %ux%u in SG%u. Current SG %u bytes @ %u\n",
+			"%c: page #%u @ +0x%zx %ux%u in SG%u. Current SG %u bytes @ %u\n",
 			data->flags & MMC_DATA_READ ? 'R' : 'W', host->page_idx,
 			host->offset, data->blocks, data->blksz, data->sg_len,
 			sg_dma_len(host->sg), host->sg->offset);
-- 
1.9.3

