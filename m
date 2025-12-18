Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com [117.135.214.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A9347BC9
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066517; cv=none; b=VjM74j4806Qp5C0qfbkVrNQ5JqtfP8cANcOUJo+7ZqerMBF42qXIT18FUoMDicSvOVn3CYu988NnnDalstdwZatLI7S6HNjDcrEhM9mQ5NRAwG/VcNU2k3Tfw/dd0Tav1bD+U+iTQnbNxYrZg24eDrCeTQgKv72wpMJdv28Q7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066517; c=relaxed/simple;
	bh=wHORi1FYI7bwJVUMq5eekSf/jdfXCBVDagT+cE3shts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qUQ2JTGMiE3zvKm6H9UQfF5cOY3mLiGiBvGDBwQlpLlBNWJuETfuNAzOlW7UcIJ17Qh7qjBmcVL87dOtKw2EQT+0sV9vSEjHqJ4IPVItdkzn5974SJc+A0/BYwf7wLspIqS2p6OpfEdKSn7/x8I6paF4PNt3OmoF8q1ncZSGh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BdjWiuek; arc=none smtp.client-ip=117.135.214.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BdjWiuek"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb271;
	Thu, 18 Dec 2025 22:01:43 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 02/18] mmc: dw_mmc: Remove dma_ops from struct dw_mci_board
Date: Thu, 18 Dec 2025 22:00:29 +0800
Message-Id: <1766066445-14144-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c43fa209cckunm1f354c4b7144
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ04ZSVZCTUNJQh4ZTkNDQ0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BdjWiuekr5sfszcj5YrXhuK30H224qsRKfJEwo5MRktIurAkhkBMo3Scc6ECaoAhZbZATRTEFk6Csisg2L5po32+Rz27UbamhyzB7i9bKHUaNKJ66UVQeBxtwZKycTw9yABvxN9cS/6XNVXNJbzpEVGn0WZkUbE0KUcQhGxB2fM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=W2rBXmHFr2ZUHhZq+3oJEeNGa0XQuAs+aJlUu+QDG/g=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

we do take dma_ops from struct dw_mci_board, but we immediately
re-assign it from either dw_mci_idmac_ops or dw_mci_edmac_ops in
dw_mci_init_dma(). That means it's never used now, or has been
broken for a long time without noticed. It seems no drivers need
it, so remove it now.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 1 -
 drivers/mmc/host/dw_mmc.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 166511d..57b4cfd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3362,7 +3362,6 @@ int dw_mci_probe(struct dw_mci *host)
 		goto err_clk_ciu;
 	}
 
-	host->dma_ops = host->pdata->dma_ops;
 	dw_mci_init_dma(host);
 
 	/* Clear the interrupts for the host controller */
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 66f6402..48f474b 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -78,7 +78,7 @@ struct dw_mci_dma_slave {
  * @dma_64bit_address: Whether DMA supports 64-bit address mode or not.
  * @sg_dma: Bus address of DMA buffer.
  * @sg_cpu: Virtual address of DMA buffer.
- * @dma_ops: Pointer to platform-specific DMA callbacks.
+ * @dma_ops: Pointer to DMA callbacks.
  * @cmd_status: Snapshot of SR taken upon completion of the current
  * @ring_size: Buffer size for idma descriptors.
  *	command. Only valid when EVENT_CMD_COMPLETE is pending.
@@ -281,7 +281,6 @@ struct dw_mci_board {
 	u32 detect_delay_ms;
 
 	struct reset_control *rstc;
-	struct dw_mci_dma_ops *dma_ops;
 };
 
 /* Support for longer data read timeout */
-- 
2.7.4

