Received: from mail-m49247.qiye.163.com (mail-m49247.qiye.163.com [45.254.49.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751EE382399;
	Thu,  9 Apr 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720923; cv=none; b=VmFEwcDR3zBO7U9pHd95rwAkbDTI0Z9WlhLIhmgxHU8zaQr8N0rrdcDbNww9XyDLpVpa4+X6xKK2QoJkQzyUP8kmCkwtdlm/qBjqCSzgqOuFeBx+1yTygo+br6Wo+mRXTFor44Xpk/RPBotqW9dy58iG/CY1iKfa7KLswiX1Wwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720923; c=relaxed/simple;
	bh=7JvyWtnohW2TBYBNq3uaBK4HSb2uSdPyqhKY59UEzrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KpIx8YC8v2HNPA464DeNLJTD2tJLxaKdQ4I3BMncfuMDW5h1g1c+u2c+258urwBoKFcFmwm90nfcPCbbOqsghBjWle7XeE0kwtTOGvBa+09RG9D5zHAPNCsEJqFSFuSd1M2GW6cEJChIVFwuXYbwJs32rUjHFVJADP/4kZkuD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LBXN5buW; arc=none smtp.client-ip=45.254.49.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LBXN5buW"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a14149c6;
	Thu, 9 Apr 2026 15:48:37 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/4] mmc: core: mmc: core: Add validation for host-provided max_segs
Date: Thu,  9 Apr 2026 15:48:11 +0800
Message-Id: <1775720894-97901-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
References: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d7136ea8809cckunm41b60ef14ae51c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5MGFYfGB8dT0geSEIdSUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	tVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=LBXN5buWO6odFUhA7ZL9K7g2bFVoelI0k7gnezL3C9yPciLOc1errz9lvzwvJBSv6473Ca7yR4nMtK2wW56riaPqd6LCGzyJu/QhLRkX5YF1f6SA93zLBh6TRZmRCG24mh5FbN5eNa9Gp7n8VBpr94Zjm7x9oJGetcOqWTI8X8Q=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Vj7st+aaHGCmsECHWtX7z1vecuBHVbFNeFrVua9VPz4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The max_segs field is of type unsigned short, and if a host driver
sets an excessively large value, it may be truncated to zero. This
can cause mmc_alloc_sg() to call kmalloc_objs() with a zero size
allocation request, which leads to undefined behavior.

Under the SLUB allocator, kmalloc(0) returns a special pointer
(ZERO_SIZE_PTR). The subsequent 'if (sg)' check will evaluate to
true, and sg_init_table() will then attempt to access invalid memory,
resulting in a crash:

dwmmc_rockchip 2a310000.mmc: Successfully tuned phase to 133
mmc1: new UHS-I speed SDR104 SDHC card at address aaaa
Unable to handle kernel paging request at virtual address 0000001ffffffff0
Mem abort info:
ESR = 0x0000000096000004
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x04: level 0 translation fault
Data abort info:
ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
CM = 0, WnR = 0, TnD = 0, TagAccess = 0
GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000102c88000
[0000001ffffffff0] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] SMP
Modules linked in:
CPU: 2 UID: 0 PID: 102 Comm: kworker/2:1 Not tainted 7.0.0-rc6-next-20260331-00013-g4d93c25963c5-dirty #80 PREEMPT
Hardware name: Rockchip RK3576 EVB V10 Board (DT)
Workqueue: events_freezable mmc_rescan
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : sg_init_table+0x2c/0x50
lr : sg_init_table+0x24/0x50
sp : ffff8000837db710
x29: ffff8000837db710 x28: 000000000000c000 x27: 0000000000000300
x26: 0000000000000000 x25: 0000000000000040 x24: ffff0000c46a0000
x23: 0000000000000000 x22: ffff0000c0c73c00 x21: 0000000000000010
x20: 0000000000000010 x19: 0000000000000000 x18: 000000000000002c
x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000000
x14: 0000000000000400 x13: ffff8000837dc000 x12: 0000000000000000
x11: ffff0000c0c73ca0 x10: 0000000000000040 x9 : 459ec1f0abbdbb00
x8 : 0000001fffffffe0 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000035579 x4 : 0000000000000901 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000010
Call trace:
sg_init_table+0x2c/0x50 (P)
mmc_mq_init_request+0x64/0x90
blk_mq_alloc_map_and_rqs+0x3ac/0x480
blk_mq_alloc_set_map_and_rqs+0x98/0x1e0
blk_mq_alloc_tag_set+0x1c0/0x290
mmc_init_queue+0x120/0x370
mmc_blk_alloc_req+0x150/0x420

To prevent this, add a validation check in mmc_mq_init_request() to
detect when sg_len (derived from max_segs) is zero. If sg_len is zero,
we return an error and print an error message, allowing host driver
developers to identify and fix incorrect max_segs configuration.

This is a defensive measure that ensures the MMC core fails gracefully
when host drivers provide invalid max_segs values, rather than crashing
with a page fault.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/queue.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 39fcb66..c9028e4 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -214,8 +214,14 @@ static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
 	struct mmc_queue *mq = set->driver_data;
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
+	u16 sg_len = mmc_get_max_segments(host);
 
-	mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), GFP_KERNEL);
+	if (!sg_len) {
+		dev_err(mmc_dev(host), "Wrong max_segs assigned\n");
+		return -EINVAL;
+	}
+
+	mq_rq->sg = mmc_alloc_sg(sg_len, GFP_KERNEL);
 	if (!mq_rq->sg)
 		return -ENOMEM;
 
-- 
2.7.4

