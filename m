Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C97139D00
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620696; cv=none; b=lkDJU7UdWs3xwD1Mw/OptxVboFRWmsLwVna8LUDM2gVdVw3Z81NchtHagPIUqV/YNQhdbEsRZHmEkQaIXBS5lAi+QDbN5UkUwy8cm2PtEsQ7RKJ46cwhguNlaoVaip7JVX+g3AtsDd8NCQKrQpbxqTI9sYZP/NM0SL5aZVJJJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620696; c=relaxed/simple;
	bh=Vcq5ivy/4arcpKtEy9sfpaIKRnJ8eNktoLFsEXRReg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ebJ39QZQM8N/4UYxKHfjGIGB7Bi36ya/MAqs5QvWHl6oEvo1ircq/W2tLbdhVuXTOwbCLhV4+CVlKGMaRdmju0fZE6joAgiRj8ERwE64D6CMtb/LNeB6Bzvu250lSUKMhL/VGHQGRLZNwWhzCHFmq2vZ1P5ejxYoHmAHP6u2LqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XylJBdQg; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XylJBdQg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723620694; x=1755156694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vcq5ivy/4arcpKtEy9sfpaIKRnJ8eNktoLFsEXRReg0=;
  b=XylJBdQgHVyo0QTym/r7KkZuM2CNwHr3549ycy4hcA/qhfpKEejCEsRo
   em9CLVGl/kY66g3iytTVc9u7iv9eZvtOfexEQYk9BS9kd4cwtODkOACtC
   +3ZgXSPZ1ZWmugUP1FDxf40alnqdnhbL5ADT3jtl7hclQeGPBwVv3ES5E
   //mGGzYThBrti3TdQjYxpcNNtPtqt6IFqRhq58+ZXQImiknLM/eASYO1Q
   KV4IUAv7Bxd8oSmw2Kz25stQ+HEYM0RoYlnTQatSo6/RNfOpwrkZ6cpwc
   ifdTjn9Q7xTezQBTWIPvWmdM1Qo1JGXS+Ywv6PUD1bvmKDPky9/oqUKB/
   w==;
X-CSE-ConnectionGUID: QuPIOuO5QuC8gH/VQZwZXQ==
X-CSE-MsgGUID: HQWDZn3RRZ+Ux8cZhV9u/Q==
X-IronPort-AV: E=Sophos;i="6.09,288,1716220800"; 
   d="scan'208";a="24957200"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 15:31:34 +0800
IronPort-SDR: 66bc4f53_wavPqp7hCMNXzBX4tO34xX9opswdNeWUUknqCzAUHElG/p+
 jL32lkV5kZr5ZSL4FTT//zJxadY4IN4xEdRp9/Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 23:31:48 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 00:31:33 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 04/10] mmc: core: Add open-ended Ext memory addressing
Date: Wed, 14 Aug 2024 10:29:28 +0300
Message-Id: <20240814072934.2559911-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814072934.2559911-1-avri.altman@wdc.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
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
index 2c9963248fcb..1129f4e1a268 100644
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

