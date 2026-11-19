Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081170;
	b=XMQnMd1/um1kLFiDyajWhAoDDW9/pJBaEB0BrOSFuPbaUzOpdOnEw3dGLi0I/0yzo2Yv
	 RnrGMDuAyuzdh5jAZJZy6tck9DpXqd30mT5MFnhAnJO6U8ewnv7POqMJjWdBNa/IyoM8q
	 tK7TNiYLxdtr0lpGcw3OL8SPBPsNe2E5fs4BIkomYxUTmRfGQgGvcVxUku5YCuGKGJgo2
	 +E0lTJLbM+bhPwL4tTtzMxnqRcUhzwq4X27JsQN9sTVSIv3Ici/Uwz6KynkKPS927Emc7
	 1E6tqw3LHbH/avUNOgpaJ5gTkhRhJFAHRRyFRH6v/DmkhJXjr2DXf4mSbYFzRSDcXcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NACPbvtkvse8iIbDfe8jDxr3t+GLHtLQxDev59BSAbg=;
	b=tCfAihWM70h0TpWTOqSEP+voezmMtgNzneh6JMEc0VgGOtt14ggnZ4SnNixbG1AzqqR3
	 gZ2jwrdxxikERxbumlOlJ/tP42wDAV+CwoRvtKO8SIn7VWovUPyun/YkQfR2XXryxpbSL
	 RKjUvBGb9qGWb5LB+skMKK/C3GWijooAGxKFvTqsjYKeuoyfx43fgNobkrvPpp00sC1G6
	 qgRzsrz01e0Q00e8GdwT0uViEhvjdzuyH2HXpK4Ze2bY6P5x8TDNcrjWEtp5khaEDirXQ
	 fYTFM4G7cCD4mbZam9nfMfuMxG93t0lCPpPShzJk8iovtlp8KfyVHYq1ZfnnagqpmXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvhClFBr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4847606A324
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvhClFBr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2200F1F000C4;
	Thu, 19 Nov 2026 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795081169;
	bh=NACPbvtkvse8iIbDfe8jDxr3t+GLHtLQxDev59BSAbg=;
	h=From:To:Cc:Subject:Date;
	b=JvhClFBrsTcDwzUkO+5cJL7myMOEw8+KEiFnyHtxKlPEENSOAtt70h6Kf4eRigLoP
	 ymLMg/aTQi3jbAmZGOn53O69p/g7SCPXR9QMpQAJxpWsvDZDJb4tBuYzZpXtUW21Ar
	 3BKW5YUFvmfyDFKVntaapo38BEfoIuiCP+kZ+/8vrJexY0sa27AY/4AqsOaVHLoETw
	 3lWgKcv5cvS2yZWqqwtCltjYbWXxmrHo/KZ25Igg3BNekJSGI7f9if84LgFQ36BrAD
	 GScrN+Z1R+ff+i34MKyDsCnffDwaGEJjsxpAfs+Swr/YjZVY3r+gf5PBhcg96nGYb6
	 0aQR3uhIrLcvA==
From: Arnd Bergmann <arnd@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Frank Li <Frank.Li@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Samarth Narang <samarth.colleges@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] [v2] mmc: sh_mmcif: rework sg_miter handling
Date: Thu, 19 Nov 2026 10:39:14 +0100
Message-ID: <20261119093924.3508355-1-arnd@kernel.org>
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

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Linus Walleij <linusw@kernel.org>
Fixes: 4d4a2c71b862 ("mmc: sh_mmcif: Advance sg_miter before reading blocks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: address incorrect accounting problem [sashiko-bot]
---
 drivers/mmc/host/sh_mmcif.c | 72 +++++++++++++++----------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index aa5a19d16c7f..84d91771cd25 100644
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
 
+	data->bytes_xfered += 4 * i;
+	sgm->consumed = 4 * i;
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
 
-	sgm->consumed = host->blocksize;
+	data->bytes_xfered += 4 * i;
+	sgm->consumed = 4 * i;
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
 
+	data->bytes_xfered += 4 * i;
+	sgm->consumed = 4 * i;
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
 
-	sgm->consumed = host->blocksize;
-
-	if (!sg_miter_next(sgm)) {
-		sg_miter_stop(sgm);
-		return false;
-	}
+	data->bytes_xfered += 4 * i;
+	sgm->consumed = 4 * i;
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
@@ -1397,6 +1382,7 @@ static void sh_mmcif_timeout_work(struct work_struct *work)
 	case MMCIF_WAIT_FOR_WRITE:
 	case MMCIF_WAIT_FOR_READ_END:
 	case MMCIF_WAIT_FOR_WRITE_END:
+		mrq->data->bytes_xfered = 0;
 		mrq->data->error = sh_mmcif_error_manage(host);
 		break;
 	default:
-- 
2.53.0

