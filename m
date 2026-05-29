Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE83546EC
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017498; cv=none; b=eg/nCZpLHrxDSkn1oS4/6GYOHyMswZbyKtnJnJwGYokgn4FXpDyMJDp1JmO1gTisUOqhiM0Jr3/LcE6CFEFaAHf90/YzysXcs2ffzwMKxIKBIQmokyuSYw0BEZKYLZRyRtmy/xd/dH2U4lXeD9KOpspurm4Jj55/FkzZX/JpoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017498; c=relaxed/simple;
	bh=630VxHoH+4a7eqI2+l9hMiLkD7npVli2NlDMtiLkB3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1kvezpsDqohweapLoRp8rif3F+2eOZzTEQ3+eoVYdyWpPH3pJiLa/MipV7gzpLIaDpWuHNlsp8/mpPXExX7eN35maAW76eqTyqe36GC7a75vxmN6KJ6vrkTbd1NWN5pJ+SSDZLWqBauRdRKFCEs7r9o+qwxPl5SGwRkYEd+Z9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZQO6E8X; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZQO6E8X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780017484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2fK5M76Z/nKa9g5TeFjZ7TzLjI6fUv57cnktOljPR14=;
	b=sZQO6E8XByReJg4jiTdoYlNTWirLclR7nviQ2QrvoP7o/BRtpi0eeWDoArFlaNb53uinj1
	FXJ1sizzLjqzYuCGtO2c0BrKPGSLii8sOw4E6YKKbt2+ilU7YO1IAcL/2ait/S71ehqkMa
	mvIUa1LukaHzZp3t55DGqgDy5KPe5RY=
From: Shawn Lin <shawn.lin@linux.dev>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: dw_mmc: Add desc_num field for clarity
Date: Fri, 29 May 2026 09:17:39 +0800
Message-ID: <20260529011739.4381-1-shawn.lin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Shawn Lin <shawn.lin@rock-chips.com>

The ring_size field in struct dw_mci is misleadingly named.
Despite its name, it does not represent the size of the descriptor
ring buffer in bytes, but rather the number of descriptors allocated
within the fixed-size ring buffer.

The actual ring buffer size is fixed at PAGE_SIZE (or DESC_RING_BUF_SZ,
which equals PAGE_SIZE). Within this buffer, we allocate either
struct idmac_desc or struct idmac_desc_64addr descriptors, and
ring_size stores the count of these descriptors.

This naming has caused confusion, as it's also used to set
mmc->max_segs (the maximum number of scatter-gather segments),
which logically corresponds to the number of descriptors, not a
size in bytes.

No functional change is introduced by this naming-only patch.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes v2:
- remove ring_size

 drivers/mmc/host/dw_mmc.c | 16 ++++++++--------
 drivers/mmc/host/dw_mmc.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3b4157f34d11..d734d010444d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -490,12 +490,12 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 
 	if (host->dma_64bit_address == 1) {
 		struct idmac_desc_64addr *p;
-		/* Number of descriptors in the ring buffer */
-		host->ring_size =
+
+		host->desc_num =
 			DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr);
 
 		/* Forward link the descriptor list */
-		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1;
+		for (i = 0, p = host->sg_cpu; i < host->desc_num - 1;
 								i++, p++) {
 			p->des6 = (host->sg_dma +
 					(sizeof(struct idmac_desc_64addr) *
@@ -518,13 +518,13 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 
 	} else {
 		struct idmac_desc *p;
-		/* Number of descriptors in the ring buffer */
-		host->ring_size =
+
+		host->desc_num =
 			DESC_RING_BUF_SZ / sizeof(struct idmac_desc);
 
 		/* Forward link the descriptor list */
 		for (i = 0, p = host->sg_cpu;
-		     i < host->ring_size - 1;
+		     i < host->desc_num - 1;
 		     i++, p++) {
 			p->des3 = cpu_to_le32(host->sg_dma +
 					(sizeof(struct idmac_desc) * (i + 1)));
@@ -2857,10 +2857,10 @@ static int dw_mci_init_host(struct dw_mci *host)
 
 	/* Useful defaults if platform data is unset. */
 	if (host->use_dma == TRANS_MODE_IDMAC) {
-		mmc->max_segs = host->ring_size;
+		mmc->max_segs = host->desc_num;
 		mmc->max_blk_size = 65535;
 		mmc->max_seg_size = 0x1000;
-		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
+		mmc->max_req_size = mmc->max_seg_size * host->desc_num;
 		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else if (host->use_dma == TRANS_MODE_EDMAC) {
 		mmc->max_segs = 64;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 2ce8585e2c1e..9ffcd3946cff 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -79,7 +79,7 @@ struct dw_mci_dma_slave {
  * @dma_ops: Pointer to DMA callbacks.
  * @cmd_status: Snapshot of SR taken upon completion of the current
  *	command. Only valid when EVENT_CMD_COMPLETE is pending.
- * @ring_size: Buffer size for idma descriptors.
+ * @desc_num: Number of idmac descriptors available.
  * @dms: structure of slave-dma private data.
  * @phy_regs: physical address of controller's register map
  * @data_status: Snapshot of SR taken upon completion of the current
@@ -186,7 +186,7 @@ struct dw_mci {
 	void			*sg_cpu;
 	const struct dw_mci_dma_ops	*dma_ops;
 	/* For idmac */
-	unsigned int		ring_size;
+	unsigned short		desc_num;
 
 	/* For edmac */
 	struct dw_mci_dma_slave *dms;
-- 
2.25.1

