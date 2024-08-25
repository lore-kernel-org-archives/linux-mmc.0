Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9517C64
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571810; cv=none; b=dx8WSVulkPsEbMHoQu6NFWZtWc0y4MkpDGs9k0l9gf2pAqUhqw+gOeUbSP2xUqqhynjIRdb7YAj7C8jdJ9uCdCgb8hGMM7z0zzaMiDllTSBxU9240uFRenqjepNlNM9f9AXvtW9zNQ4IYDsTycBS4FYCpI0BqFpP0RgEdH0ooQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571810; c=relaxed/simple;
	bh=ZLyjzcUKugHnS1Slh2DK9RwpcyMhxM2y8sQJo0560PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xq9PQqNj26RG13UNca1LDMYq6lNYE+Zapq2JvtIemkytP59u0o+dfu0hmhjFkCPyyvRjvGA0+aHIXz5BodQGPhZUct+i6DPJc6v+X5fWx7epWbFEZCA7H3feGGV3nDRxtgzcsrhuY3VoQAlrYo0ekgnPoaqWuk0f/xNCTwKkZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V4Cbf5uU; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V4Cbf5uU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571809; x=1756107809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLyjzcUKugHnS1Slh2DK9RwpcyMhxM2y8sQJo0560PQ=;
  b=V4Cbf5uUdfXmM3HVOwhPloNZnTH6FYX0p0sp5R6dBjPjLIT3KtLHlyiR
   LFnwOxBTP8szsZugnQJ1tZz7xBBh+B2Kh6EbUdxrufvZC6abZv3PAa9i3
   zRDa0YWsg0glmO8vBF5Nv4y6HK6NdMXYu646Zdzffb5N6Z0IKR2y4ZUed
   2crsUiLi7mmm4nc4pBYumNfMK+rtUJrJMvg/nz4EwWMxNF4r5DUjFbVdE
   Tns63KPjmIJtNaREGlZUmVkStbabQUWlpnUUVWMxJKvCuOObhYHeJUl9H
   OCma6tSErQCSVTxcs3AldvEOhcZwNT/APdaqG/dr/X0eKtVetDcsq4UBn
   A==;
X-CSE-ConnectionGUID: +x/4owbORZiZJ96UfZIcBQ==
X-CSE-MsgGUID: n1Ex2Hj2S/iqg3+fTIi9Tw==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25100420"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:28 +0800
IronPort-SDR: 66cad3e3_RpRV0AlzxoLaw03vSD+6dRLZ0LnneBxyPo4zl4YkLUeQvSj
 +EuFcJYsmQ2fPABwPVfYKEJFL3gA1MtxddtWscA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:49:08 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:26 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 3/9] mmc: core: Add open-ended Ext memory addressing
Date: Sun, 25 Aug 2024 10:41:35 +0300
Message-Id: <20240825074141.3171549-4-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240825074141.3171549-1-avri.altman@wdc.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
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

