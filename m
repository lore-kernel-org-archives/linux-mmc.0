Received: from mail-m127171.xmail.ntesmail.com (mail-m127171.xmail.ntesmail.com [115.236.127.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A7443AB7;
	Tue, 13 Oct 2026 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884817; cv=none; b=mIqKeMjfUBfWq7mgrzhU8gcDRs+tuDG8BXEiY1eTWamwD4qsd7rMzNUMp4lEBvTmJDAOLQ6bHa20ZU2vpFGDJGJSGcDrEMJ4z7kIp8wTAznnxC89ihEH9c1ZUu4XJsWDr1PrqINfw3CKqmX8FGNU8AGVTEmru+FbWv2JIhm7Hb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884817; c=relaxed/simple;
	bh=O89XV7svBeVyjPdmo+TuW7DnHZUCqlztKlrOkxjIcmM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ovGYjmMsqzvLZgD75SB19vGDzf1R5NcQJV/jnqxlWSku45XjHzqygGSBBrjTOG/BvoRp2jEwPT7Mym2pPLwhN7bCoYLD1D9eGxT0kWc3t+B9V3zWoX4tAHue7oOg1McHl8uyYzy4JoaBXQay/s+t+j7Rmfwzyox/l0Lmdr5xaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=d77y9MJr; arc=none smtp.client-ip=115.236.127.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="d77y9MJr"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 50d7a9cda;
	Tue, 13 Oct 2026 15:24:19 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: enable MMC_CAP_DONE_COMPLETE
Date: Tue, 13 Oct 2026 15:24:04 +0800
Message-Id: <1791876245-190981-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa13425dd6b03a4kunm7c54f86526aae6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGU9LSlZNTUtPHhgYQ0
	1DHh1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=d77y9MJrbFCXB/34+gBE+k4SNmBJx/8cdOyZQ+BNhSsy185lDygfDtI+dzZmj7T5rjgjM1s/R34B2qQ2ta6PLG0O4cke7RMM2mIlYnd6POF9kzxmPpBj7fU9wYdQBkN38S+/bERtG3/klVrra8di6R4f0PQTRFQutM6gcEPk1dQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=h2daLWJxz0IZw/j4LJhOD5iXhaRhQBqXnMTH0Pz7kfM=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

All requests issued by dw_mmc are completed from dw_mci_work_func(),
which runs from the system_bh_wq workqueue. It is therefore preemptible
context and host->lock is dropped before the completion, see
mmc_request_done() in dw_mci_request_end().

The dw_mci_interrupt and the dw_mci_watchdog_fn never call mmc_request_done()
directly. So every request is completed from a sleepable context with no
spinlock held.

This is exactly the contract required by MMC_CAP_DONE_COMPLETE, which was
introduced for hosts that can complete requests within mmc_request_done()
without deferring to the core's complete_work.

Without the flag, the core records the finished request in
mq->complete_req and queues mq->complete_work, i.e. a second workqueue
dispatch plus an extra context switch per request. With the flag,
mmc_blk_mq_req_done() completes the request directly via
mmc_blk_mq_post_req() -> blk_mq_complete_request(), and a following
request completes the previous one inline from mmc_blk_rw_wait().

Measured on an RK3576 SD card (dw_mmc) with:

  perf record -a -g -F 999 -- sleep 30
  perf report --stdio -g graph,0.5,caller

fio: 4k randread, ioengine=libaio

Without the flag, the completion hot path is:

  mmc_request_done -> mmc_blk_mq_req_done -> queue_work_on      (~4.3%)
  ... -> mmc_blk_mq_complete_work            (kworker/5:1H-mm, ~18.4%)
       -> mmc_blk_mq_complete_prev_req -> mmc_blk_mq_post_req

with the flag the workqueue round trip disappears completely: there is no
queue_work_on and no mmc_blk_mq_complete_work in the profile anymore, and
the previous request is completed inline:

  mmc_blk_mq_issue_rq -> mmc_blk_mq_post_req -> mmc_blk_mq_complete_rq
                                                  -> __blk_mq_end_request

This can remove a redundant workqueue dispatch and context switch per completed
request.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ff0b25d..bec777b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2945,6 +2945,8 @@ static int dw_mci_init_host_caps(struct dw_mci *host)
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
+	mmc->caps |= MMC_CAP_DONE_COMPLETE;
+
 	return 0;
 }
 
-- 
2.7.4

