Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009501;
	b=L/ajfUHTh0Q1eWcwjOXfNlOysRulZTCCx3OWexGV9qIDzeTfxKCO3qvpmNGcGFrOTMaZ
	 SKM2nrE4B6ueBhve9gruPSf0nZoLTAMF6bM9kfJLkth2v8G7DhJPoLTgqUnKwGxE4ksMN
	 p1XKyVkvifQ4H9rNHY7i8brAnRTgKH0BHynBAwRHlRLZDbE6IJGtZ7FQrlPJqE387s8Fk
	 tablN9IQj1WuNxQZv2VMayTTXJq3EH/c03uxiBjEV+0yNZpTaT9Limj0A7ZVXi5PDh0uf
	 yPVU7NfyLAcxywgdrUbYzIFvhuUHLCXfwFuqrh+oNVW3pXiUN/5Tg+1XbJiRgTxyHFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5tUlyNBQsLqghT4FUQlxLY5bC88rlZM0X+hORoNIiMQ=;
	b=HlWVBiZ0a522p565EPy8ZmaAPZGQVqnlrZpUPFtM8U2fOa6ZWNRiVyN65XJeTQRggTZx
	 JtSzPNbwLeE98cl13okhkmyINNHNS8regSOp6lPXR6xyURTsCqvaG8rS7mKSnHKjRThD5
	 7X0jfBX/js0HgZUJXgEmtsPhIOmDaEQ4R4d3uzOlYfn+h+MYOtxAtbmDoNmxN+noujBer
	 keXMSNr4VlFEHbTfGdwTWEXhdQaOtDSmvkJY+o7kMIPek5/8kIQ7Y49M64EQh6uj+MlZa
	 KHd3xmq9TwDlqVZ+A4zHf2yM2xGbpMICIk618uzzeVCzxhqpU2dIp08zFqHb/HpO3AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYXHZjyv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC21606A31C;
	Wed, 18 Nov 2026 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYXHZjyv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B071F000C4;
	Wed, 18 Nov 2026 13:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009500;
	bh=5tUlyNBQsLqghT4FUQlxLY5bC88rlZM0X+hORoNIiMQ=;
	h=From:To:Cc:Subject:Date;
	b=TYXHZjyvBJURnLIknxHA4DXkQty/01rjeI87Gfqi9Qp3TLjNlw7QFInL20ndedE5O
	 XAFdLI1UNjCvQVgiSZaRrcIpYSTKLJUIzjVoz3HmYvZbBlAFPJ3ebZ10QG6jQGW3xb
	 6gRojFeuzv8Pq8qxLdq3/mIETIiH79IWqu8WjFlJE1S4ZbvmiHleXdRJp/6usRVObm
	 w8ZIcW2E+E76S4EhMq/7fAn9D22FO278au2ti9n8MkATQIqwTfMWLb8FupRBRLaYuu
	 MFKsWYpqqO0olLet9608L6cyUEgbkFev7PCqxoj05qGvbRXc0EIzx8XjO4YG2CXc+h
	 Effav++yXrq1g==
From: Arnd Bergmann <arnd@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linusw@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sh_mmcif: rework sg_miter handling
Date: Wed, 18 Nov 2026 13:57:59 +0100
Message-ID: <20261118134445.2909283-1-arnd@kernel.org>
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

Cc: Linus Walleij <linusw@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: 4d4a2c71b862 ("mmc: sh_mmcif: Advance sg_miter before reading blocks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Hi Wolfram and Linus,

Could you have a look at this? I'm not familiar with this driver,
so there is a chance I got this completely wrong. If the change
does make sense, maybe you can try testing it on one of the
highmem-enabled boards.

 drivers/mmc/host/sh_mmcif.c | 63 +++++++++++++------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index aa5a19d16c7f..7f1818831f93 100644
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
 
+	data->bytes_xfered += host->blocksize;
+	sgm->consumed = host->blocksize;
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
+	return data->bytes_xfered < host->blocksize * data->blocks;
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
 
+	data->bytes_xfered += host->blocksize;
+	sgm->consumed = host->blocksize;
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
+	return data->bytes_xfered < host->blocksize * data->blocks;
 }
 
 static void sh_mmcif_get_response(struct sh_mmcif_host *host,
@@ -1296,9 +1280,6 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 
 	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
 		struct mmc_data *data = mrq->data;
-		if (!mrq->cmd->error && data && !data->error)
-			data->bytes_xfered =
-				data->blocks * data->blksz;
 
 		if (mrq->stop && !mrq->cmd->error && (!data || !data->error)) {
 			sh_mmcif_stop_cmd(host, mrq);
-- 
2.53.0

