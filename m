Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8E198E85
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010695; cv=none; b=IoOX3LRKjQQQCBOf0rWef7Z6aGQ35RF0BQ34YvAgQuW5474gW5gLQBTWMke7pmSyNtbTvyac5vfzTBaQ/TREr21/D9UfCBnxQBhWm9+DkGXMKvp8iT7q5KK8VYUb7ONY0AEEsRH9oSlYGpawjU2JPaMyyn6/0VQc55zz0x7jJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010695; c=relaxed/simple;
	bh=MHFndB2QnUNxORquhxbFIL559YwED7RczyN5weD7NGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ta+FPX1ekuzPw1zC+wt49W9dSNPmkUVblvdXnwUIgiRJOgo5wKI0B7ZI/1Ll4N5kjDHo4vXr9pr6UVLE2/Y/CndazUbEphza36WXCFYP0zrxlsdjL3ne9tF8qbSFQKDa5l0y9SEJkFGhtIv8yPEoLsdaGUUDu6Cm3YtBpvypY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OfcbR8Jp; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OfcbR8Jp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723010693; x=1754546693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MHFndB2QnUNxORquhxbFIL559YwED7RczyN5weD7NGA=;
  b=OfcbR8JpiTYdmfYMqIxZJQPajWdees1Y1meIMvrP7/3iXIhqR5Ss2pEZ
   LH92a//4o4a1J8USPir9D66LSSEfxXMFEKEQA7GcLEOde3DxG704EbgKB
   u29GZ3pTShq0K2cg6olPU9iGSYJItIlrCTqn64+Z3UxyfqholF+sHB0iH
   FdN4V7/5A1LNmGdGxCNcuoH4bgKb1Zx2I5r+r7gvC0EgPyoUGTKt4az0S
   3GjvhYgtETp8m8wqKjY43dP+e9s18zo/lzTn7Q5zG2Hv28Dbj7XsnVvoj
   Br8i/3c5iBfrj6CY/xgEbfhAUTpcXZepZunr9A8pSTBQbdpFqDZSk0v21
   g==;
X-CSE-ConnectionGUID: 5+xjMRaoSK6PQMzp2s5PCw==
X-CSE-MsgGUID: rZJX4PSaQHa6+05pwvOMNg==
X-IronPort-AV: E=Sophos;i="6.09,269,1716220800"; 
   d="scan'208";a="23039305"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2024 14:04:53 +0800
IronPort-SDR: 66b3008b_9PK0d7kqjssOuJNcDLbMPNT1413bdOpEPUiQRBRO5Iacij9
 ghNgzgg3DAfWVmJYegOov5OgZ7LBi35QNGZiCRA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 22:05:15 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 23:04:53 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 04/10] mmc: core: Add open-ended Ext memory addressing
Date: Wed,  7 Aug 2024 09:03:03 +0300
Message-Id: <20240807060309.2403023-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807060309.2403023-1-avri.altman@wdc.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For open-ended read/write - just send CMD22 before issuing the command.
While at it, make sure that the rw command arg is properly casting the
lower 32 bits, as it can be larger now.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 367509b5b646..392621232ad8 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -180,6 +180,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
 static int mmc_spi_err_check(struct mmc_card *card);
 static int mmc_blk_busy_cb(void *cb_data, bool *busy);
+static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -1664,7 +1665,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 
 	brq->mrq.cmd = &brq->cmd;
 
-	brq->cmd.arg = blk_rq_pos(req);
+	brq->cmd.arg = blk_rq_pos(req) & 0xFFFFFFFF;
 	if (!mmc_card_blockaddr(card))
 		brq->cmd.arg <<= 9;
 	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
@@ -1712,6 +1713,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			(do_data_tag ? (1 << 29) : 0);
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		brq->mrq.sbc = &brq->sbc;
+	} else if (mmc_card_is_sduc(card->host)) {
+		mmc_blk_wait_for_idle(mq, card->host);
+		mmc_send_ext_addr(card->host, blk_rq_pos(req));
 	}
 }
 
-- 
2.25.1

