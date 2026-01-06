Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com [101.71.155.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC129D27E
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666204; cv=none; b=a9PT/2Oj9jbT+9TKjDKEVX+1JY3cfJaIrEA/UrWbaFMP9BBzRWWDLEYh+OJ2+lrfCZPgXtvIaPFNZO5NoVqLlQRIDh5RZUsWcPmow4WQmqyY8muW+SBN++SL2Y64M4vwZbnVwjLJ49xcOz7geAGrlTondb7zlxdh4JOE60JLofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666204; c=relaxed/simple;
	bh=4YkIVFXVi+6g0SJjHAujYqiV4V3HRgl3RvzEMkEhFEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t/07Ip7SHYzuTwybLuyW2WOV/Puo08COMSAA9AJNIhFDdmJtZyzzcT3PWMe5S7wxpjRgRVMRsa0zcHWx8VomR+ukAinVdqdP0x9s3+7SpBcC7IQ63HDnfAPZ7ngrCEv967QBYvElaL3ZGdb0i/7O/Nxp8w2GKI91qp0OFsGZ2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WfPwaNje; arc=none smtp.client-ip=101.71.155.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WfPwaNje"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c154e4;
	Tue, 6 Jan 2026 10:18:02 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 02/18] mmc: dw_mmc: Remove dma_ops from struct dw_mci_board
Date: Tue,  6 Jan 2026 10:16:53 +0800
Message-Id: <1767665829-183001-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b9118d4fd09cckunmc69ba49b79b980
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9DT1YfSUNCQhgeQx1DTkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WfPwaNjeg7CRbBbTUlUDSDomKBej1faMgEYuPpom0dUiAXjrZUwmF1m7mScPMRtjTvNrrXAu1ynUENsE43UQf7JN5KWwqLjIPKAUaCbj9EpMN6hSczfxCd4cyyV3Ns5AKYO/v6fFQ259AEbht/rRXzjil/BO9z6chCYpuoHoM5c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=/Hkd00dKjLjT3GDmBusfyjwyWO8SLiLAEF7yIT6nD9M=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

It does take dma_ops from struct dw_mci_board, but we immediately
re-assign it from either dw_mci_idmac_ops or dw_mci_edmac_ops in
dw_mci_init_dma(). That means it's never used now, or has been
broken for a long time without noticed. It seems no drivers need
it, so remove it now.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 1 -
 drivers/mmc/host/dw_mmc.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9491bab..71cbb7e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3366,7 +3366,6 @@ int dw_mci_probe(struct dw_mci *host)
 		goto err_clk_ciu;
 	}
 
-	host->dma_ops = host->pdata->dma_ops;
 	dw_mci_init_dma(host);
 
 	/* Clear the interrupts for the host controller */
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 26efe1a..bf3566a 100644
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
@@ -280,7 +280,6 @@ struct dw_mci_board {
 	u32 detect_delay_ms;
 
 	struct reset_control *rstc;
-	struct dw_mci_dma_ops *dma_ops;
 };
 
 /* Support for longer data read timeout */
-- 
2.7.4

