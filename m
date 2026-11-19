Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101968;
	b=au2+FI3Bn0xC6WnJijfMaryWctXEqX1Rz3JZo4o9SjZC/A09Nh033O2QxT4OgrsD4HAR
	 rwkZpRvhpMwsa2temHo4sFPamCKJE4tOSFhXWRecynaOpA+VF8mHmo5UwwnG0ydoOEjB5
	 rQ4v2rIE1abmB5M5FktnOkt6FPTELtXkQRWZbOA5bU+UD21V/cO1yDvW/EeFRGGFwmcYy
	 X7uL46/YCiuL4vp5LiM+EYEZ+Cc9X39ZXqbP+cFOAWtIr+0ARFOaA1zKFyxHEtv/A3L34
	 q9tiiz0OlSdC9/zeHESnd10lbeGXkTDBUoEzkGuQoPaEucP7CN1qvd9BGbLu1leegLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101968;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X5X17qnEAUqCrUpUPB11kL3gfYpWNFUbHujQC3KySjo=;
	b=ipgMYZlbt0VlW9minRqI8B6qs5HaH79C7dS72W5qGWpopu98xx67nr8S2WFy7hu+eTGD
	 16UTK6zbcAxAKGUrOnq5Q0QG+AHrJjH6F4+8Zb7b4syDDjP3eUgz02yGwYU1TNfHYx1fF
	 EOeoMBvh/5DJ6wMlSLAOG/3A6S6CfR6gjsEfAFhWmLeZdNOmG5Xk+8rF9+IRyy3LvDvmd
	 gHvWvZflc8LqZ6jK5/jdSrB2qa5/sytR7nDnqMNpjMaTd4y/SlL/BQFc3aRuA3s916tMJ
	 5zTYdpokXMxF4C8RqdzH8oMech36cHpBDAvWR6zf7LLKHBiIuGIdPl/kengZG8dw6+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGzQfPsm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0B606A324
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGzQfPsm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B747F1F000C4;
	Thu, 19 Nov 2026 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795101968;
	bh=X5X17qnEAUqCrUpUPB11kL3gfYpWNFUbHujQC3KySjo=;
	h=From:To:Cc:Subject:Date;
	b=TGzQfPsmAy4tzCA7lzj8iJJu0ERy4KN78wDbK0kqs94fLl+00YSAPrZ8Q8Q8HaO8o
	 hUh5nru4WWzPTbIj28D0PXpQqKAH0GW9yKOfcqj2nG7OufjfkjBLujCHcaoV9xHLe1
	 qfiuUR7r0xfp0YTMCvccBpa2cu79it0/2L5YOQd5h5T/VRs27pCTGav8Dk+13ZFbaL
	 gSLSFgBC/S6/rdQP7k13I0IH3uHKpF12nIBkCGPDRdA+93jUkElqlWuowqAErdHFDR
	 ohdN5vyrccNyM7G5Te8S+nEwhP5/ByeFMXaKlZ6gMlC3gYYaoswrDj7o5xXl5qmPa3
	 MuCHHe59AGlZA==
From: Arnd Bergmann <arnd@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pan Chuang <panchuang@vivo.com>,
	Samarth Narang <samarth.colleges@gmail.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] [v3] mmc: sh_mmcif: rework sg_miter handling
Date: Thu, 19 Nov 2026 16:23:24 +0100
Message-ID: <20261119152559.3051943-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This driver is the only one that uses sg_miter_next() to get a persistent
mapping across interrupts, which prevents us from converting the internal
kmap() to a local mapping using SG_MITER_LOCAL flag.

Linus previously attempted to use atomic mappings here, which failed
for the same reason. I gave it another try, with a mapping that is only
active during a single sh_mmcif_mread_block()/sh_mmcif_mwrite_block() call.

This is mainly a revert of the patch that fixed the command 18 timeout,
but tries to solve the problem by updating and checking data->bytes_xfered
to keep track of when the transfer is finished.

Instead of calling sg_miter_stop() on error or completion, this now
always stops the iterator after the data transfer and restarts it during
the following interrupt.

As sashiko-bot comments, there is an inconsistency with the size of
each transfer: The mmc core expects a transfer of size data->blksz, but
the actual transfer is host->blocksize, which is read from a hardware
register. To keep the behavior as close as possible to what it was before,
I still advance the data->bytes_xfered and sgm->consumed values by
the requested transfer size for single-block read/write, but advance
them by the actually copied number of bytes for the partial transfers
in the multi-block requests.

