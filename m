Received: from mail-m49195.qiye.163.com (mail-m49195.qiye.163.com [45.254.49.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F62382399;
	Thu,  9 Apr 2026 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721238; cv=none; b=KwpqgEteGNXpxqHyjR+H0wMocvDh+onx3HkrUhTobmYJc+Pt4ysTuC4SIF8Z0qsTU/+mawuxKeh/BHwo538Gsw2v/SOeO+vEERoSh2L6C6eO5VFgI/+GDg6XUQ49nIPj1ckyjLTLEofx7hFph2b05n04hRKWAe5lUGfKxtTefOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721238; c=relaxed/simple;
	bh=OxZO01IRFxToakVWxoOCTbVjJGde2fF0FaSVlhPAgqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m1rbwO4TqcgHNppwm1FKPmADB698JFSA/r8THfDyXxVZ9BQVg6NskR+qrnQ/KxH4WXW1z0Fo2hoXIkzb88xJkXIILU6BtPQw1Mb48tRsiaKNu7UE+IM4p+CBkBqJWMlByHCK9FeLuZHdMoIg39UON45c206Av83ZvTh878fZ2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FS3omU6W; arc=none smtp.client-ip=45.254.49.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FS3omU6W"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a14149f9;
	Thu, 9 Apr 2026 15:48:43 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/4] mmc: dw_mmc: Add desc_num field for clarity
Date: Thu,  9 Apr 2026 15:48:13 +0800
Message-Id: <1775720894-97901-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
References: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d713702a909cckunm41b60ef14ae58b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk0ZS1ZJGR8ZGh9KGBpNSklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FS3omU6WhJAAzUETJ3QO+n/WoKcHcZhFdODxmc+LPitPPOr4EJCnsL083PCU1n1PJDzLu5uCf7IiOLHlyz1J1Eicmi5o6MduXztS/mHvXzfd9ay1H3BdSiV2qnwAGv7YCWz083fvgx+AvtUOuANx7Hx9oHeN+MW7IzGGqxdpX74=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8vLa5zAi/MK4RjjIAGtsBGisnHM+C9uxsWt3aNA78BI=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

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

 drivers/mmc/host/dw_mmc.c | 16 ++++++++--------
 drivers/mmc/host/dw_mmc.h |  2 ++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 20193ee..df6daa6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -491,12 +491,12 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 
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
@@ -519,13 +519,13 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 
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
@@ -2858,10 +2858,10 @@ static int dw_mci_init_host(struct dw_mci *host)
 
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
index 14fb2b3..a05100c 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -80,6 +80,7 @@ struct dw_mci_dma_slave {
  * @cmd_status: Snapshot of SR taken upon completion of the current
  *	command. Only valid when EVENT_CMD_COMPLETE is pending.
  * @ring_size: Buffer size for idma descriptors.
+ * @desc_num: Number of idmac descriptors available.
  * @dms: structure of slave-dma private data.
  * @phy_regs: physical address of controller's register map
  * @data_status: Snapshot of SR taken upon completion of the current
@@ -185,6 +186,7 @@ struct dw_mci {
 	const struct dw_mci_dma_ops	*dma_ops;
 	/* For idmac */
 	unsigned int		ring_size;
+	unsigned short		desc_num;
 
 	/* For edmac */
 	struct dw_mci_dma_slave *dms;
-- 
2.7.4

