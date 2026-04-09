Received: from mail-m3286.qiye.163.com (mail-m3286.qiye.163.com [220.197.32.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F237F730;
	Thu,  9 Apr 2026 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720931; cv=none; b=tOXPmH7I/FR4pyjVSV0axtLsnI+7ft/zamagJaiRhebJxarJJx/Uaqb/DWFW2j6FWeS9Uuo4Z+gRdPgcIyNFPaatlzvWuX8+CCVXhznTHKchxnPQGB/8Ug140fwxgzK6gIPUzvLO4qvW7gI+UYYY3yCXTRZVf+7h4vJ+Q0D73/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720931; c=relaxed/simple;
	bh=r1OGjaa9YGLuGwwm2trkT4Ohn5ECx4QzKW6mJWs5tMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=vFoARJHakRc+X8GtJqRwf5mN9y2P1cMMYjzNwRDE2KN0uYBGtOhVZTfndZRcKCToQKoxi49KMp/kTyhvosIQ4VkOS+/cTH81vryQbkr0bgEb+oVfDP3Tf36SDmdCRSVtza+fvX6GP9ymgS3OyMtIhGMxugQsyo4n69y0PPxpck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FRLdfrWY; arc=none smtp.client-ip=220.197.32.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FRLdfrWY"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a1414a02;
	Thu, 9 Apr 2026 15:48:46 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/4] mmc: dw_mmc: Convert descriptor ring buffer to per-instance configurable
Date: Thu,  9 Apr 2026 15:48:14 +0800
Message-Id: <1775720894-97901-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
References: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d71370baa09cckunm41b60ef14ae5ac
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxOTVZJHh4dGhpLTh5KGU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FRLdfrWYh0i5sSqERvxCipsRAM5f+fkxu5T1K3kOnhgldpeRx5A6MrC9aakEul4uPk38M7EbjCYrO8ejwkb5NQoxhoeSNLQGxrxtMmaAJdNxLLpULhlbosUZQT+OFnR6dWRkb6LO2UYdaWWBY3eyc50jVV2AkJz2Syra4vVWuGs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Y9GZFxq1QLk8K9LiyX+Z9t8ZmOK6L01EVxcZERV2Two=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Replace the hardcoded DESC_RING_BUF_SZ macro with a per-instance
ring_size member in struct dw_mci. This change provides greater
flexibility and prepares the driver for future configuration options.

Variant host controllers can now override the default ring_size via
the struct dw_mci_drv_data::init() callback, allowing them to tune
the descriptor ring buffer size for their specific use cases. This
is particularly beneficial for improving performance in large-block
sequential read/write scenarios.

Empirical testing shows that increasing ring_size can significantly
improve request efficiency. For example, the block count per request
can increase from 0x800 (1 MiB) to 0x2000 (4 MiB), as demonstrated
by trace data:

    dd-706     [004] .....   106.017566: mmc_request_start: mmc1: start
    struct mmc_request[0000000066f43a37]: ... sbc_arg=0x800

    dd-697     [001] .....    15.227953: mmc_request_start: mmc1: start
    struct mmc_request[00000000d82bf187]: ... sbc_arg=0x2000

While increasing the request size improves sequential I/O throughput,
it also introduces trade-offs: larger requests can delay other pending
I/O operations. Therefore, this configuration should be balanced
according to the specific workload and not hardcoded globally.

The default ring_size is initialized to PAGE_SIZE in dw_mci_alloc_host(),
preserving existing behavior. All buffer size calculations now use
host->ring_size instead of the hardcoded macro.

No functional changes are introduced for existing platforms.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index df6daa6..61f10e7 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -50,8 +50,6 @@
 				 SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
 				 SDMMC_IDMAC_INT_TI)
 
-#define DESC_RING_BUF_SZ	PAGE_SIZE
-
 struct idmac_desc_64addr {
 	u32		des0;	/* Control Descriptor */
 #define IDMAC_OWN_CLR64(x) \
@@ -493,7 +491,7 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 		struct idmac_desc_64addr *p;
 
 		host->desc_num =
-			DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr);
+			host->ring_size / sizeof(struct idmac_desc_64addr);
 
 		/* Forward link the descriptor list */
 		for (i = 0, p = host->sg_cpu; i < host->desc_num - 1;
@@ -521,7 +519,7 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 		struct idmac_desc *p;
 
 		host->desc_num =
-			DESC_RING_BUF_SZ / sizeof(struct idmac_desc);
+			host->ring_size / sizeof(struct idmac_desc);
 
 		/* Forward link the descriptor list */
 		for (i = 0, p = host->sg_cpu;
@@ -653,7 +651,7 @@ static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data
 err_own_bit:
 	/* restore the descriptor chain as it's polluted */
 	dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
-	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
+	memset(host->sg_cpu, 0, host->ring_size);
 	dw_mci_idmac_init(host);
 	return -EINVAL;
 }
@@ -2954,7 +2952,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
 
 		/* Alloc memory for sg translation */
 		host->sg_cpu = dmam_alloc_coherent(host->dev,
-						   DESC_RING_BUF_SZ,
+						   host->ring_size,
 						   &host->sg_dma, GFP_KERNEL);
 		if (!host->sg_cpu) {
 			dev_err(host->dev,
@@ -3185,6 +3183,7 @@ struct dw_mci *dw_mci_alloc_host(struct device *dev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->dev = dev;
+	host->ring_size = PAGE_SIZE;
 
 	return host;
 }
-- 
2.7.4

