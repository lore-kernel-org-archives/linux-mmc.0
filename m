Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com [45.254.49.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79A4BA9F2;
	Thu, 17 Sep 2026 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639504; cv=none; b=rAaYBUNWDB7d/ZLXF0jjyXe5eA86bGvwPS5m5bWoxuBl7WDSx74szl1xLZ6YxkRKcN6DGDVNu1dMztJRUqLzolNmvJLLvIFOR+ZbfmKfwIi5jyc+2PrHbsoO1plC4n70U4kxNlZ46ad9+7hg7z0LFza1H20l6oESQOpqSWZ1jsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639504; c=relaxed/simple;
	bh=XN48dGpTYdwidGnJPBmKoAFR+QOJxwtxfRmPsyJBTi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OrFtuf3NBOlCebNutDZ+pO/uQWcoovr6UbY5E9mSI45PRhW+iXmXrqZW9FKNsw+0TDDmY+kmLrJKv+xg5QkgE+OqWVFnTzv3qhl/BchmvjdOZn2vjoY/KDbsrPSQ9KFpA8UmolntpDPOWszFn8cksbM222geJNy0qiZrU5o74+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fKyMcQn2; arc=none smtp.client-ip=45.254.49.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fKyMcQn2"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e203484a;
	Thu, 17 Sep 2026 16:48:59 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH 2/3] docs: mmc: fix stale async request documentation
Date: Thu, 17 Sep 2026 16:48:36 +0800
Message-Id: <1789634917-143165-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789634917-143165-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789634917-143165-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0ae8e091003a4kunm476cf0c8983b4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGRodTVZLTElLTk1PQk
	kYH09WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fKyMcQn2a1i8eSBRL8iadsMOe058dmz/CjwIAPtZRS3ADpHyZtDolBmEUq3rfX31tqeq3O8cH6Iwya6aaDzTGbYbSouYESTOw+kuxLBrAPPTbMc6Z6AoTDVoyY/EJbWWIJcU6wyrdPCQplwImmQLDSFlQ8x1kI8UigJ7YYkwOV4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=loyEuDZ5PGTOg02RYKxKU5VNnLeScMXNhADO2TWHIGA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

mmc-async-req.rst still documents interfaces that no longer exist:

 - mmc_start_req() was renamed to mmc_start_areq() by commit c3399ef55d8e
  ("mmc: core: rename mmc_start_req() to *areq()") and then removed together
  with the rest of the asynchronous request machinery when the block driver
  switched to blk-mq, by commits 81196976ed94 ("mmc: block: Add blk-mq support")
  and 126b62700386 ("mmc: core: Remove code no longer needed after the switch to blk-mq").

 - mmc_blk_issue_rw_rq() was removed by commit 0fbfd1251830
   ("mmc: block: Remove code no longer needed after the switch to blk-mq"),
   and was replaced by mmc_blk_mq_issue_rw_rq().

 - The is_first_req argument of the ->pre_req() callback was dropped by
   commit d3c6aac3bdfe ("mmc: delete is_first_req parameter from pre-request callback"),
   so the "Optimize for the first request" section is obsolete as well.

 - The Linaro wiki page holding the IOZone/mmc_test measurements no longer exists.

Update the document to describe the current request lifecycle: mmc_pre_req(),
mmc_start_request(), mmc_wait_for_req() and mmc_post_req()), and drop the sections
describing the long-gone interfaces and the dead link.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 Documentation/driver-api/mmc/mmc-async-req.rst | 64 ++++++--------------------
 1 file changed, 13 insertions(+), 51 deletions(-)

diff --git a/Documentation/driver-api/mmc/mmc-async-req.rst b/Documentation/driver-api/mmc/mmc-async-req.rst
index 0f7197c..d9d4ac7 100644
--- a/Documentation/driver-api/mmc/mmc-async-req.rst
+++ b/Documentation/driver-api/mmc/mmc-async-req.rst
@@ -23,7 +23,7 @@ MMC request.
 MMC block driver
 ================
 
-The mmc_blk_issue_rw_rq() in the MMC block driver is made non-blocking.
+The mmc_blk_mq_issue_rw_rq() in the MMC block driver is made non-blocking.
 
 The increase in throughput is proportional to the time it takes to
 prepare (major part of preparations are dma_map_sg() and dma_unmap_sg())
@@ -34,21 +34,20 @@ platform. In power save mode, when clocks run on a lower frequency, the DMA
 preparation may cost even more. As long as these slower preparations are run
 in parallel with the transfer performance won't be affected.
 
-Details on measurements from IOZone and mmc_test
-================================================
+MMC core API
+============
 
-https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-async-req
+The preparation of a request is separated from starting the transfer, so
+that a host can prepare a request while another one is still in progress:
 
-MMC core API extension
-======================
-
-There is one new public function mmc_start_req().
-
-It starts a new MMC command request for a host. The function isn't
-truly non-blocking. If there is an ongoing async request it waits
-for completion of that request and starts the new one and returns. It
-doesn't wait for the new request to complete. If there is no ongoing
-request it starts the new request and returns immediately.
+ * mmc_pre_req() prepares a request before it is started. It may be called
+   while another request is running on the host.
+ * mmc_start_request() starts a prepared request without waiting for it to
+   complete. mmc_wait_for_req() starts a request and waits for it to
+   complete as well.
+ * mmc_post_req() releases the resources allocated by mmc_pre_req() after
+   the request has completed. It may likewise run while another request is
+   active.
 
 MMC host extensions
 ===================
@@ -59,40 +58,3 @@ to before and after the actual mmc_host_ops.request() function is called.
 
 In the DMA case pre_req() may do dma_map_sg() and prepare the DMA
 descriptor, and post_req() runs the dma_unmap_sg().
-
-Optimize for the first request
-==============================
-
-The first request in a series of requests can't be prepared in parallel
-with the previous transfer, since there is no previous request.
-
-The argument is_first_req in pre_req() indicates that there is no previous
-request. The host driver may optimize for this scenario to minimize
-the performance loss. A way to optimize for this is to split the current
-request in two chunks, prepare the first chunk and start the request,
-and finally prepare the second chunk and start the transfer.
-
-Pseudocode to handle is_first_req scenario with minimal prepare overhead::
-
-  if (is_first_req && req->size > threshold)
-     /* start MMC transfer for the complete transfer size */
-     mmc_start_command(MMC_CMD_TRANSFER_FULL_SIZE);
-
-     /*
-      * Begin to prepare DMA while cmd is being processed by MMC.
-      * The first chunk of the request should take the same time
-      * to prepare as the "MMC process command time".
-      * If prepare time exceeds MMC cmd time
-      * the transfer is delayed, guesstimate max 4k as first chunk size.
-      */
-      prepare_1st_chunk_for_dma(req);
-      /* flush pending desc to the DMAC (dmaengine.h) */
-      dma_issue_pending(req->dma_desc);
-
-      prepare_2nd_chunk_for_dma(req);
-      /*
-       * The second issue_pending should be called before MMC runs out
-       * of the first chunk. If the MMC runs out of the first data chunk
-       * before this call, the transfer is delayed.
-       */
-      dma_issue_pending(req->dma_desc);
-- 
2.7.4

