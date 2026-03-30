Received: from mail-m83211.xmail.ntesmail.com (mail-m83211.xmail.ntesmail.com [156.224.83.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48322A817;
	Mon, 30 Mar 2026 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843461; cv=none; b=fw/R1UvX1IpaZR4nYE/CFXTka5h8Mb824bnn5w9Q4eM42AgfGRoeKlZ/Ru62iuFYpUCOAH8VUaLNJcvSA9eYivhXnxrnCxGAFRdzL3LrVMKT4JFLiIfdVKR2rweuCp/rpx+w0UA44wbyndNuKMJwa+5xVFVPGOOfighYHcf2w4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843461; c=relaxed/simple;
	bh=aarrtfUK43Eyg1nC9xtx8OTnJVXNDe2IP6IIoSlyeZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fmjprhtSp01K2X+At+rt1mNd9jSglR80Hn6oAv8ZRWMSwPzF3aKHtq6msriOhpeBfpcHQGzY1T3tfCNgzUQ8UhDLN+6CUAnprAEGiTmFZ6JWStoimStEuQSmzPSSkxJzOFABWe+48PxS+ywLm0QXhssudvCp0URYmCUo5D0b+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JCav2phY; arc=none smtp.client-ip=156.224.83.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JCav2phY"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38c2332b6;
	Mon, 30 Mar 2026 11:28:44 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/4] mmc: core: Replace the hard-coded shift value 9 with SECTOR_SHIFT
Date: Mon, 30 Mar 2026 11:28:29 +0800
Message-Id: <1774841312-92409-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d3cc9624409cckunmd82a3513dfee39
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1DQ1ZKGB0fGUlIHkgdSR1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JCav2phYTlQbNVK3eZyY4SazB4gMLZEX2ax363o/1KrcBkwdoxi9tJUIJIVjEOTJoR5KKxGksZ70x32pcfXbAlrln/iEQc+AmZsDjmJI3UmX6vuZFmHX+HqnrjkRnfxuYAYkGVdmZDQyvCpQRXLkMN1ffegnAR07fekyGvvERJA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=olYKjp1DeC2VMXdGqwr4sopBWXnXbK9QYUsln8LALS4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

These shift-by-9 operations are for converting between bytes and sectors.
Use the SECTOR_SHIFT macro to improve code readability and maintainability.

No functional changes intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/block.c | 8 ++++----
 drivers/mmc/core/core.c  | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index db8c99c..5032f7a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1458,7 +1458,7 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		 * sectors can be read successfully.
 		 */
 		if (recovery_mode)
-			brq->data.blocks = queue_physical_block_size(mq->queue) >> 9;
+			brq->data.blocks = queue_physical_block_size(mq->queue) >> SECTOR_SHIFT;
 
 		/*
 		 * Some controllers have HW issues while operating
@@ -1976,7 +1976,7 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 	}
 
 	if (rq_data_dir(req) == READ && brq->data.blocks >
-			queue_physical_block_size(mq->queue) >> 9) {
+			queue_physical_block_size(mq->queue) >> SECTOR_SHIFT) {
 		/* Read one (native) sector at a time */
 		mmc_blk_read_single(mq, req);
 		return;
@@ -3025,14 +3025,14 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 			 */
 			ret = mmc_blk_alloc_rpmb_part(card, md,
 				card->part[idx].part_cfg,
-				card->part[idx].size >> 9,
+				card->part[idx].size >> SECTOR_SHIFT,
 				card->part[idx].name);
 			if (ret)
 				return ret;
 		} else if (card->part[idx].size) {
 			ret = mmc_blk_alloc_part(card, md,
 				card->part[idx].part_cfg,
-				card->part[idx].size >> 9,
+				card->part[idx].size >> SECTOR_SHIFT,
 				card->part[idx].force_ro,
 				card->part[idx].name,
 				card->part[idx].area_type);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 860378b..29e80e5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -97,7 +97,8 @@ static void mmc_should_fail_request(struct mmc_host *host,
 		return;
 
 	data->error = data_errors[get_random_u32_below(ARRAY_SIZE(data_errors))];
-	data->bytes_xfered = get_random_u32_below(data->bytes_xfered >> 9) << 9;
+	data->bytes_xfered = get_random_u32_below(data->bytes_xfered >> SECTOR_SHIFT)
+						  << SECTOR_SHIFT;
 }
 
 #else /* CONFIG_FAIL_MMC_REQUEST */
-- 
2.7.4

