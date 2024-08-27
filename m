Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD981B3F15
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761548; cv=none; b=K1F38DYMhC/mhOymPBcx/0PkxnJ6jpuupd9NAhCiLKWMexgyCzXD1buBzFjNqNVQ0/KQnmsUZ0g0vHpKzLCgX8Vqr1YjXgygCKoV57od3hYpsk9IsAuyd3jOE3YMr2XTwaYC6DL3KLd/t3w0MIHhKWzK7yFzVgE9rsHRwUDY3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761548; c=relaxed/simple;
	bh=ZLyjzcUKugHnS1Slh2DK9RwpcyMhxM2y8sQJo0560PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTJyLEPydW+olpELpITODGHeNfDx2g2EIklC6MpEfBxt8RcCQIKlDPFwTKnAyn/2jKMajFQXqwZ9QVv5CKE5EB8xpP6A/7uGEmEWz3i678UUQFqvcxQrKhpqlp2eZzENn4Sg9PVgDuNZIIQkEoTEBMK7zldFEm4hhgsbEOr3li0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dlHkAbuN; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dlHkAbuN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761546; x=1756297546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLyjzcUKugHnS1Slh2DK9RwpcyMhxM2y8sQJo0560PQ=;
  b=dlHkAbuNw5Lxs8D13atmZheZ3jc2SIskWqzwX/m8Z4rlFT0eRE9rLKoT
   FonFNMfRVUGKo735GZvCD7DZs3PiF7hKKBpXDGyaUqvEXb2Vc22O6Kt3G
   3tTsBHZ3N+hlO/r8yO05vCr26DOEm+hi6sSncF+jV0dABMQCebxbcAUIb
   5PGf6TAULjRAddzlUjLKwWa9IsUruFeReDJneShFlFlZXXSV13Iu1tlxF
   nsx6OL2FAPdYSgQppby1Y68iZwOZ9uDoA4Xqk+azKYf1X+gS5MlVAxjID
   62/MIRrITqrKb5DJCp32Y3ws9iEh/lgT20cpa5JFCS3DCWyJyl+XzCD+d
   A==;
X-CSE-ConnectionGUID: Gxf0GnUER7uiQ0oqLJTmlQ==
X-CSE-MsgGUID: NiMt7NEyR+eCK8tFyfSN9Q==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="25318694"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:25:46 +0800
IronPort-SDR: 66cdb7b7_1PqbajG1LKyZidell0y/xSctJ0HaG2Q9fUMqdfLr0tOOjSL
 OwQ9v/zDSQHR/nPZw1uEaXG3RaVjfY1f/AGC/6Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:25:44 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:25:45 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 3/9] mmc: core: Add open-ended Ext memory addressing
Date: Tue, 27 Aug 2024 15:23:36 +0300
Message-Id: <20240827122342.3314173-4-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827122342.3314173-1-avri.altman@wdc.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
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

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c9963248fcb..8816b3f0a312 100644
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
+	} else if (mmc_card_ult_capacity(card)) {
+		mmc_blk_wait_for_idle(mq, card->host);
+		mmc_send_ext_addr(card->host, blk_rq_pos(req));
 	}
 }
 
-- 
2.25.1