Cc: Linus Walleij <linusw@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: 4d4a2c71b862 ("mmc: sh_mmcif: Advance sg_miter before reading blocks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: address error handling and (again) accounting,
    by resetting byes_xfered=0 on any error or timeout [sashiko-bot]
v2: address incorrect accounting problem [sashiko-bot]
---
 drivers/mmc/host/sh_mmcif.c | 68 +++++++++++++++----------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index aa5a19d16c7f..c6033c6596e0 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -604,7 +604,7 @@ static void sh_mmcif_single_read(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_TO_SG);
+		       SG_MITER_LOCAL | SG_MITER_TO_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_READ;
 
@@ -621,7 +621,6 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 	int i;
 
 	if (host->sd_error) {
-		sg_miter_stop(sgm);
 		data->error = sh_mmcif_error_manage(host);
 		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
 		return false;
@@ -629,7 +628,6 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 
 	if (!sg_miter_next(sgm)) {
 		/* This should not happen on single blocks */
-		sg_miter_stop(sgm);
 		return false;
 	}
 
@@ -638,6 +636,8 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 	for (i = 0; i < host->blocksize / 4; i++)
 		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
 
+	data->bytes_xfered += data->blksz;
+	sgm->consumed = data->blksz;
 	sg_miter_stop(&host->sg_miter);
 
 	/* buffer read end */
@@ -650,7 +650,6 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 				struct mmc_request *mrq)
 {
-	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct mmc_data *data = mrq->data;
 
 	if (!data->sg_len || !data->sg->length)
@@ -659,14 +658,8 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 		BLOCK_SIZE_MASK;
 
-	sg_miter_start(sgm, data->sg, data->sg_len,
-		       SG_MITER_TO_SG);
-
-	/* Advance to the first sglist entry */
-	if (!sg_miter_next(sgm)) {
-		sg_miter_stop(sgm);
-		return;
-	}
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+		       SG_MITER_LOCAL | SG_MITER_TO_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 
@@ -682,27 +675,26 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 	int i;
 
 	if (host->sd_error) {
-		sg_miter_stop(sgm);
 		data->error = sh_mmcif_error_manage(host);
 		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
+	if (!sg_miter_next(sgm))
+		return false;
+
 	p = sgm->addr;
 
 	for (i = 0; i < host->blocksize / 4; i++)
 		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
 
+	data->bytes_xfered += host->blocksize;
 	sgm->consumed = host->blocksize;
+	sg_miter_stop(sgm);
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 
-	if (!sg_miter_next(sgm)) {
-		sg_miter_stop(sgm);
-		return false;
-	}
-
-	return true;
+	return data->bytes_xfered < data->blksz * data->blocks;
 }
 
 static void sh_mmcif_single_write(struct sh_mmcif_host *host,
@@ -714,7 +706,7 @@ static void sh_mmcif_single_write(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
-		       SG_MITER_FROM_SG);
+		       SG_MITER_LOCAL | SG_MITER_FROM_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_WRITE;
 
@@ -731,7 +723,6 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 	int i;
 
 	if (host->sd_error) {
-		sg_miter_stop(sgm);
 		data->error = sh_mmcif_error_manage(host);
 		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
 		return false;
@@ -739,7 +730,6 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 
 	if (!sg_miter_next(sgm)) {
 		/* This should not happen on single blocks */
-		sg_miter_stop(sgm);
 		return false;
 	}
 
@@ -748,6 +738,8 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 	for (i = 0; i < host->blocksize / 4; i++)
 		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
 
+	data->bytes_xfered += data->blksz;
+	sgm->consumed = data->blksz;
 	sg_miter_stop(&host->sg_miter);
 
 	/* buffer write end */
@@ -760,7 +752,6 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 				struct mmc_request *mrq)
 {
-	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct mmc_data *data = mrq->data;
 
 	if (!data->sg_len || !data->sg->length)
@@ -769,14 +760,8 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 		BLOCK_SIZE_MASK;
 
-	sg_miter_start(sgm, data->sg, data->sg_len,
-		       SG_MITER_FROM_SG);
-
-	/* Advance to the first sglist entry */
-	if (!sg_miter_next(sgm)) {
-		sg_miter_stop(sgm);
-		return;
-	}
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+		       SG_MITER_LOCAL | SG_MITER_FROM_SG);
 
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 
@@ -792,27 +777,26 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 	int i;
 
 	if (host->sd_error) {
-		sg_miter_stop(sgm);
 		data->error = sh_mmcif_error_manage(host);
 		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
 		return false;
 	}
 
+	if (!sg_miter_next(sgm))
+		return false;
+
 	p = sgm->addr;
 
 	for (i = 0; i < host->blocksize / 4; i++)
 		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
 
+	data->bytes_xfered += host->blocksize;
 	sgm->consumed = host->blocksize;
-
-	if (!sg_miter_next(sgm)) {
-		sg_miter_stop(sgm);
-		return false;
-	}
+	sg_miter_stop(sgm);
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 
-	return true;
+	return data->bytes_xfered < data->blksz * data->blocks;
 }
 
 static void sh_mmcif_get_response(struct sh_mmcif_host *host,
@@ -1194,6 +1178,8 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 			dmaengine_terminate_sync(host->chan_rx);
 		else
 			dmaengine_terminate_sync(host->chan_tx);
+	} else {
+		data->bytes_xfered = data->blksz * data->blocks;
 	}
 
 	/*
@@ -1269,6 +1255,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 		break;
 	case MMCIF_WAIT_FOR_STOP:
 		if (host->sd_error) {
+			mrq->data->bytes_xfered = 0;
 			mrq->stop->error = sh_mmcif_error_manage(host);
 			dev_dbg(dev, "%s(): %d\n", __func__, mrq->stop->error);
 			break;
@@ -1279,6 +1266,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 	case MMCIF_WAIT_FOR_READ_END:
 	case MMCIF_WAIT_FOR_WRITE_END:
 		if (host->sd_error) {
+			mrq->data->bytes_xfered = 0;
 			mrq->data->error = sh_mmcif_error_manage(host);
 			dev_dbg(dev, "%s(): %d\n", __func__, mrq->data->error);
 		}
@@ -1296,9 +1284,6 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 
 	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
 		struct mmc_data *data = mrq->data;
-		if (!mrq->cmd->error && data && !data->error)
-			data->bytes_xfered =
-				data->blocks * data->blksz;
 
 		if (mrq->stop && !mrq->cmd->error && (!data || !data->error)) {
 			sh_mmcif_stop_cmd(host, mrq);
@@ -1403,6 +1388,7 @@ static void sh_mmcif_timeout_work(struct work_struct *work)
 		BUG();
 	}
 
+	mrq->data->bytes_xfered = 0;
 	host->state = STATE_IDLE;
 	host->wait_for = MMCIF_WAIT_FOR_REQUEST;
 	host->mrq = NULL;
-- 
2.53.0

